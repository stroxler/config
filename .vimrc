
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
Bundle 'vim-scripts/bufkill.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'kevinw/pyflakes-vim'
Bundle 'nvie/vim-flake8'
Bundle 'Raimondi/delimitMate'
    let delimitMate_offByDefault = 1 " turn it off... thus far it's a hassle
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'vim-scripts/CSApprox'
Bundle 'Lokaltog/vim-easymotion'
    let g:EasyMotion_mapping_w = '<leader>e'
Bundle 'airblade/vim-gitgutter'
    let g:gitgutter_enabled = 0
Bundle 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType="context"
Bundle 'kien/ctrlp.vim'
    let g:ctrlp_working_path_mode=0
    let g:ctrlp_max_height=20
    noremap <F4> :CtrlPClearCache<CR>
Bundle 'sjl/gundo.vim'
    nnoremap <F1> :GundoToggle<CR>
Bundle 'scrooloose/nerdtree'
    map <F2> :NERDTreeToggle<CR>
    let NERDTreeIgnore = ['\.pyc$']
    let NERDTreeShowBookmarks=1
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
    " This isn't normally needed, it checks on write. Every now and then,
    " though, it seems to fail.
    noremap <F3> :SyntasticCheck<CR>
    " 1. PYTHON SYNTAX CHECKING : this is handled by having pyflakes installed.
    " 2. R SYNTAX CHECKING
    " let g:syntastic_r_checkers = ["lint"]
    " ...This has very strict style rules, and ran into some other errors that
    " were pretty annoying. The svtools checker is much less picky.
    let g:syntastic_r_checkers = ["svtools"]
    let g:syntastic_enable_r_svtools_checker = 1
    " 3. C SYNTAX CHECKING
    " the default (gcc) is pretty good. But it isn't smart enough to scan
    " your makefile for cflags. You can fix this in two ways. For a particluar
    " buffer, you can temporarily fix it by doing:
    "   let b:syntastic_c_flags = '-I/path/to/include/dir'
    " for any nonstandard dir. If you have libraries you regularly use in
    " unexpected places, you can instead do
    "   let g:syntastic_c)include_dirs = ['/path/to/dir'] or ['path1', 'path2']
    " ...and to demo, here's where various apr headers live in osx:
    let g:syntastic_c_include_dirs = ['usr/include/apr-1']
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
    set guifont=Monospace\ 9 " this isn't consistent across gui backends.
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
noremap <silent> lkj :update<CR>
vnoremap <silent> lkj <C-C>:update<CR>
inoremap <silent> lkj <C-[>:update<CR>
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
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
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
"
" IN ADDITION, I've made the visual mode one-column indenting commands sticky.
" I'm making the four-column commands non-sticky for now because it's less
" often that you need them sticky, plus I want to be reminded of the `gv`
" command for a while until it's in my long-term memory.
"
" Also, the way I do c-j and c-k will cause issues when editing files where
" I didn't want a shiftwidth of 4. Be aware of this. Fortunately, I should
" only really need them in code files where the indentation isn't always a
" multiple of 4 (this generally happens in argument lists), and I use
" shiftwidth of 4 in all programming languages, so it shouldn't be an issue
noremap <C-H> <<
vnoremap <C-H> <
inoremap <C-H> <C-D>
noremap <C-L> >>
vnoremap <C-L> >
inoremap <C-L> <C-T>
noremap <C-J> :set shiftwidth=1<CR><<:set shiftwidth=4<CR>
vnoremap <C-J> <ESC>:set shiftwidth=1<CR>gv<:set shiftwidth=4<CR>gv
inoremap <C-J> <ESC>mq:set shiftwidth=1<CR><<:set shiftwidth=4<CR>`qa
noremap <C-K> :set shiftwidth=1<CR>>>:set shiftwidth=4<CR>
vnoremap <C-K> <ESC>:set shiftwidth=1<CR>gv>:set shiftwidth=4<CR>gv
inoremap <C-K> <ESC>mq:set shiftwidth=1<CR>>>:set shiftwidth=4<CR>`qa<Right>


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
noremap <leader>z oimport pudb; pudb.set_trace()<ESC>:w<CR>
noremap <leader>6 :<C-6><CR>
noremap <leader><Space> :nohlsearch<Bar>:echo<CR>
nnoremap <leader><Up> :m-2<CR>==
nnoremap <leader><Down> :m+<CR>==
noremap <BS> :noh<CR>
