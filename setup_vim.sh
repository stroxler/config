#!/usr/bin/env sh
set -e
set -x

clean=$1

if [[ "${clean}" == "--clean" ]]; then
  # wipe out existing vim
  rm -rf ~/.vim
fi

if [[ ! -d ~/.vim/autoload/pathogen.vim ]]; then
  mkdir -p ~/.vim/autoload
  pushd ~/.vim/autoload
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  popd
fi

# install plugins (including Vundle)
bash ~/pathogen_packages.sh

# set up neovim
rm -rf ~/.config/nvim
rm -rf ~/.vim/init.vim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
