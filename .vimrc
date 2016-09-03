" vim not vi
set nocompatible
set colorcolumn=80

" NOTE: this .vimrc assumes you've run the vim setup (which
" uses vundle to install a bunch of packages)

so $HOME/vundlerc.vim
set backspace=2


" My custom leader key stuff
nnoremap <leader>y "+y
noremap <BS> :noh<CR>
noremap ' ;
noremap " ,
noremap ; :
" this is temporary, till I retrain my fingers
noremap : :echo "oops, use ;"<CR>


filetype plugin indent on

" make spacevim work and add some extra stuff
let mapleader="\<space>"
" Make Y behave like C and D (spacemacs does this)
map Y y$
" syntax highlinging and inc search with highlighting
syntax on
set incsearch
set hlsearch
" nicer tab completion
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc,*.so,*.swp,.git

" some other random stuff I like
set expandtab
set confirm
set nobackup
set noswapfile
set hidden
set history=200
set spelllang=en_us


" Syntastic configuration
" ========================
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
" C SYNTAX CHECKING IF YOU HAVE DEPENDENCIES
" the default (gcc) is pretty good. But it isn't smart enough to scan
" your makefile for cflags. You can fix this in two ways. For a particluar
" buffer, you can temporarily fix it by doing:
"   let b:syntastic_c_flags = '-I/path/to/include/dir'
" for any nonstandard dir. If you have libraries you regularly use in
" unexpected places, you can instead do
"   let g:syntastic_c_include_dirs = ['/path/to/dir'] or ['path1', 'path2']


" Terminal-related stuff: redraw window when it gets messed up, set up
" color lines and columns when I can't find cursor
noremap <leader>rrr :redraw!<CR>
noremap <leader>coy :set colorcolumn=80<CR>
noremap <leader>con :set colorcolumn=<CR>
noremap <leader>ccy :set cursorcolumn<CR>
noremap <leader>ccn :set nocursorcolumn<CR>
noremap <leader>cly :set cursorline<CR>
noremap <leader>cln :set nocursorline<CR>


" highlight current line in insert mode; not command
" I find this makes it easier to know which mode I'm in in the terminal
autocmd InsertEnter,InsertLeave * set cul!


" set indentation rules
set autoindent
set tabstop=2
set expandtab
set shiftwidth=2

" My custom tabbing commands, for when auto-indent isn't cutting it
" and I need indentation that isn't multiples of 2 or 4: control h j k and l
" will tab stuff left 4, left 1, right 1, and right 4 spaces respectively.
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


" strip trailing whitespace with F5
" (spacevim doesn't seem to auto-strip new edits like spacemacs)
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

" disable the bell (some of these lines may not be needed)
autocmd! GUIEnter * set vb t_vb=
set noerrorbells 
set novisualbell
set t_vb=

" set cursorline in terminal mode, no toolbar in gui mode
if has('gui_running')
    set background=dark
    colors apprentice
    set guioptions-=T  " hide toolbar
else
    set background=dark
    colors gruvbox
    set cursorline
endif

" Make the completion more closely mirror spacemacs
" =================================================
" The best approximation of vim's C-n behavior in
" spacemacs actually isn't evil's C-n, it's hippie-expand,
" which gets mapped to C-p (this isn't the whole story,
" since hippie-expand will complete on more things, like
" full lines. But it works a lot better than evil-mode!)
"
" Because of this, I'm swapping the two commands in vim,
" since the drop-down menue c-p brings up is too different.
inoremap <C-P> <C-N>
inoremap <C-N> <C-P>


" Customize spacevim mappings a big / add some of my own
" ======================================================
" color themes - Tn cycles themes in emacs
noremap <leader>Tna :colors apprentice<CR>
noremap <leader>Tnz :colors zenburn<CR>
noremap <leader>Tns :colors solarized<CR>:set background=light<CR>
noremap <leader>TnS :colors solarized<CR>:set background=dark<CR>
noremap <leader>Tnl :colors lucius<CR>:set background=dark<CR>
noremap <leader>TnL :colors lucius<CR>:set background=light<CR>
noremap <leader>Tni :colors iceberg<CR>
noremap <leader>Tnp :colors phd<CR>
noremap <leader>Tnc :colors codeschool<CR>:set background=dark<CR>
noremap <leader>Tng :colors gruvbox<CR>:set background=dark<CR>
" override ff with a regular :e command in the current file's directory -
" important because spacemacs lets you create new files
" For some reason spacevim seems to frequently override this, so also
" provide fh ("file here") to do the same thing
noremap <leader>fh :e %:p:h/
noremap <leader>ff :e %:p:h/
" add some additional bindings that aren't in spacemacs or spacevim
noremap <leader>fk :FZF /kode<CR>  " fuzzy find in /kode
noremap <leader>fzf :FZF           " fuzzy find in any directory
noremap <leader>fzh :CtrlP %:p:h<CR> " fuzzy version of ff - fuzzy find here
noremap <leader>fcp :CtrlP<CR> " fuzzy version of ff - fuzzy find here

