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

" langages
Plugin 'tpope/vim-markdown'
Plugin 'derekwyatt/vim-scala'
Plugin 'digitaltoad/vim-jade'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fireplace'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-speeddating'
Plugin 'jceb/vim-orgmode'

" bonus stuff
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/bufkill.vim'

" ctl-p ... I've found that spacemacs FZF defaults aren't good enough
" for some purposes
Plugin 'ctrlpvim/ctrlp.vim'

" COLORS ------------------------------

" gruvbox, apprentice, lucius, oceandeep, vydark
" shades-of-teal, deep-space, mod8, vilight,
" tender, lucid, termschool
Plugin 'morhetz/gruvbox'
Plugin 'romainl/Apprentice'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'vim-scripts/oceandeep'
Plugin 'vyshane/vydark-vim-color'
Plugin 'kristiandupont/shades-of-teal'
Plugin 'tyrannicaltoucan/vim-deep-space'
Plugin 'easysid/mod8.vim'
Plugin 'vim-scripts/vilight.vim'
Plugin 'jacoborus/tender.vim'
Plugin 'jlund3/colorschemer'
Plugin 'marcopaganini/termschool-vim-theme'
" moonshine* (they are all pretty similar)
Plugin 'KKPMW/moonshine-vim'
" base16-altier*, base16-ateliersulphurpool was motivation
Plugin 'atelierbram/vim-colors_atelier-schemes'
" flattened-light and flattened-dark (tweaked solarized)
Plugin 'romainl/flattened'

" colurs I used to use
" (no zenburn b/c I prefer emacs)
" Plugin 'stroxler/Zenburn'
" (no zenburn b/c I prefer emacs)
" Plugin 'stroxler/Zenburn'

call vundle#end()

