
" vim not vi
set nocompatible

" Set up Vundle
" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
filetype off 
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/Vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'kevinw/pyflakes-vim'
Bundle 'nvie/vim-flake8'
Bundle 'Raimondi/delimitMate'
    let delimitMate_offByDefault = 1 " turn it off... thus far it's a hassle
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'vim-scripts/CSApprox'
Bundle 'Lokaltog/vim-easymotion'
    let g:EasyMotion_mapping_w = '<leader>w'
Bundle 'airblade/vim-gitgutter'
    let g:gitgutter_enabled = 0
Bundle 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType="context"
Bundle 'kien/ctrlp.vim'
    let g:ctrlp_working_path_mode=0
    let g:ctrlp_max_height=20
Bundle 'sjl/gundo.vim'
    nnoremap <F1> :GundoToggle<CR>
Bundle 'scrooloose/nerdtree'
    map <F2> :NERDTreeToggle<CR>
    let NERDTreeIgnore = ['\.pyc$']
    let NERDTreeShowBookmarks=1
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
    "let g:syntastic_r_checkers = ["lint"]
    let g:syntastic_r_checkers = ["svtools"]
    let g:syntastic_enable_r_svtools_checker = 1
    noremap <F3> :SyntasticCheck<CR>
    " It complains about = for assignment, but I'm not willing to change
    " my typing habits..crooloose/syntastic
    noremap <F4> :%s/ = / <- /gc<CR>
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" display
set nowrap
set number
set laststatus=2
set incsearch
set hlsearch
set background=dark
set colorcolumn=80
set title
set titleold=""
set listchars=tab:▸\ ,eol:¬,trail:·
syntax on

" editor
set autoindent
set tabstop=4
set expandtab
set shiftwidth=4  " this gets undone below, in my shift-operator mappings
set mouse=a

" system
set confirm
set nobackup
set noswapfile
set hidden
set history=200
set spelllang=en_us
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc,*.so,*.swp,.git
filetype plugin indent on

" vim/gvim setting
if has('gui_running')
    set guioptions-=T  " hide toolbar
    " set guioptions-=r  " remove right-hand scroll bar
    set guifont=Monospace\ 11 " this isn't consistent across gui backends.
                              " this command works in ubuntu but fails in
                              " MacVim.. but I like the MacVim default enough.
    colorscheme solarized
else
    if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'         
        set t_Co=256                                                              
    endif  
    colorscheme zenburn
endif

" highlight current line in insert mode; not command
autocmd InsertEnter,InsertLeave * set cul!

" abbreviations
ab imp import
ab impn import numpy as np
ab impb import bottleneck as bn

" directory of current file, in command line
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Use CTRL-S for saving, also in Insert mode
noremap <silent> <C-W> :update<CR>
vnoremap <silent> <C-W> <C-C>:update<CR>
inoremap <silent> <C-W> <C-[>:update<CR>
"
" Add this to .bashrc:
"
" When vim is used in terminal (instead of gui) the terminal should pass
" through CNTRL-S to vim (for use as 'save') instead of stop scrolling
" vim()
" {
"    local STTYOPTS="$(stty --save)"
"    stty stop '' -ixoff
"    command vim "$@"
"    stty "$STTYOPTS"
"}

" strip trailing whitespace with F6
nnoremap <silent> <F6> :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Make Y behave like C and D
map Y y$

" Indentation is a big issue... make c-h, c-j, c-k, and c-l indentation
" operators in all three modes, where the outer ones move 4 and the inner
" ones move 1 space. Note that this causes the default operators
" >>, <<, c-t, and c-u to only move one space.
set shiftwidth=1
map <C-H> <<<<<<<<
vmap <C-H> 4<
imap <C-H> <C-D><C-D><C-D><C-D>
map <C-J> <<
vmap <C-J> <
imap <C-J> <C-D>
map <C-K> >>
vmap <C-K> >
imap <C-K> <C-T>
map <C-L> >>>>>>>>
vmap <C-L> 4>
imap <C-L> <C-T><C-T><C-T><C-T>


" NOTE: when in ctrl-p mode, you can use Enter to open in current
" context, ctrl-s/v/t will split, vsplit, or open in new tab. You can
" also use ctrl-j and ctrl-k to move up and down, although I'm happy
" enough with the arrow keys.

" <leader>
let mapleader="\<Space>"
noremap <leader>w <c-w>
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>d :CtrlPDir<CR>
noremap <leader>d :bd<CR>
noremap <leader>e :e %%
noremap <leader>f :CtrlP<CR>
noremap <leader>g :GitGutterToggle<CR>
noremap <leader>h :CtrlP ~<CR>
noremap <leader>l :set list!<CR>  " shows whitespace
noremap <leader>m "*p
noremap <leader>p "+p
noremap <leader>r :CtrlPRoot<CR>
noremap <leader>s :source $MYVIMRC<CR>
noremap <leader>u :CtrlPMRU<CR>
vnoremap <leader>y "+y
noremap <leader>z Oimport pudb; pudb.set_trace()<C-W>
noremap <leader>6 :<C-6><CR>
noremap <leader><Space> :nohlsearch<Bar>:echo<CR>
nnoremap <leader><Up> :m-2<CR>==
nnoremap <leader><Down> :m+<CR>==
noremap <BS> :noh<CR>
