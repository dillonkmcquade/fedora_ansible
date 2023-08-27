#!/bin/sh
# This script is for automating installation of programs and repositories for Fedora on a fresh install.

read -r "Press y to start: " yesno
if [ "$yesno" != "y" ]
then
    echo 'Exiting program...'
    sleep 1
    exit
fi

read -r "Update Repos? [y/N]:" starrt
if [ "$starrt" = "y" ]
then
    sudo dnf update -y
    echo 'Update Successful'
    sleep 2
else
    echo 'Not updating repos.'
    sleep 2
fi

echo "Adding third-party repositories"
echo 'Adding RPM fusion and proton repos'
sudo dnf install -y -q 'https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm https://protonvpn.com/download/protonvpn-stable-release-1.0.1-1.noarch.rpm' >/dev/null 2>&1

echo 'Adding Brave repository'
sudo dnf config-manager -y --add-repo 'https://brave-browser-rpm-release.s3.brave.com/x86_64/' >/dev/null 2>&1
sudo rpm --import 'https://brave-browser-rpm-release.s3.brave.com/brave-core.asc' >/dev/null 2>&1

echo 'Downloading core programs'
while IFS= read -r line;do
    echo "Installing $line"
    sudo dnf install -y -q "$line" >/dev/null 2>&1 && echo "$line installed successfully." || echo "Failed to install $line"
done < "programs.txt"
echo "Core programs installed."

echo "Copying configurations"
cp -r "$(pwd)/tmux" "$XDG_CONFIG_HOME/"
cp -r "$(pwd)/nvim" "$XDG_CONFIG_HOME/"
cp -r "$(pwd)/lf" "$XDG_CONFIG_HOME/"
mkdir "$XDG_CONFIG_HOME/zsh"
cp -r "$(pwd)/zsh" "$XDG_CONFIG_HOME/"
ln -sf "$XDG_CONFIG_HOME/zsh/.zshrc" "/home/$USER/.zshrc"
