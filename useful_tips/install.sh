#!/bin/bash

#Install default packages after installing base Fedora without GUI
#It's not the full list any time fill free to add some packages
#X11 version

#Xorg display server
sudo dnf install -y xorg-x11-drv-amdgpu
sudo dnf install -y xrandr xorg-x11-server-Xorg xinit

#Qtile requerments
sudo dnf install -y pango-devel
sudo dnf install -y python3-pip
pip install wheel
sudo dnf install -y dnf-plugins-core
sudo dnf copr enable -y frostyx/qtile

#Qtile
sudo dnf install -y qtile

#Display manager
sudo dnf install -y lightdm
sudo dnf install -y slick-greeter
sudo systemctl enable lightdm.service
sudo systemctl set-default graphical.target

#Default programs
sudo dnf install -y firefox
sudo dnf install -y kitty
sudo dnf install -y nemo
sudo dnf install -y lxappearance
sudo dnf install -y picom
sudo dnf install -y fastfetch
sudo dnf install -y nitrogen
sudo dnf install -y rofi
sudo dnf install -y fzf
sudo dnf install -y zoxide
sudo dnf install -y btop
sudo dnf install -y blueman
sudo dnf install -y dunst
sudo dnf install -y xpad
