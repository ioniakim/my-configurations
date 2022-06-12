local autocmd = vim.api.nvim_create_autocmd

require 'nvim-tree'.setup{
}

-- keymaps
local map = vim.keymap.set

map('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
map('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true })
map('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true })

-- auto close
autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nill then
            vim.cmd "quit"
        end
    end
})
