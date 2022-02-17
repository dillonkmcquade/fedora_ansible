#!/bin/sh
# This script is for automating installation of programs and repositories for Fedora and
# speeding up the uptime on a fresh install.

if [[ $EUID -ne 0 ]]; then
        echo "Error: This script must be run with superuser privileges. Re-run command with sudo."
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

echo 'Downloading programs......'
#Download brave browser
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

#Download essential programs
while IFS= read -r line;do
    echo "Installing $line"
    [ -d "./$line" ] && cp ./$line $HOME/.config/$line && echo "Sorting config files for $line"
    [ -f "./.${line}rc" ] && cp ./.${line}rc $HOME/.${line}rc && echo "Sorting $line to home directory"
    dnf install -y -q $line
    echo "$line Installed successfully."
done < "programs.txt"
echo "
Core programs installed."

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
