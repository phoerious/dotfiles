" ---------------------------------------------------------------
" Vim config file
" Author: Janek Bevendorff <janek _AT_ jbev _._ net>
" ---------------------------------------------------------------


" ---------------------------------------------------------------
" Set the runtime path to include Vundle and initialize
" ---------------------------------------------------------------

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" ---------------------------------------------------------------
" Manage plugins with Vundle
" ---------------------------------------------------------------

Plugin 'gmarik/vundle'
"Plugin 'Rip-Rip/clang_complete'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'Shougo/neocomplcache.vim'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'vaibhav276/Conque-Shell'
Plugin 'https://github.com/ldx/vim-indentfinder'
Plugin 'https://github.com/jcf/vim-latex'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}


" ---------------------------------------------------------------
" Syntax highlighting, text appearance
" ---------------------------------------------------------------
syntax on
set t_Co=256
set background=dark
let g:solarized_termcolors=16
let g:solarized_contrast="normal"
let g:solarized_visibility="low"
let g:solarized_termtrans=1
colorscheme solarized

" Fix terminal color after exit
" (may be messed up after exiting Vim, especially when using GNU Screen)
au VimLeave * !echo -ne "\033[0m"↲

" GUI settings
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set guitablabel=%M\ %t
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 13
endif

" Associate custom file extensions with color schemes
autocmd BufRead,BufNewFile *.sls set filetype=yaml


" ---------------------------------------------------------------
" General settings
" ---------------------------------------------------------------

filetype plugin indent on

" Set UTF-8 as default encoding
set encoding=utf8
scriptencoding utf-8

" Set Unix as standard file type
set ffs=unix,dos,mac

" Ignore certain binary files
set wildignore=*.o,*.a,*.lib,*~,*.pyc

" Height of the command bar
set cmdheight=2

" Configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Keyboard and mouse model
"behave mswin
"set keymodel-=stopsel
"set mousemodel=popup_setpos

" Line numbers
set number

" Highlight current line (disable if you experience slow scroll speed)
set cursorline

" Highlight columns beyond 80 characters
let &colorcolumn=join(range(81,999),",")

" Highlight search results
set hlsearch

" Always show status line
set laststatus=2

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros
set nolazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
set matchtime=0

" Search settings
set ignorecase
set smartcase
set incsearch

" No sounds, no blinking stuff
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Tab settings
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set autoindent

" Text formatting
set formatoptions=roqn1j

" Non-printing characters
set list
set listchars=eol:↲,tab:→\ ,trail:·

" Spell checking
map <leader>ss :setlocal spell!<cr>
set spell
set spelllang=en_us

" Set completion behavior
set completeopt=menuone
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>\<Esc>a" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" Enable paste toggle hotkey
set pastetoggle=<F2>

" Smarter shortcuts for navigating windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Define alternate key binding for triggering onmicomplete
inoremap <C-S-Space> <C-x><C-o>

" Use Ctrl+Backspace to delete last word
imap <C-BS> <C-W>

" Don't deselect lines after (un)indenting
vnoremap < <gv
vnoremap > >gv

" ---------------------------------------------------------------
" Plugin settings
" ---------------------------------------------------------------

" YCM config
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"
let g:ycm_error_symbol=">>"
let g:ycm_warning_symbol='--'

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_python_python_exec='python3'
let g:Tex_AutoFolding=0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Powerline
let g:powerline_pycmd="py3"
