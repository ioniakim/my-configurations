local colorscheme = "darkplus"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    return
end

-- local set = vim.opt
-- local cmd = vim.cmd

-- -- color scheme
-- if vim.fn.has("termguicolors") == 1 then
--     set.termguicolors = true
-- end

-- cmd [[
-- syntax on
-- colorscheme dracula
-- ]]
