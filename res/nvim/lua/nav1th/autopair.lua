local status_ok, autopair = pcall(require, "nvim-autopairs")
if not status_ok then
    vim.notify("autopairs failed to work")
    return
end
autopair.setup{}
