-- Exit vim if NERDTree is the only window remaining in the only tab
local exit_on_only_nerd = function()
    vim.cmd [[
    if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() 
        \ | quit | endif
    ]]
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback  = exit_on_only_nerd 
})


-- If another buffer tries to replace NERDTree, put it in the other window, and
-- bring back NERDTree.
local open_on_other_window = function()
    vim.cmd [[
    if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+'
        \ && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" |
        \ execute 'buffer'.buf | endif
    ]]
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = open_on_other_window
})
