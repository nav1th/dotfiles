local colorscheme = "vscode"
vim.opt.background = "dark"
vim.g.vscode_style = "dark"
vim.g.vscode_transparent = 1
--Configure colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme ".. colorscheme)
if not status_ok then
    vim.notify("colorscheme "..colorscheme.." not found")
    vim.cmd("colorscheme default")
end

--Configure airline colorscheme if airline is installed
--require("transparent").setup({
--  enable = true, -- boolean: enable transparent
--  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
--    "BufferLineTabClose",
--    "BufferlineBufferSelected",
 --   "BufferLineFill",
 --   "BufferLineBackground",
  --  "BufferLineSeparator",
--    "BufferLineIndicatorSelected",

--  },
--  exclude = {}, -- table: groups you don't want to clear
--})
