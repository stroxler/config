set -e
set -x
mv ~/.vim ~/.vim.bak
curl -sLf https://spacevim.org/install.sh | bash
mv ~/.vim ~/SpaceVim-rtp
mv ~/.vim.bak ~/.vim

