#!/bin/bash

# Use this script to update the dotfiles in this repository with the current ones on your system.

cp -rv ~/.config/bspwm/ ./config/
cp -rv ~/.config/kitty/ ./config
cp -rv ~/.config/picom/ ./config/
cp -rv ~/.config/polybar/ ./config/
cp -rv ~/.config/sxhkd/ ./config

cp -v ~/.zshrc ./home/.zshrc
cp -v ~/.oh-my-zsh/custom/aliases.zsh ./home/.oh-my-zsh/custom/aliases.zsh
cp -v ~/.bash_aliases ./home/.bash_aliases
cp -v ~/.xinitrc ./home/.xinitrc
cp -v ~/.tmux.conf.local ./home/.tmux.conf.local
cp -v ~/.Xresources ./home/.Xresources
cp -v ~/.pk10k.zsh ./home/.pk10k.zsh
