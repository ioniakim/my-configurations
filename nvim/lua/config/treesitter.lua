local status_ok, _ = pcall(require, "nvim-treesitter")
if not status_ok then
    return
end

require("nvim-treesitter.install").prefer_git = true

local configs = require("nvim-treesitter.configs")

configs.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "cpp", "lua", "python", "java", "rust", "bash", "json", "html", "toml", "vim", "yaml" },
    -- Install parsers synchronously (only applied to ensure_installed)
    sync_install = true,
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true
    },

    -- refactor = {
    --     highlight_definitions = {
    --         enable = true,
    --         -- Set to false if you have an 'updatetime' of ~100
    --         clear_on_cursor_move = true
    --     },

    --     -- Highlights the block from the current scope where the cursor is
    --     highlight_current_scope = { enable = false },

    --     -- Renames the symbol under the cursor within the current scope (and current file).
    --     smart_rename = {
    --         enable = true,
    --         keymaps = {
    --             smart_rename = "grr"
    --         }
    --     },

    --     navigation = {
    --         enable = true,
    --         keymaps = {
    --             goto_definition = "gnd",
    --             list_definitions = "gnD",
    --             list_definitions_toc = "gO",
    --             goto_next_usage = "<a-*>",
    --             goto_previous_usage = "<a-#>"
    --         }
    --     }
    -- },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["at"] = "@class.outer",
                ["it"] = "@class.inner",
                ["ac"] = "@call.outer",
                ["ic"] = "@call.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",
                ["a/"] = "@comment.outer",
                ["i/"] = "@comment.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["as"] = "@statement.outer",
                ["is"] = "@scopename.inner",
                ["aA"] = "@attribute.outer",
                ["iA"] = "@attribute.inner",
                ["aF"] = "@frame.outer",
                ["iF"] = "@frame.inner",
            },
        },

        -- You can choose the select mode (default is charwise 'v')
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
        },

        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = { query = "@class.outer", desc = "Next class start" },

                -- You can use regex matching (i.e. lua pattern) and/or pass a list a "query" key to group multiple queires.
                ["]o"] = "@loop.*",

                -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm
                ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },

        swap = {
            enable = true,
            swap_next = {
                ["<leader>."] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>,"] = "@parameter.inner",
            },
        },
    },
}


local status_ok, commentstring = pcall(require, "ts_context_commentstring")
if not status_ok then
    return
end

commentstring.setup {
    enable_autocmd = false,
}


