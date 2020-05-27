#!/bin/env bash

# File Name: for-arch.sh
# Description: auto install needed of neovim in Arch series
# Author: zachary
# Created Time: 2020-05-28 02:23:05
# Last Modified: 

sudo pacman -S ctags xclip figlet fzf the_silver_searcher
#sudo pacman -S nodejs

pip install pyneovim
pip install debugpy

npm install -g neovim

echo "finished."
