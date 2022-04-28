set nocompatible
filetype off
call plug#begin('~/.vim/plugged')
    Plug 'amiorin/vim-project'
    Plug 'edkolev/tmuxline.vim'
    Plug 'elzr/vim-json'
    Plug 'godlygeek/tabular'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'luochen1990/rainbow'
    Plug 'mhinz/vim-signify'
    Plug 'mhinz/vim-startify'
    Plug 'moll/vim-bbye'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neomake/neomake'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'plasticboy/vim-markdown'
    Plug 'preservim/nerdtree'
    Plug 'preservim/vim-markdown'
    Plug 'preservim/vim-pencil'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'rust-lang/rust.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'tpope/tpope-vim-abolish'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tribela/vim-transparent'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'SidOfc/mkdx'
    Plug 'Yggdroot/indentLine'
call plug#end()

syntax enable
set ruler
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
set wrap "Wrap lines


" Enable 256 colors palette in Gnome Terminal
set t_Co=256

" Tab stuff
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


"encoding
set encoding=UTF-8

"rainbow
"let g:rainbow_active = 1

" Spell checker
map <leader>ss :setlocal spell!<cr>

" NERD
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" Start NERDTree. If a file is specified, move the cursor to its window.
fun! ExecNerd()
    if &ft =~ 'markdown\|markdown.pandoc'
        return
    endif
    NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
endfun



autocmd BufNewFile,BufRead *.asm set filetype=nasm



"Markdown
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END


autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * call ExecNerd()
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

"Colors
colorscheme minimalist
let g:airline_theme='minimalist'

