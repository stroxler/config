set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" spacevim dependencies
Plugin 'airblade/vim-gitgutter'
Plugin 'dbakker/vim-projectroot'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/gv.vim'
Plugin 'mbbill/undotree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'

" mis-specified as optional
Plugin 'hecal3/vim-leader-guide'

" spacevim
Plugin 'ctjhoa/spacevim'

" spacevim
Plugin 'haya14busa/incsearch.vim'

" spacevim recommended plugins
"   (note: I removed delimitMate)
Plugin 'osyo-manga/vim-over'
Plugin 'tpope/vim-surround'

" colors stuff
Plugin 'stroxler/Zenburn'
Plugin 'morhetz/gruvbox'
Plugin 'vim-scripts/phd'
Plugin 'romainl/Apprentice'
Plugin 'cocopon/iceberg'
Plugin 'jonathanfilip/vim-lucius'

" langages
Plugin 'tpope/vim-markdown'
Plugin 'derekwyatt/vim-scala'
Plugin 'digitaltoad/vim-jade'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fireplace'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'kchmck/vim-coffee-script'

" bonus stuff
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/bufkill.vim'

" ctl-p ... I've found that spacemacs FZF defaults aren't good enough
" for some purposes
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()

