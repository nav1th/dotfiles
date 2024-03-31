local status_ok, indentline = pcall(require, "ibl")
if not status_ok then
    vim.notify("indentline config failed to work")
    return
end
indentline.setup()
