#!/usr/bin/env sh
rm -rf ~/.vim
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim -u ~/vundlerc.vim -c PluginInstall -c 'qa!' 2>&1 > /dev/null

# for whatever reason, the iceberg plugin download prompts for a git username
# and password. This is pretty annoying, so I get it manually with curl
mkdir -p ~/.vim/colors

rm -rf ~/.config/nvim
rm -rf ~/.vim/init.vim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
