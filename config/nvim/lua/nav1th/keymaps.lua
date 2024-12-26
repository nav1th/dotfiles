local M = {}
local opts =  {noremap = true, silent = true}
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
function M.nmap(lhs, rhs, silent)
  keymap("n", lhs, rhs, { noremap = true, silent = silent })
end

function M.imap(lhs, rhs)
  keymap("i", lhs, rhs, { noremap = true })
end

function M.vmap(lhs, rhs)
  keymap("v", lhs, rhs, { noremap = true })
end
local nmap = M.nmap
local imap = M.imap
local vmap = M.vmap

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

--Terminal
nmap("<A-t>",":ToggleTerm<CR>")
keymap("t", "<A-t>", "<C-\\><C-N>:ToggleTerm<CR>", term_opts)

keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", term_opts)

--Telescope
nmap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>")
nmap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>")


nmap("<CapsLock>","<Nop>")


-- Nvim file explorer
nmap("<leader>x",":NERDTreeToggle<CR>")

-- Resize with arrows
nmap("<A-Up>", ":resize -2<CR>")
nmap("<A-Down>", ":resize +2<CR>")
nmap("<A-Left>", ":vertical resize -2<CR>")
nmap("<A-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
nmap("<S-l>", ":bnext<CR>")
nmap("<S-h>", ":bprevious<CR>")
nmap("<S-x>",":bw<CR>")

--Navigate splits 
nmap("<c-k>",":wincmd k<CR>")
nmap("<c-j>",":wincmd j<CR>")
nmap("<c-h>",":wincmd h<CR>")
nmap("<c-l>",":wincmd l<CR>")

-- Stay in indent mode
vmap(">", ">gv")
vmap("<", "<gv")


-- Visual Block --
-- Move text up and down
keymap("x", "K", ":move '<-2<CR>gv-gv",opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv",opts)
keymap("x", "J", ":move '>+1<CR>gv-gv",opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv",opts)

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', 'd<', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'd>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<C-space>', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

return M
