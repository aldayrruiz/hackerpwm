# hackerpwm
Deploy the best environment for Kali Linux.

![Desktop Environment](images/desktop.png)

## Usage
- You can watch a video tutorial ([CLICK HERE](https://youtu.be/oVgWy5Z9Owc))
- The use of a new/clean Kali Linux 2026 installation is recommended.
- Tested on Kali Linux 2026 with VMware, VirtualBox and bare metal.

### Vmare considerations
If Vmware is being used, you must click on "Upgrade this virtual machine" before power on. Otherwise, Bspwm crash with black screen.

![Upgrade VM machine](images/upgrade_vmware_1.png)

![Activate 3D Graphics Vmware](images/upgrade_vmware_2.png)

Also you MUST activate your 3d graphics. Otherwise, you probably may not be able to move when bspwm is initialized.

![Activate 3D Graphics Vmware](images/3d_graphics.png)

1. clone repo `git clone https://github.com/aldayrruiz/hackerpwm.git`
2. Change directory `cd hackerpwm`
3. Run script `./hackerpwm.sh`
4. **Reboot** and switch to bspwm in the login screen.
5. Run script `./postinstall.sh` to select your keyboard.
6. Enjoy!

Wallpaper is taken from ~/Wallpapers/wallpaper.*

## You will install:
### Main packages
- Hack Nerd Fonts
- Kitty
- Rmux + oh my tmux
- lsd
- fastfetch
- Batcat
- feh
- oh my zsh + plugins
- Rofi
- Bspwm
- Polybar
- Sxhkd
- Picom
- Neovim
- Cmatrix
- Duf

## Credits
* This repo is a fork of [repo](https://github.com/thegoodhackertv/hackerpwm), thank you thegoodhackertv ❤️. Since the repo is not updated and personally I experienced crashes when installing it, I decided to fork it and implement some new features.
