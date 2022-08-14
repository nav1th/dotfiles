local opts =  {noremap = true, silent = true}
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

local nmap = function(lhs, rhs, silent)
  keymap("n", lhs, rhs, { noremap = true, silent = silent })
end

local imap = function(lhs, rhs)
  keymap("i", lhs, rhs, { noremap = true })
end

local vmap = function(lhs, rhs)
  keymap("v", lhs, rhs, { noremap = true })
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>",opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
nmap("<A-h>", "<C-w>h")
nmap("<A-j>", "<C-w>j")
nmap("<A-l>", "<C-w>l")
nmap("<A-k>", "<C-w>k")

--Kill window
nmap("<A-x>", "<C-w>:q<CR>")

-- Better terminal navigation
keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", term_opts)

keymap("t", "<A-x>", "<C-\\><C-N>:ToggleTerm", term_opts)
nmap("<leader>t",":ToggleTerm <CR>")

--Telescope
nmap("<leader>ff", ":Telescope find_files<CR>")
nmap("<leader>fg", ":Telescope find_files<CR>")


nmap("<CapsLock>","<Nop>")

--File explorer
nmap("<leader>e", ":Lex 20<cr>")

-- Resize with arrows
nmap("<A-Up>", ":resize -2<CR>")
nmap("<A-Down>", ":resize +2<CR>")
nmap("<A-Left>", ":vertical resize -2<CR>")
nmap("<A-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
nmap("<S-l>", ":bnext<CR>")
nmap("<S-h>", ":bprevious<CR>")

-- Stay in indent mode
vmap(">", ">gv")
vmap("<", "<gv")


-- Visual Block --
-- Move text up and down
keymap("x", "K", ":move '<-2<CR>gv-gv",opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv",opts)
keymap("x", "J", ":move '>+1<CR>gv-gv",opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv",opts)

-- LSP
nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", true)
nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", true)
nmap("gr", "<cmd>LspTrouble lsp_references<CR>", true)
nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", true)
nmap("gl",'<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',true)
nmap("<C-space>", "<cmd>lua vim.lsp.buf.hover()<CR>", true)
vmap("<C-space>", "<cmd>RustHoverRange<CR>")

nmap("ge", "<cmd>lua vim.diagnostic.goto_prev()<CR>", true)
nmap("gE", "<cmd>lua vim.diagnostic.goto_next()<CR>", true)
nmap("<silent><leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
nmap("<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", true)
nmap("<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
vmap("<Leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")

nmap("<Leader>ld", "<cmd>LspTrouble lsp_definitions<CR>", true)
nmap("<Leader>le","<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",true)
nmap("<Leader>lE", "<cmd>LspTroubleWorkspaceToggle<CR>", true)

