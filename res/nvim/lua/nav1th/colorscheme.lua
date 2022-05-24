local colorscheme = "sonokai"
vim.g.solokai_style = 'shusia'
vim.g.sonokai_better_performance = 1
--Configure colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme ".. colorscheme)
if not status_ok then
    vim.notify("colorscheme "..colorscheme.." not found")
    vim.cmd("colorscheme default")
end

--Configure airline colorscheme if airline is installed
local status_ok, _ = pcall(vim.cmd, "AirlineTheme");
if status_ok then
    vim.g.airline_theme = colorscheme
end
