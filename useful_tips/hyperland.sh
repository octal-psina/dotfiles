#!/usr/bin/env bash
set -Eeuo pipefail

# Fedora 44 + Hyprland
# HP 15s-eq2021ur
# AMD Ryzen 5 5500U / Radeon Lucienne / Intel AX200
# LightDM + Slick-Greeter

trap 'echo "ОШИБКА: строка ${LINENO}. Установка прервана." >&2' ERR

# --------------------------------------------------
# 1. Проверки
# --------------------------------------------------

if [[ $EUID -ne 0 ]]; then
    echo "Запусти скрипт: sudo bash install-hyprland.sh" >&2
    exit 1
fi

if [[ -z "${SUDO_USER:-}" || "$SUDO_USER" == "root" ]]; then
    echo "Запускай скрипт из обычной учётной записи через sudo." >&2
    exit 1
fi

TARGET_USER="$SUDO_USER"
USER_ENTRY="$(getent passwd "$TARGET_USER")"
USER_HOME="$(cut -d: -f6 <<< "$USER_ENTRY")"
USER_GROUP="$(id -gn "$TARGET_USER")"

if [[ -z "$USER_HOME" || ! -d "$USER_HOME" ]]; then
    echo "Не удалось определить домашний каталог пользователя." >&2
    exit 1
fi

if ! grep -q '^Fedora release 44' /etc/fedora-release; then
    echo "Предупреждение: скрипт рассчитан на Fedora 44."
    read -r -p "Продолжить? [y/N] " answer
    [[ "$answer" =~ ^[Yy]$ ]] || exit 1
fi

echo "=========================================="
echo " Fedora + Hyprland"
echo " Пользователь: $TARGET_USER"
echo " Домашний каталог: $USER_HOME"
echo "=========================================="

# --------------------------------------------------
# 2. Подготовка DNF и репозиториев
# --------------------------------------------------

echo "[1/8] Установка инструментов DNF..."

dnf install -y dnf-plugins-core

echo "[2/8] Подключение COPR Hyprland..."

dnf copr enable -y lionheartp/Hyprland

echo "[3/8] Подключение LibreWolf..."

dnf config-manager addrepo \
    --from-repofile=https://repo.librewolf.net/librewolf.repo

echo "[4/8] Обновление системы..."

dnf upgrade --refresh -y

# --------------------------------------------------
# 3. Основные пакеты
# --------------------------------------------------

CORE_PACKAGES=(
    # Hyprland и Wayland
    hyprland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xorg-x11-server-Xwayland

    # Графика AMD
    mesa-dri-drivers
    mesa-vulkan-drivers
    vulkan-loader

    # Терминал и панель
    kitty
    kitty-terminfo
    neovim
    waybar
    wofi

    # Снимки экрана и буфер обмена
    grim
    slurp
    wl-clipboard

    # Звук
    pipewire
    pipewire-pulseaudio
    wireplumber

    # Сеть и Bluetooth
    NetworkManager
    NetworkManager-wifi
    NetworkManager-applet
    bluez
    blueman

    # Файловый менеджер
    thunar
    thunar-volman
    tumbler
    gvfs
    gvfs-mtp
    gvfs-afc
    file-roller

    # Системные инструменты
    brightnessctl
    upower
    xdg-utils
    xdg-user-dirs
    polkit-gnome
    mako

    # Шрифты
    fontconfig
    google-noto-sans-fonts
    google-noto-emoji-fonts

    # Браузер
    librewolf
)

echo "[5/8] Установка основных пакетов..."

dnf install -y "${CORE_PACKAGES[@]}"

# --------------------------------------------------
# 4. Необязательные пакеты
# --------------------------------------------------

OPTIONAL_PACKAGES=(
    hyprpaper
    hyprlock
    hypridle
    hyprlauncher
    nwg-displays
    nwg-look

    # LightDM и экран входа
    lightdm
    slick-greeter
    lightdm-settings

    # Плагины Thunar и предпросмотр
    thunar-media-tags-plugin
    thunar-shares-plugin
    thunar-vcs-plugin
    thunar-archive-plugin
    ffmpegthumbnailer
    poppler-glib
    libgsf
    libopenraw
    libgepub
    gvfs-smb

    # Архивы
    unzip
    7zip
)

