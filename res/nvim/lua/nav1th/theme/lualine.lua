local status_ok,lualine = pcall(require, "lualine")
if not status_ok then
    vim.notify("failed to load lualine")
    return
end
lualine.setup{}
