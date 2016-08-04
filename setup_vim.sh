#!/usr/bin/env sh
rm -rf ~/.vim
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# the echo is needed because vim asks you to press Enter when it encounters
# errors reading the .vimrc (which happens because you haven't yet installed
# plugins that .vimrc is referencing)
vim -u ~/vundlerc.vim -c PluginInstall -c 'qa!' 2>&1 > /dev/null
