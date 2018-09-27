#!/usr/bin/env bash
set -x

export PYTHON_CONFIGURE_OPTS="--enable-framework"


echo "=============== INSTALLING PYTHONS (IF NEEDED) ==========="
pyenv install 2.7.14
pyenv install 3.6.4

echo "=============== CREATING VIRTUALENVS ====================="
pyenv virtualenv 2.7.14 neovim2
pyenv virtualenv 3.6.4 neovim3

echo "=============== INSTALLING NEOVIM IN neovim2 ==============="
export PYENV_VERSION=neovim2
pip install neovim
pyenv which python  # Note the path

echo "=============== INSTALLING NEOVIM IN neovim3 ==============="
export PYENV_VERSION=neovim3
pip install neovim
pyenv which python  # Note the path

# The following is optional, and the neovim3 env is still active
# This allows flake8 to be available to linter plugins regardless
# of what env is currently active.  Repeat this pattern for other
# packages that provide cli programs that are used in Neovim.
#
# Note: do not add pyflakes, mccabe, or pycodestyle to the installs.
# These are explicitly pulled in from flake8, and sometimes the versions
# have to be pinned there; you don't want to pull in a version newer than
# what flake8 allows.
pip install flake8 autoflake yapf isort rope python-language-server jedi
rm -f ~/bin/flake8 ~/bin/autoflake ~/bin/yapf ~/bin/isort ~/bin/pyls
ln -s "$(pyenv which flake8)" ~/bin/flake8
ln -s "$(pyenv which autoflake)" ~/bin/autoflake
ln -s "$(pyenv which yapf)" ~/bin/yapf
ln -s "$(pyenv which isort)" ~/bin/isort
ln -s "$(pyenv which pyls)" ~/bin/pyls
