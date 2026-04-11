#!/bin/bash

# Check if current user is root
if [ "$UID" -eq 0 ]; then
    echo "Cannot run as root."
    exit 1
else
    # Checks for sudo
    if [ -n "$SUDO_USER" ]; then
        echo "Do not use sudo"
        exit 1
    fi
fi

echo "
██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗ ██████╗ ██╗    ██╗███╗   ███╗
██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔══██╗██║    ██║████╗ ████║
███████║███████║██║     █████╔╝ █████╗  ██████╔╝██████╔╝██║ █╗ ██║██╔████╔██║
██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗██╔═══╝ ██║███╗██║██║╚██╔╝██║
██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║██║     ╚███╔███╔╝██║ ╚═╝ ██║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝      ╚══╝╚══╝ ╚═╝     ╚═╝
"
echo -e "\thackerpwm - Hacker environment automation script."
echo -e "\t\tAldayr Ruiz (Aka. xSmaky)"
echo -e "\nInstallation will begin soon..\n"
sleep 5

RPATH=`pwd`

# update and upgrade all
echo "Upgrading system..."
sudo apt update && sudo apt -y full-upgrade

echo "Installing dependencies..."
sudo apt install -y git vim feh scrot scrub zsh rofi xclip xsel locate fastfetch wmname acpi cmatrix
sudo apt install -y bspwm sxhkd polybar picom
sudo apt install -y unison imagemagick font-manager ranger kitty tmux lsd bat neovim duf fzf 

# install fonts
echo "Installing Hack font..."
mkdir /tmp/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip -O /tmp/fonts/Hack.zip
unzip /tmp/fonts/Hack.zip -d /tmp/fonts
font-manager -i /tmp/fonts/*.ttf

# install ohmyzsh
#rm -rf ~/.oh-my-zsh
#yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## install zsh plugins
#git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#rm -f ~/.zshrc

# .tmux
echo "Installing tmux configuration..."
rm -rf ~/.tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/
cp -v $RPATH/configs/.tmux.conf.local ~/.tmux.conf.local


# nvchad - needs work. Block cursor and user interaction
# git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

# Install polybar themes
echo "Installing polybar themes..."
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git ~/github/polybar-themes
chmod +x ~/github/polybar-themes/setup.sh
cd ~/github/polybar-themes
bash -c "echo 1 | ./setup.sh"

# Change timezone
# To list timezones run: timedatectl list-timezones
echo "Setting timezone to Europe/Madrid..."
sudo timedatectl set-timezone "Europe/Madrid"

echo "Setting up bspwm and polybar configuration..."
mkdir ~/screenshots
# copy all config files
cp -rv $RPATH/.config/* ~/.config/
cp -rv $RPATH/home/.* ~/

# copy scripts
cp -rv $RPATH/scripts/* ~/.config/polybar/forest/scripts/
sudo ln -s ~/.config/polybar/forest/scripts/target.sh /usr/bin/target
sudo ln -s ~/.config/polybar/forest/scripts/screenshot.sh /usr/bin/screenshot

# copy wallpapers
mkdir ~/Wallpapers/
cp -rv $RPATH/wallpapers/* ~/Wallpapers/

# Set execution perms
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/auto_resize.sh
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/forest/scripts/target.sh
chmod +x ~/.config/polybar/forest/scripts/screenshot.sh

rm -rf $RPATH
sudo apt autoremove -y

echo -e "\n[+] Done. Have fun!\n"
echo -e "[!] Please reboot..\n"
