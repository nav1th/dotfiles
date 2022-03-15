set nocompatible
filetype plugin on
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'preservim/vim-pencil'
    Plug 'preservim/vim-markdown'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/tpope-vim-abolish'
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-startify'
    Plug 'mhinz/vim-signify'
    Plug 'edkolev/tmuxline.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'flazz/vim-colorschemes'
    Plug 'luochen1990/rainbow'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'jiangmiao/auto-pairs'
    Plug 'rust-lang/rust.vim'
    Plug 'junegunn/fzf'
    Plug 'amiorin/vim-project'
    Plug 'moll/vim-bbye'
    Plug 'neomake/neomake'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'ryanoasis/vim-devicons'
    Plug 'Yggdroot/indentLine'
    Plug 'mattn/vim-lsp-settings'
    Plug 'godlygeek/tabular'
call plug#end()

syntax enable
"set ruler
set number
let mapleader = ","

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Lang Settings
let $LANG='en'
set langmenu=en


" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set visualbell

"set t_vb=
set tm=500
set history=500
set nobackup
set nowb
set noswapfile


"tab stuff
set shiftwidth=4
set smarttab
set tabstop=4
set expandtab

" Linebreak on 500 characters
set lbr
set tw=500

" Indentation & wrap
set ai "Auto indent
set si "Smart indent
set nowrap "Wrap lines


" Enable 256 colors palette in Gnome Terminal
set t_Co=256

" Tab stuff
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove


"encoding
set encoding=UTF-8

"rainbow
let g:rainbow_active = 1

" Spell checker
map <leader>ss :setlocal spell!<cr>

" NERD
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"lightline
let g:airline#extensions#tabline#enabled = 1

"Colors
colorscheme purify
let g:airline_theme='purify'

"autocomplete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

