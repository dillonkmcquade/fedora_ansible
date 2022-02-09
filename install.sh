#!/bin/sh

#
# This script is for automating installation of programs and repositories for Fedora and
# speeding up the uptime on a fresh install.
# Check comments for optional installs.
#

echo '
---------------------------------------------------------------------------

Starting Dillons Fedora bootstrapping script

---------------------------------------------------------------------------

Beginning installscript............

'
read -p "Press y to start: " yesno
if [ "$yesno" != "y" ]
then
        echo 'Exiting program...'
        sleep 1
        exit
fi
echo '
------------------------------------------------------------------------
'
read -p "Update Repos? [y/N]:" starrt
if [ "$starrt" == "y" ]
then
        sudo dnf update -y 
        echo 'Update Successful'
        sleep 2
else 
        echo 'Not updating repos.'
        sleep 2
fi

echo 'Adding RPM Fusion repos'
#Enable RPM Fusion repositories
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://protonvpn.com/download/protonvpn-stable-release-1.0.1-1.noarch.rpm

mv $HOME/config-files/* $HOME/.config
mv $HOME/.config/.zshrc $HOME/.zshrc

echo 'Downloading programs......'
#Download brave browser
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install -y brave-browser


#Download essential programs
dnf install -y -q neovim zsh neomutt newsboat protonvpn libappindicator-gtk3 gnome-tweaks gnome-shell-extension-appindicator tlp tlp-rdw mpv sxiv zathura seahorse-nautilus htop nmtui lf qbittorrent libva libva-utils libva-intel-driver lynx foot

#start power-management
tlp start

#Set gtk-theme to dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

#Reboot system
read -p 'Reboot now? [y/N]: ' reboot
if [ "$reboot" != "y" ]
then
        echo 'complete.'
        exit
else
        echo 'rebooting in 5'
        sleep 5
        reboot
fi
