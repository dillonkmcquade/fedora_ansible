#!/bin/sh
# This script is for automating installation of programs and repositories for Fedora on a fresh install.

read -p "Press y to start: " yesno
if [ "$yesno" != "y" ]
then
    echo 'Exiting program...'
    sleep 1
    exit
fi

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
echo 'Adding RPM fusion and proton repos'
sudo dnf install -y -q https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm https://protonvpn.com/download/protonvpn-stable-release-1.0.1-1.noarch.rpm >/dev/null 2>&1

echo 'Adding Brave repository'
sudo dnf config-manager -y --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ >/dev/null 2>&1
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc >/dev/null 2>&1

echo 'Downloading core programs'
while IFS= read -r line;do
    echo "Installing $line"
    sudo dnf install -y -q $line >/dev/null 2>&1 && echo "$line installed successfully." || echo "Failed to install $line"
done < "programs.txt"
echo "Core programs installed."

echo "Installing packer"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Copying configurations"
cp -r $(pwd)/tmux /home/$USER/.config/
cp -r $(pwd)/nvim /home/$USER/.config/
cp -r $(pwd)/lf /home/$USER/.config/
mkdir /home/$USER/.config/zsh
cp -r $(pwd)/zsh /home/$USER/.config/
ln -sf /home/$USER/.config/zsh/.zshrc /home/$USER/.zshrc
