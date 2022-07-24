require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = ""},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {
            "branch",
            {
                "diff",
                colored = true, -- Displays a colored diff status if set to true
                diff_color = {
                    -- Same color values as the general color option can be used here
                    added = "DiffAdd", -- Changes the diff's added color
                    modified = "DiffChanged", -- Changes the diff's modified color
                    removed = "DiffDelete" -- Changes the diff's removed color 
                },
                symbols = {added = "+", modified = "~", removed = "-"},
                source = nil
            },
            "diagnostics"},
    lualine_c = {"filename"},
    lualine_x = {"encoding", "fileformat", "filetype", "filesize"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
