local autocmd = vim.api.nvim_create_autocmd

-- packer.nvim
-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

-- nvim-tree.nvim
-- auto close on the case only nvim-tree window is left.
autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nill then
            vim.cmd "quit"
        end
    end
})
