local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

local set = vim.opt

set.list = true
set.listchars:append("space:⋅")
set.listchars:append("eol:↴")

indent_blankline.setup{
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
    space_char_blankline = " ",
}
