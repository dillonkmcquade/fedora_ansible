#!/bin/sh

#
# This script is for automating installation of programs and repositories for Fedora and
# speeding up the uptime on a fresh install.
# Check comments for optional installs.
#
if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root"
        exit 1
fi
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
        dnf update -y 
        echo 'Update Successful'
        sleep 2
else 
        echo 'Not updating repos.'
        sleep 2
fi

mv $HOME/config-files/* $HOME/.config
mv $HOME/.config/.zshrc $HOME/.zshrc

echo 'Downloading programs......'
#Download brave browser
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc


#Download essential programs
while IFS= read -r line;do
    echo "Installing $line"
    dnf install -y -q $line
    echo "$line Installed successfully."
done < "programs.txt"
echo "
Complete"

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
