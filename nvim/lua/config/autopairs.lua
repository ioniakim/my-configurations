local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

npairs.setup {
    check_ts = true, -- treesitter integration
    ts_config = {
        lua = { "string", "source" },
        java = false,
    },
    disble_filetype = { "TelescopePrompt" },
    fast_wrap = {},  -- enable fast_wrap
    enable_check_bracket_line = true, -- Don't add pairs if it already has a close pair in the same line
}

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done {}
)
