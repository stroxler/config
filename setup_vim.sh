#!/usr/bin/env sh
rm -rf ~/.vim
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# the echo is needed because vim asks you to press Enter when it encounters
# errors reading the .vimrc (which happens because you haven't yet installed
# plugins that .vimrc is referencing)
vim -u ~/vundlerc.vim -c PluginInstall -c 'qa!' 2>&1 > /dev/null

# for whatever reason, the iceberg plugin download prompts for a git username
# and password. This is pretty annoying, so I get it manually with curl
mkdir -p ~/.vim/colors
git_raw_url='https://raw.githubusercontent.com'
file_url='cocopon/iceberg.vim/master/colors/iceberg.vim'
curl "${git_raw_url}/${file_url}" > ~/.vim/colors/iceberg.vim
