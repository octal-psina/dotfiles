#resolution 4 desktop and display manager
desktop:
https://docs.qtile.org/en/latest/manual/config/hooks.html#autostart
need to create file: .config/qtile/autostar.sh
chenge mode: chmod +x .config/qtile/autostar.sh
and add output from xrandr example:
xrandr --output Virtual-1 --mode 1920x1080

display manager:
https://askubuntu.com/questions/73804/wrong-login-screen-resolution
need to copy 
.config/qtile/autostar.sh
into
usr/share/lightdm.sh
then uncoment line kinda like "start script" into etc/lightdm/lightdm.conf

keyboard layout:
in /etc/X11/xorg.conf.d/00-keyboard.conf looks like that:

Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us,ru"
        Option "XkbOptions" "grp:alt_shift_toggle"
EndSection

If use super+space its conflicted with qtile layout.
in qtile/config.py widget made acording to official documintation,
also in the qtile directory is a script wich alow switch betwin kboard layout
it should start with every lazy restart!


Android mtpfs connection (file transfer):

In terminal:
sudo dnf install jmtpfs
mkdir mtp
chmod +777 mtp
jmtpfs ~/mtp/
Documentation:
https://github.com/JasonFerrara/jmtpfs/blob/master/README





