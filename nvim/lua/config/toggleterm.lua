local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end


toggleterm.setup({
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    open_mapping = [[<m-0>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = false,
    direction = "float",
    close_on_exit = true,
    shell = '"c:\\Program Files\\Git\\bin\\bash.exe"',
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

function _G.set_terminal_keymaps()
    local opts = { noremap = true, buffer = 0 }
    -- vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<cmd>wincmd h<cr>]], opts) -- wincmd: equals to <C-w> window command prefix, useful when a Normal mode cannot be used directly (eg. this case)
    vim.keymap.set("t", "<C-j>", [[<cmd>wincmd j<cr>]], opts)
    vim.keymap.set("t", "<C-k>", [[<cmd>wincmd k<cr>]], opts)
    vim.keymap.set("t", "<C-l>", [[<cmd>wincmd l<cr>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

