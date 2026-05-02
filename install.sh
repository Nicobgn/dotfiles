#!/bin/sh
# Copy references to .config
TO_REFERENCE="hypr,nvim,waybar,wezterm,dunst,fastfetch,locale.conf,rofi"

sudo pacman -Syu --noconfirm
sudo pacman -S \
    fastfetch \
    waybar \
    rustup 

rustup default stable

# Install fonts
echo "Installing fonts"
mkdir -p "$HOME/.local/share/fonts"
sudo pacman -S --noconfirm --needed ttf-jetbrains-mono-nerd ttf-jetbrains-mono otf-font-awesome ttf-nerd-fonts-symbols  

# Install configs
for i in $(echo $TO_REFERENCE | tr "," "\n"); do
    if [ -d "$HOME/.config/$i" ]; then
        echo "Backing up existing $i config to $HOME/.config/${i}_backup"
        mv "$HOME/.config/$i" "$HOME/.config/${i}_backup"
    fi
    echo "Creating directory, symbolic, relative link for $i config"
    ln -dsr "$(pwd)/$i" "$HOME/.config/$i"
done

# Installing custom scripts
mkdir -p "$HOME/.local/bin"
ln -sr "$(pwd)/scripts/*" "$HOME/.local/bin/"

echo "export PATH=\"$PATH:$HOME/.local/bin\"" >> "$HOME/.zshrc"

# Yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

