#!/bin/sh
# This script is for automating installation of programs and repositories for Fedora on a fresh install.

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

echo "Adding third-party repositories"
sleep 1
echo 'Adding RPM fusion and proton repos'
sudo dnf install -y -q https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm https://protonvpn.com/download/protonvpn-stable-release-1.0.1-1.noarch.rpm >/dev/null 2>&1

echo 'Adding Brave repository'
sudo dnf config-manager -y --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ >/dev/null 2>&1
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc >/dev/null 2>&1

echo 'Downloading core programs'
while IFS= read -r line;do
    echo "Installing $line"
    [ -d "~/config-files/$line" ] && cp -r "~/config-files/$line" "~/.config/$line" && echo "Sorting config files for $line" || echo 'Failed to copy config files'
    [ -f "~/config-files/.${line}rc" ] && cp "~/config-files/.${line}rc" "~/.${line}rc" && echo "Sorting $line to home directory" || echo "Failed to copy config files"
    if [ "$line" == "neovim" ]; then
            cp -r "~/config-files/nvim" "~/.config/nvim" && echo "Copying $line to .config/"
        fi
    sudo dnf install -y -q $line >/dev/null 2>&1 && echo "$line installed successfully." || echo "Failed to install $line"
done < "programs.txt"
echo "
Core programs installed."

#Set gtk-theme to dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

#Reboot system
read -p 'Finished. Reboot now? [y/N]: ' reboot
if [ "$reboot" != "y" ]
then
        echo 'Complete.'
        exit
else
        echo 'Rebooting in 5'
        sleep 5
        reboot
fi
