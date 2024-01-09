#!/bin/sh
# This script is for automating installation of programs and repositories for Fedora on a fresh install.

# verify that ssh is enabled with github
ssh -T git@github.com || { echo 'ssh not setup with github'; exit 1; }

if ! command -v git
then
    sudo dnf install -y git
fi

echo "Adding third-party repositories"
sudo dnf install -y \
    "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
    "https://repo.protonvpn.com/fedora-$(rpm -E %fedora)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.1-2.noarch.rpm" \
    dnf-plugins-core

echo 'Adding Brave repository'
sudo dnf config-manager -y --add-repo "https://brave-browser-rpm-release.s3.brave.com/x86_64/"
sudo rpm --import "https://brave-browser-rpm-release.s3.brave.com/brave-core.asc"

echo "Adding docker repository"
sudo dnf config-manager --add-repo "https://download.docker.com/linux/fedora/docker-ce.repo"

echo "Enabling lazygit copr repo"
sudo dnf copr enable atim/lazygit -y

echo 'Downloading core programs'
xargs --arg-file=./programs.txt --delim='\n' sudo dnf install -y

echo "Copying configurations to their new home"
cp ./.zshrc "/home/$USER/.zshrc"

if ! command -v parallel
then
    sudo dnf install -y parallel
fi

parallel git clone ::: \
    "git@github.com:dillonkmcquade/nvim.git" \
    "git@github.com:dillonkmcquade/tmux.git" \
    "git@github.com:dillonkmcquade/lf.git" \
    ::: \
    "/home/$USER/.config/nvim" \
    "/home/$USER/.config/tmux" \
    "/home/$USER/.config/lf"


echo "installing pyenv"
curl "https://pyenv.run" | bash

alternatives --config java

echo "installing ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
