local colorscheme = "vscode"
vim.opt.background = "dark"
if colorscheme == "vscode" then
    vim.g.vscode_transparent = 1
    vim.g.vscode_style = "dark"
end
if colorscheme == "nightfox" or colorscheme == "carbonfox" or colorscheme == "duskfox" then
    require('nightfox').setup({
        carbonfox = {
            bg0 = "#1d1d2b"
        },
        options = {
            transparent = true
        }
    })
end
--Configure colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme ".. colorscheme)
if not status_ok then
    vim.notify("colorscheme "..colorscheme.." not found")
    vim.cmd("colorscheme default")
end