echo "[6/8] Установка дополнительных пакетов..."

for pkg in "${OPTIONAL_PACKAGES[@]}"; do
    if dnf install -y "$pkg"; then
        echo "[OK] $pkg"
    else
        echo "[ПРОПУСК] $pkg недоступен или не установился."
    fi
done

# --------------------------------------------------
# 5. Пользовательские каталоги
# --------------------------------------------------

echo "[7/8] Создание пользовательских каталогов..."

USER_DIRS=(
    "$USER_HOME/Documents"
    "$USER_HOME/Downloads"
    "$USER_HOME/Pictures"
    "$USER_HOME/Pictures/Screenshots"
    "$USER_HOME/Music"
    "$USER_HOME/Videos"
    "$USER_HOME/.config/hypr"
)

for dir in "${USER_DIRS[@]}"; do
    mkdir -p "$dir"
    chown "$TARGET_USER:$USER_GROUP" "$dir"
done

runuser -u "$TARGET_USER" -- \
    xdg-user-dirs-update --force || true

# --------------------------------------------------
# 6. Базовая конфигурация Hyprland
# --------------------------------------------------

HYPR_CONFIG="$USER_HOME/.config/hypr/hyprland.conf"

if [[ ! -f "$HYPR_CONFIG" ]]; then
    cat > "$HYPR_CONFIG" <<'HYPR_EOF'
$terminal = kitty
$fileManager = thunar
$menu = wofi --show drun
$mainMod = SUPER

monitor = ,preferred,auto,1

env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORM,wayland

exec-once = waybar
exec-once = mako
exec-once = nm-applet --indicator
exec-once = /usr/libexec/polkit-gnome-authentication-agent-1

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
}

decoration {
    rounding = 8
}

input {
    kb_layout = us,ru
    kb_options = grp:alt_shift_toggle
    follow_mouse = 1
    touchpad {
        natural_scroll = true
        tap-to-click = true
        drag_lock = true
    }
}

bind = $mainMod, Return, exec, $terminal
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, D, exec, $menu
bind = $mainMod, Q, killactive
bind = $mainMod, F, fullscreen
bind = $mainMod, V, togglefloating
bind = $mainMod SHIFT, E, exit

# Переключение рабочих столов
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4

# Перемещение окон между рабочими столами
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4

# Снимок выделенной области
bind = , Print, exec, grim -g "$(slurp)" "$HOME/Pictures/Screenshots/$(date +%F_%H-%M-%S).png"
HYPR_EOF

    chown "$TARGET_USER:$USER_GROUP" "$HYPR_CONFIG"
fi

# --------------------------------------------------
# 7. Настройка LightDM + Slick-Greeter
# --------------------------------------------------

echo "[8/8] Настройка дисплейного менеджера..."

SESSION_FILE="/usr/share/wayland-sessions/hyprland.desktop"

if ! rpm -q lightdm >/dev/null 2>&1 ||
   ! rpm -q slick-greeter >/dev/null 2>&1; then
    echo "LightDM или Slick-Greeter не установлен."
    echo "Оставляю текущий дисплейный менеджер без изменений."
else
    mkdir -p /etc/lightdm/lightdm.conf.d

    cat > /etc/lightdm/lightdm.conf.d/50-hyprland.conf <<'LIGHTDM_EOF'
[Seat:*]
user-session=hyprland
greeter-session=slick-greeter
LIGHTDM_EOF

    if [[ -f "$SESSION_FILE" ]]; then
        systemctl disable gdm.service 2>/dev/null || true
        systemctl enable lightdm.service
    else
        echo "Не найден файл сессии: $SESSION_FILE"
        echo "LightDM не переключён. Проверь пакет Hyprland."
    fi
fi

# --------------------------------------------------
# 8. Системные службы
# --------------------------------------------------

systemctl enable NetworkManager.service
systemctl enable bluetooth.service
systemctl set-default graphical.target

echo
echo "=========================================="
echo " Установка завершена."
echo "=========================================="
echo
echo "Проверь файл:"
echo "$HYPR_CONFIG"
echo
echo "Перед перезагрузкой проверь, что LightDM"
echo "и сессия Hyprland установлены."
echo
echo "Перезагрузка: sudo reboot"