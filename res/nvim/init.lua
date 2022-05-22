local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end


require('plugins')


cmd([[
filetype off
syntax enable
let $LANG='en'
]])

g.mapleader=","

opt.encoding="utf-8"
opt.background = 'dark'
opt.langmenu="en"
opt.ruler=true
opt.number=true
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- completion options 
opt.so=7 -- Set 7 lines to the cursor - when moving vertically using j/k
opt.hid=true -- A buffer becomes hidden when it is abandoned
opt.backspace="eol,start,indent"  -- Configure backspace so it acts as it should act
opt.ignorecase=true  -- Ignore case when searching
opt.smartcase=true -- When searching try to be smart about cases
opt.hlsearch=true -- Highlight search results
opt.incsearch=true -- Makes search act like search in modern browsers
opt.lazyredraw=true  -- Don't redraw while executing macros (good performance config)
opt.magic=true -- For regular expressions turn magic on
opt.showmatch=true -- Show matching brackets when text indicator is over them
opt.visualbell=true  -- No annoying sound on errors
opt.termguicolors = true  -- Truecolor support
opt.list = true
opt.mat=2
opt.tm=500
opt.history=500
opt.shiftwidth=4
opt.smarttab=true
opt.tabstop=4
opt.expandtab=true
opt.lbr=true
opt.tw=500
opt.ai=true --Auto indent
opt.si=true --Smart indent
opt.wrap=true --Wrap lines

cmd([[
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
]])



--Markdown
cmd([[
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md vim.opt. filetype=markdown.pandoc
augroup END
]])

--NERD Tree
cmd([[
map <leader>ss :set local spell!<cr>
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
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * call ExecNerd()
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]])

--NASM
cmd([[autocmd BufNewFile,BufRead *.asm vim.opt. filetype=nasm]])

--Markdown
g.vim_markdown_folding_disabled = 1

-- do not use conceal feature, the implementation is not so good
g.vim_markdown_conceal = 0

-- disable math tex conceal feature
g.tex_conceal = ""
g.vim_markdown_math = 1

-- support front matter of various format
g.vim_markdown_frontmatter = 1  -- for YAML format
g.vim_markdown_toml_frontmatter = 1  -- for TOML format
g.vim_markdown_json_frontmatter = 1  -- for JSON format


--Airline
cmd([[
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
]])

--Colors
cmd([[colorscheme minimalist]])
g.airline_theme='minimalist'

require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.clangd.setup{}
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup {
    window = {
       completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-a>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
                return vim_item
            end
        })
    },
    sources = {
        { name = "nvim_lsp"},
        { name = "ultisnips" },
        { name = "buffer"},
    },
    experimental = {
       ghost_text = false
    }
}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
