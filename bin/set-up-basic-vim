#!/usr/bin/env sh
set -e
set -x

clean=$1

if [[ "${clean}" == "--clean" ]]; then
  # wipe out existing vim
  rm -rf ~/.vim
  rm -rf ~/basic-vim
fi

mkdir -p ~/basic-vim
ln -s ~/basic-init.vim ~/basic-vim/init.vim

if [[ ! -d ~/basic-vim/autoload/pathogen.vim ]]; then
  mkdir -p ~/basic-vim/autoload
  pushd ~/basic-vim/autoload
    curl -LSso ~/basic-vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  popd
fi

# install plugins (including Vundle)
bash ~/basic-pathogen-packages.sh

# set up default vim to use basic-vim
rm -rf ~/.vimrc
rm -rf ~/.vim
ln -s ~/basic-vim ~/.vim
ln -s ~/.vim/init.vim ~/.vimrc

# set up default neovim to use default vim
rm -rf ~/.config/nvim
ln -s ~/.vim ~/.config/nvim
