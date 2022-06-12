local set = vim.opt
local cmd = vim.cmd

-- color scheme
if vim.fn.has("termguicolors") == 1 then
    set.termguicolors = true
end

vim.cmd [[
syntax on 
colorscheme dracula
]]

