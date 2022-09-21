local status_ok, dial_config = pcall(require, "dial.config")
if not status_ok then
    return
end


local augend = require("dial.augend")
dial_config.augends:register_group {
    -- default augends used when no group name is specified
    default = {
        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        augend.integer.alias.octal, -- 0o00, 0o11
        augend.integer.alias.binary, -- 0b0101, 0b11001111
        augend.constant.alias.bool, -- boolean value (true <-> false)
        augend.constant.alias.alpha, -- Lowercase alphabet letter
        augend.constant.alias.Alpha, -- Uppercase alphabet letter
        augend.semver.alias.semver, -- Version major.minor.patch
        augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
    },

    -- augends used when group with name `mygroup` is specified
    normal = {
        augend.integer.alias.decimal, -- 0, 314, -1592, ...
        augend.integer.alias.hex, -- 0x00, 0x3f3f
        augend.integer.alias.octal, -- 0o00, 0o11
        augend.integer.alias.binary, -- 0b0101, 0b11001111
        augend.constant.alias.bool, -- boolean value (true <-> false)
        augend.constant.alias.alpha, -- Lowercase alphabet letter
        augend.constant.alias.Alpha, -- Uppercase alphabet letter
        augend.semver.alias.semver, -- Version major.minor.patch
        augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%-m/%-d"], -- date (2/1, 3/13)
        augend.date.alias["%H:%M"],
        augend.date.alias["%H:%M:%S"],
        augend.constant.alias.ja_weekday, -- 月, 火

        augend.constant.new {
            elements = { "public", "private" },
            word = true, -- if false, "apublic" is incremented into "aprivate"
            cyclic = true, -- "private" is incremented into "public"
        },

        augend.constant.new {
            elements = { "True", "False" },
            word = true,
            cyclic = true,
        },

        augend.constant.new {
            elements = { "TRUE", "FALSE" },
            word = true,
            cyclic = true,
        },

        augend.constant.new {
            elements = { "월", "화", "수", "목", "금", "토", "일" },
            workd = true,
            cycle = true,
        },

        augend.constant.new {
            elements = { "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일" },
            workd = true,
            cycle = true,
        },
    },

    visual = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.integer.alias.binary,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
    },

}

local statua_wk_ok, which_key = pcall(require, "which-key")
if not statua_wk_ok then
    return
end

local dial_map = require("dial.map")

--  NORMAL MODE keymaps
local normal_opts = {
    mode = "n", -- NORMAL mode
    prefix = nil,
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use 'silent' when creating keymaps
    noremap = true, -- use 'noremap' when creating keymaps
    nowait = true, -- use 'nowait' when creating keymaps
}

local normal_mappings = {
    ["<C-a>"] = { dial_map.inc_normal('normal'), "Increase" },
    ["<C-x>"] = { dial_map.dec_normal('normal'), "Decrease" },
}

-- VISUAL MODE keymaps
local visual_opts = {
    mode = "v", -- NORMAL mode
    prefix = nil,
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use 'silent' when creating keymaps
    noremap = true, -- use 'noremap' when creating keymaps
    nowait = true, -- use 'nowait' when creating keymaps
}

local visual_mappings = {
    ["<C-a>"] = { dial_map.inc_visual('visual'), "Increase" },
    ["<C-x>"] = { dial_map.dec_visual('visual'), "Decrease" },
    ["g<C-a>"] = { dial_map.inc_gvisual('visual'), "Increase" },
    ["g<C-x>"] = { dial_map.dec_gvisual('visual'), "Decrease" },
}


which_key.register(normal_mappings, normal_opts)
which_key.register(visual_mappings, visual_opts)
