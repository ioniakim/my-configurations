local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
    return
end

local set = vim.opt

set.list = true
set.listchars:append("space:⋅")
set.listchars:append("eol:↴")

ibl.setup()

