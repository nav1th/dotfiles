local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end


-- Install your plugins here
return packer.startup(function(use)
    use 'wbthomason/packer.nvim' -- have packer manage itself
    use 'nvim-lua/popup.nvim' -- an implementation of the Popup API from vim in Neovim
    use 'nvim-lua/plenary.nvim' -- useful lua functions used ny lots of plugins

    -- theme, lualine & bufferline
    use {'lunarvim/colorschemes','lunarvim/darkplus.nvim','sainnhe/sonokai','Mofiqul/vscode.nvim'} --colorschemes

    use 'xiyaowong/nvim-transparent' --for a transparent background

    use{'nvim-lualine/lualine.nvim',requires = { 'kyazdani42/nvim-web-devicons', opt = true }} --fancy line
    use 'akinsho/bufferline.nvim' --fancy bufferline

    --telescope fuzzy finder
    use {'nvim-telescope/telescope.nvim'}
    -- syntax highlighting
    use {'nvim-treesitter/nvim-treesitter',run='TSUpdate'}
    -- indent line
    use 'lukas-reineke/indent-blankline.nvim'
    -- autopairs
    use 'windwp/nvim-autopairs'


    -- cmp plugins
    use 'hrsh7th/nvim-cmp' -- the completion plugin
    use 'hrsh7th/cmp-buffer' -- buffer completions
    use 'hrsh7th/cmp-path' -- path completions
    use 'hrsh7th/cmp-cmdline' -- cmdline completions
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip' -- snippet completions

    -- snippets
    use 'L3MON4D3/LuaSnip' --snippet engine
    use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use


    --LSP
    use 'williamboman/nvim-lsp-installer' -- simple to use language server installer
    use 'neovim/nvim-lspconfig' -- enable LSP
    use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters
    use 'tamago324/nlsp-settings.nvim' -- language server settings defined in json for
    use 'simrat39/rust-tools.nvim' -- for extra rust-analyzer support

    --debugging
    use 'mfussenegger/nvim-dap'

    --set project root to file
    use 'airblade/vim-rooter'

    --makes colors visible
    use 'norcalli/nvim-colorizer.lua'

    --adds a way to change surroundings
    use 'tpope/vim-surround'

    use 'rust-lang/rust.vim'


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins


  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
