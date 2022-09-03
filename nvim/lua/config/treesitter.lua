require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = {"c", "cpp", "lua", "python", "java", "rust", "bash", "json", "html", "toml", "vim", "yaml" },
    -- Install parsers synchronously (only applied to ensure_installed)
    sync_install = true,
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true,              -- false will disable the whole extension
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
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
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

    context_commentstring = {
        enable = true
    }
}

