" vim not vi
let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'

set nocompatible
set colorcolumn=80
execute pathogen#infect()

" NOTE: this .vimrc assumes you've run the vim setup (which
" uses vundle to install a bunch of packages)

set backspace=2


" My custom leader key stuff
nnoremap <leader>y "+y
noremap <BS> :noh<CR>
noremap ' ;
noremap ; :


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
if has("gui_running")
    set guioptions-=T  " hide toolbar
else
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


" Customize spacevim mappings a bit / add some of my own
" ======================================================
" ff = find nearby. You can't create new files like this
"      (unlike in spacemacs), so as a result I also added..
" fn = find new: lets you easily edit *new* files in current
"      directory
noremap <leader>ff :CtrlP %:p:h<CR>
noremap <leader>fn :e %:p:h/
noremap <leader>bb :CtrlPBuffer<CR>

" Colors!
" Set this at the very bottom so that I can change frequently
set background=dark
set termguicolors

" these are my favorite color themses
"
"colors deep-space
"colors base16-gruvbox-dark-pale
"colors base16-gruvbox-dark-soft
"colors base16-phd
"colors base16-mocha
"colors base16-nord
"colors base16-flat
"colors base16-ocean
"colors base16-oceannext
"colors base16-bespin
"colors base16-snazzy
"colors base16-porple
"colors base16-circus
"colors base16-embers
"colors base16-materia
"colors base16-material
"colors base16-material-palenight
"colors base16-eighties
"colors base16-paraiso
"colors base16-darktooth
"colors base16-onedark
"colors base16-porple
"colors base16-woodland
"colors base16-railscast
"colors base16-marrakesh
"colors base16-solarflare
"colors base16-harmonic-dark
"colors base16-soloarized-dark
"
"colors base16-blackmetal-*
"colors base16-atelier-*-dark
"
"colors apprentice
"colors stellarized
"colors hybrid_reverse
"
" For now I'm going to go with this because it jives
" pretty well with a gruvbox-themed terminal:
colors base16-gruvbox-dark-soft
