#!/bin/bash

#my fedora installation script
#===============#
#improve dnf performance
echo 'max_parallel_downloads=10
fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf > /dev/null
#===============#

#===============#
#remove gnome apps
sudo dnf remove gnome-tour totem -y
#===============#

#===============#
#upgrade the system
sudo dnf upgrade -y 
#===============#

#===============#
#add rpmfusion repos
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf groupupdate core -y
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y
#===============#

#===============#
#install native packages 
sudo dnf install akmods neofetch pandoc btop podman mc texlive-scheme-basic wireguard-tools gnome-tweaks gnome-console gnome-themes-extra adw-gtk3-theme -y
#===============#

#===============#
#remove gnome-boxes and install cockpit
sudo dnf remove gnome-boxes -y
sudo dnf install cockpit cockpit-machines libvirt virt-viewer -y
sudo systemctl enable libvirtd
#===============#

#===============#
#remove native ff and libreoffice packages to replace them with flatpaks
sudo dnf remove firefox *libreoffice* -y
#===============#

#===============#
#swap nano to vim
sudo dnf swap nano-default-editor vim-default-editor -y
#===============#

#===============#
#import vscode repo and install code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code -y
#===============#

#===============#
#install flatpaks
flatpak update -y
flatpak install flathub com.brave.Browser org.mozilla.firefox org.libreoffice.LibreOffice com.mattjakeman.ExtensionManager com.bitwarden.desktop com.github.tchx84.Flatseal org.qbittorrent.qBittorrent com.usebottles.bottles org.telegram.desktop com.github.micahflee.torbrowser-launcher io.mpv.Mpv com.discordapp.Discord -y
#===============#

#===============#
#configure vim
echo "set nocompatible
filetype on
filetype plugin indent on
set title
syntax on
set number relativenumber
set ts=4 sw=4" > ~/.vimrc
#===============#

#===============#
#restart the system
reboot
#===============#
