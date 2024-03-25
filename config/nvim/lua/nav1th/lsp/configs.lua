local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local installed_servers = {"taplo","asm_lsp","rust_analyzer","clangd", "arduino_language_server"} -- for servers i already have installed as binaries

for _,server in pairs(installed_servers) do
	local opts = {
		on_attach = require("nav1th.lsp.handlers").on_attach,
		capabilities = require("nav1th.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "nav1th.lsp.settings." .. server)
	if has_custom_opts then
	 	opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
    lspconfig[server].setup(opts)
end

