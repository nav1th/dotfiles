" - Avoid using standard Vim directory names like 'plugin'
set nocompatible
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
syntax enable
filetype plugin indent on
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'preservim/tagbar'
    Plug 'preservim/vim-pencil'
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
    Plug 'ycm-core/YouCompleteMe'
    Plug 'jiangmiao/auto-pairs'
    Plug 'rust-lang/rust.vim'
    Plug 'junegunn/fzf'
    Plug 'amiorin/vim-project'
    Plug 'moll/vim-bbye'
    Plug 'neomake/neomake'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'ryanoasis/vim-devicons'
call plug#end()
syntax enable
set ruler
set number
let mapleader = ","

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

set nowrap
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
set noerrorbells
set novisualbell

set t_vb=
set tm=500
set history=500
filetype plugin on
filetype indent on
set nobackup
set nowb
set noswapfile
"set noshowmode
"set noshowcmd
set laststatus=2           " Always display the status bar
"set powerline_cmd="py3"    " Tell powerline to use Python 3
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup


set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

" Indentation & wrap
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set nowrap


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
" Search options
map <space> /
map <C-space> ?

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

" Tagbar
nmap <F8> :TagbarToggle<CR>


"lightline
let g:airline#extensions#tabline#enabled = 1

"Colors
colorscheme purify
let g:airline_theme='purify'
"ALE
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1
let g:ale_linters = {'rust': ['analyzer']}


let java_highlight_functions = 1
let java_highlight_all = 1
set filetype=java

" Some more highlights, in addition to those suggested by cmcginty
highlight link javaScopeDecl Statement
highlight link javaType Type
highlight link javaDocTags PreProc
set omnifunc=csscomplete#CompleteCSS
set laststatus=2 
set t_Co=256
