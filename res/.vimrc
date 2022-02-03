" - Avoid using standard Vim directory names like 'plugin'
set nocompatible
call plug#begin('~/.vim/plugged')
   Plug 'preservim/nerdtree'
   Plug 'preservim/tagbar'
   Plug 'preservim/vim-pencil'
   Plug 'tpope/vim-commentary'
   Plug 'tpope/tpope-vim-abolish'
   Plug 'tpope/vim-fugitive'
   Plug 'mhinz/vim-startify'
   Plug 'mhinz/vim-signify'
   Plug 'sheerun/vim-polyglot'
   Plug 'flazz/vim-colorschemes'
   Plug 'luochen1990/rainbow'
   Plug 'jiangmiao/auto-pairs'
  " Plug 'ycm-core/YouCompleteMe'
   Plug 'junegunn/fzf'
   Plug 'amiorin/vim-project'
   Plug 'moll/vim-bbye'
   Plug 'neomake/neomake'
   Plug 'SirVer/ultisnips'
   Plug 'honza/vim-snippets'
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
set laststatus=2


set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

" Indentation
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
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

 
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

" Tagbar
nmap <F8> :TagbarToggle<CR>

"Colors
colorscheme badwolf
"set background=dark
let java_highlight_functions = 1
let java_highlight_all = 1
set filetype=java

" Some more highlights, in addition to those suggested by cmcginty
highlight link javaScopeDecl Statement
highlight link javaType Type
highlight link javaDocTags PreProc
set omnifunc=csscomplete#CompleteCSS
