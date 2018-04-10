#!/usr/bin/env sh
set -e
set -x

clean=$1

if [[ "${clean}" == "--clean" ]]; then
  # wipe out existing vim
  rm -rf ~/.vim
  rm -rf ~/
fi

mkdir -p ~/basic-vim
if [[ ! -d ~/basic-vim/autoload/pathogen.vim ]]; then
  mkdir -p ~/basic-vim/autoload
  pushd ~/basic-vim/autoload
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  popd
fi

# install plugins (including Vundle)
bash ~/basic-pathogen-packages.sh

# set up basic-vim as default vim
ln -s ~/basic-vim ~/.vim
ln -s ~/.vim/init.vim ~/.vimrc

# set up neovim
rm -rf ~/.config/nvim
rm -rf ~/.vim/init.vim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
