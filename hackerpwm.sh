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
sleep 2
echo -e "\thackerpwm - Hacker environment automation script."
echo -e "\t\tAldayr Ruiz (Aka. xSmaky)"
sleep 3
echo -e "\nInstallation will begin soon..\n"
sleep 4

RPATH=`pwd`

# update and upgrade all
sudo apt update && sudo apt -y full-upgrade

# install packages 
sudo apt install -y git vim feh scrot scrub zsh rofi xclip xsel locate fastfetch wmname acpi bspwm sxhkd unison \
imagemagick ranger kitty tmux python3-pip font-manager lsd bpython open-vm-tools-desktop open-vm-tools cmatrix \
duf fzf polybar picom bat neovim

# install environment dependencies
sudo apt install -y build-essential libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev \
libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev # (xcb removed)

# install fonts
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

# install zsh-autocomplete?
cp -v $RPATH/CONFIGS/zshrc ~/.zshrc
cp -v $RPATH/CONFIGS/bash_aliases ~/.bash_aliases

# .tmux
echo "Installing tmux configuration..."
rm -rf ~/.tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/
cp -v $RPATH/CONFIGS/tmux.conf.local ~/.tmux.conf.local


# nvchad - needs work. Block cursor and user interaction
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

# Install polybar themes
#git clone --depth=1 https://github.com/adi1090x/polybar-themes.git ~/github/polybar-themes
#chmod +x ~/github/polybar-themes/setup.sh
#cd ~/github/polybar-themes
#./setup.sh

# Change timezone
# To list timezones run: timedatectl list-timezones
sudo timedatectl set-timezone "Europe/Madrid"

mkdir ~/screenshots
# copy all config files
cp -rv $RPATH/CONFIGS/config/* ~/.config/

# copy scripts
cp -rv $RPATH/SCRIPTS/* ~/.config/polybar/forest/scripts/
sudo ln -s ~/.config/polybar/forest/scripts/target.sh /usr/bin/target
sudo ln -s ~/.config/polybar/forest/scripts/screenshot.sh /usr/bin/screenshot

# copy wallpapers
mkdir ~/Wallpapers/
cp -rv $RPATH/WALLPAPERS/* ~/Wallpapers/

# Set execution perms
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/forest/scripts/target.sh
chmod +x ~/.config/polybar/forest/scripts/screenshot.sh


rm -rf $RPATH
sudo apt autoremove -y

echo -e "\n[+] Done. Have fun!\n"
echo -e "[!] Please reboot..\n"
