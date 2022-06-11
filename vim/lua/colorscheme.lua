local set = vim.opt

-- color scheme
if vim.fn.has("termguicolors") == 1 then
    set.termguicolors = true
end
vim.cmd [[
    syntax enable
    colorscheme afterglow
    ]]

