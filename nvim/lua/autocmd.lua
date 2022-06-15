
-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])
