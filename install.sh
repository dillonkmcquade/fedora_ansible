#!/bin/sh
# This script is for automating installation of programs and repositories for Fedora on a fresh install.

read -p "Have you created an ssh key and uploaded it to github? [y/N]: " hasKey
if [ $hasKey != "y" ]; then
    echo "Exiting, configure ssh with github first."
    exit 1
fi

sudo dnf install -y git

echo "Adding third-party repositories"
echo "Adding RPM fusion and proton repos"
sudo dnf install -y "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
sudo dnf install -y "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
sudo dnf install -y "https://repo.protonvpn.com/fedora-$(rpm -E %fedora)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.1-2.noarch.rpm"

echo 'Adding Brave repository'
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager -y --add-repo "https://brave-browser-rpm-release.s3.brave.com/x86_64/"
sudo rpm --import "https://brave-browser-rpm-release.s3.brave.com/brave-core.asc"

echo "Adding docker repository"
sudo dnf config-manager --add-repo "https://download.docker.com/linux/fedora/docker-ce.repo"

echo "Enabling lazygit copr repo"
sudo dnf copr enable atim/lazygit -y

echo 'Downloading core programs'
xargs --arg-file=./programs.txt --delim='\n' sudo dnf install -y

echo "Copying configurations to their new home"
cp -r tmux "/home/$USER/.config/"
cp -r lf "/home/$USER/.config/"
mkdir "/home/$USER/.config/zsh"
cp .zshrc "/home/$USER/.config/zsh"
ln -sf "/home/$USER/.config/zsh/.zshrc" "/home/$USER/.zshrc"

echo "installing pyenv"
curl "https://pyenv.run" | bash

echo "cloning nvim"
git clone "git@github.com:dillonkmcquade/nvim.git" "/home/$USER/.config/nvim"

alternatives --config java

echo "installing ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
