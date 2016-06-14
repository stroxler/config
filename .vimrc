" vim not vi
set nocompatible
set backspace=2

" Set up Vundle
" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc

let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" colors stuff
Plugin 'vim-scripts/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" unix tools and fuzzy finders
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'rking/ag.vim'  " ag is a bit like ack

" undo tree
Plugin 'mbbill/undotree'

" I should probably learn to use these
Plugin 'tpope/vim-surround'
Plugin 'michaeljsmith/vim-indent-object'


" fugitive is handy
Plugin 'tpope/vim-fugitive'

" this is what makes :BW work
Plugin 'vim-scripts/bufkill.vim'

" nice tab completion
Plugin 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType="context"

" some syntax highlighters
Plugin 'tpope/vim-markdown'
Plugin 'derekwyatt/vim-scala'
Plugin 'digitaltoad/vim-jade'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fireplace'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'kchmck/vim-coffee-script'

Plugin 'Lokaltog/vim-easymotion'

Plugin 'scrooloose/syntastic'
    " This isn't normally needed, it checks on write. Every now and then,
    " though, it seems to fail.
    noremap <F3> :SyntasticCheck<CR>
    au BufRead,BufNewFile *.json set filetype=json

    let g:syntastic_json_checkers = ["jsonlint"]
    let g:syntastic_r_checkers = ["svtools"]
    let g:syntastic_javascript_checkers = ["eslint"]
    " note: I've disabled pylint here 
    let g:syntastic_python_checkers = ["pyflakes", "pep8"]
    let g:syntastic_enable_r_svtools_checker = 1


    " C SYNTAX CHECKING
    " the default (gcc) is pretty good. But it isn't smart enough to scan
    " your makefile for cflags. You can fix this in two ways. For a particluar
    " buffer, you can temporarily fix it by doing:
    "   let b:syntastic_c_flags = '-I/path/to/include/dir'
    " for any nonstandard dir. If you have libraries you regularly use in
    " unexpected places, you can instead do
    "   let g:syntastic_c_include_dirs = ['/path/to/dir'] or ['path1', 'path2']
    " ...and to demo, here's where various apr headers live in osx:
    let g:syntastic_c_include_dirs = ['usr/include/apr-1']

""Plugin 'kien/ctrlp.vim'
""    let g:ctrlp_working_path_mode=0
""    let g:ctrlp_max_height=20
""    let g:ctrlp_custom_ignore = {
""      \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|vendor|target)$',
""      \ 'file': '\v\.(exe|so|a|dll|pyc|class)$',
""      \ }
""    noremap <F4> :CtrlPClearCache<CR>
""Plugin 'sjl/gundo.vim'
""    nnoremap <F1> :GundoToggle<CR>

call vundle#end()
filetype plugin indent on

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    PluginInstall
endif

" display
set nowrap
set number
set laststatus=2
set incsearch
set hlsearch
if version > 703
    set colorcolumn=80
endif
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match Overlength /\%81v.\+/
set title
set titleold=""
syntax on

" editor
set autoindent
set tabstop=2
set expandtab
set shiftwidth=2  " this gets undone below, in my shift-operator mappings
" set mouse=a

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
else
    set cursorline
endif

" set colors
colors solarized

" highlight current line in insert mode; not command
autocmd InsertEnter,InsertLeave * set cul!


" directory of current file, in command line
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" strip trailing whitespace with F5
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
"
" NOTE: I need to do this for spacemacs.
inoremap <C-L> <C-T>
noremap <C-J> :set shiftwidth=1<CR><<:set shiftwidth=4<CR>
vnoremap <C-J> <ESC>:set shiftwidth=1<CR>gv<:set shiftwidth=4<CR>gv
inoremap <C-J> <ESC>mq:set shiftwidth=1<CR><<:set shiftwidth=4<CR>`qa
noremap <C-K> :set shiftwidth=1<CR>>>:set shiftwidth=4<CR>
vnoremap <C-K> <ESC>:set shiftwidth=1<CR>gv>:set shiftwidth=4<CR>gv
inoremap <C-K> <ESC>mq:set shiftwidth=1<CR>>>:set shiftwidth=4<CR>`qa<Right>
noremap <C-H> <<
vnoremap <C-H> 4<C-J>
inoremap <C-H> 4<C-D>
noremap <C-L> >>
vnoremap <C-L> >

" move ; and  behavior to ' and ", and use ; as :

" make turning highlight off really easy

" NOTE: when in ctrl-p mode, you can use Enter to open in current
" context, ctrl-s/v/t will split, vsplit, or open in new tab. You can
" also use ctrl-j and ctrl-k to move up and down, although I'm happy
" enough with the arrow keys.

" <leader>
let mapleader="\<Space>"
" cursor and other term-related stuff
noremap <leader>r :redraw!<CR>
noremap <leader>coy :set colorcolumn=80<CR>
noremap <leader>con :set colorcolumn=<CR>
noremap <leader>ccy :set cursorcolumn<CR>
noremap <leader>ccn :set nocursorcolumn<CR>
noremap <leader>cly :set cursorline<CR>
noremap <leader>cln :set nocursorline<CR>
" some vim-specific stuff (I should make leader y work in spacemacs)
" move lines up and down NOTE i should consider porting to spacemacs
nnoremap <leader><Up> :m-2<CR>==
nnoremap <leader><Down> :m+<CR>==
" *** spacemacs section ***
" opening files and buffers
noremap <leader>pf :FZF<CR>
noremap <leader>ff :e %:p:h/
noremap <leader>fk :FZF /kode<CR>  " fuzzy find in /kode
noremap <leader>fzf :FZF           " fuzzy find in any directory
noremap <leader>fzh :FZF %:p:h<CR> " fuzzy version of ff - fuzzy find here
noremap <leader>bb :Buffers<CR>
noremap <leader>bp :bp<CR>
noremap <leader>bn :bn<CR>
noremap <leader>fed :e $MYVIMRC<CR>
noremap <leader>feR :source $MYVIMRC<CR>
" color themes
noremap <leader>Tnz :colors zenburn<CR>
noremap <leader>Tnl :colors solarized<CR>:set background=light<CR>
noremap <leader>Tnd :colors solarized<CR>:set background=dark<CR>
" windows
noremap <leader>w <C-W>
" TODO avy vs easymotion
"   I like that space space brings both of them up, but the actual
"   bindings aren't very similar
"   If I don't wind up using <Space><Space> *that* much in avy, one
"   option might be to remap it so that <Space><Space> is my avy
"   prefix.


" my own customizations - keep this in sync with spacemacs
nnoremap <leader>y "+y
noremap <BS> :noh<CR>
noremap ' ;
noremap " ,
noremap ; :
" this is temporary, till I retrain my fingers
noremap : :echo "oops, use ;"<CR>
