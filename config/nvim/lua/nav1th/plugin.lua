local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    "nvim-lua/plenary.nvim", -- useful lua library
    "folke/which-key.nvim",
    {"folke/neoconf.nvim", cmd = "Neoconf" },
    "tpope/vim-surround",
    "preservim/nerdtree",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter", -- better syntax highlighting
    "lukas-reineke/indent-blankline.nvim",-- indent line
    "windwp/nvim-autopairs", -- autopairs
    "hrsh7th/nvim-cmp",-- the completion plugin
    "hrsh7th/cmp-buffer",-- buffer completions
    "hrsh7th/cmp-path",-- path completions
    "hrsh7th/cmp-cmdline",-- cmdline completions
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
    "L3MON4D3/LuaSnip", -- Snippets plugin
    "mfussenegger/nvim-jdtls", -- Neovim Java LS plugin
    "neovim/nvim-lspconfig", -- enable LSP
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    },
    {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup()
        end
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- indent line
    {
        "lunarvim/colorschemes",
        "lunarvim/darkplus.nvim",
        "sainnhe/sonokai",
        "Mofiqul/vscode.nvim" 
    }, -- colourschemes
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    "willothy/nvim-cokeline",
    {
{'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
    },
})
