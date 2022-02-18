#!/bin/sh
# This script is for automating installation of programs and repositories for Fedora and
# speeding up the uptime on a fresh install.

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

echo 'adding RPM fusion and proton repos'
sudo dnf install -y -q https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm https://protonvpn.com/download/protonvpn-stable-release-1.0.1-1.noarch.rpm

echo 'Downloading programs......'
#Download brave browser
sudo dnf config-manager -y --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf copr -y enable flatcap/neomutt
#Download essential programs
while IFS= read -r line;do
    echo "Installing $line"
    [ -d "/home/$USER/config-files/$line" ] && cp -r "/home/$USER/config-files/$line" "/home/$USER/.config/$line" && echo "Sorting config files for $line"
    [ -f "/home/$USER/config-files/.${line}rc" ] && cp "/home/$USER/config-files/.${line}rc" "/home/$USER/.${line}rc" && echo "Sorting $line to home directory"
    if [ "$line" == "neovim" ]; then
            cp -r "/home/$USER/config-files/nvim" "$HOME/.config/nvim"
        fi
    sudo dnf install -y -q $line
done < "programs.txt"
echo "
Core programs installed."

#start power-management
sudo tlp start

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
