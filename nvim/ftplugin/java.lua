local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_cmp_ok then
    capabilities.textDocument.completion.completionItem.snippetSupport = false
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

-- local jdtls_dir = vim.fn.expand("~/.local/share/nvim/lsp_servers/jdtls")
local jdtls_dir = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls")
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")


local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

JAVA_DAP_ACTIVE = true

local bundles = {
    vim.fn.glob(
        "~/.local/programs/lsp/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
    ),
}

vim.list_extend(bundles, vim.split(vim.fn.glob("~/.local/programs/lsp/vscode-java-test/server/*.jar"), "\n"))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        -- 💀
        "java", -- or '/path/to/java11_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. jdtls_dir .. "/lombok.jar",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",

        -- 💀
        "-jar", jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

        -- 💀
        "-configuration", jdtls_dir .. "/config_linux",

        -- 💀
        -- See `data directory configuration` section in the README
        "-data", vim.fn.expand("~/.cache/jdtls-workspace/") .. workspace_dir,
    },

    on_attach = require("lsp.handlers").on_attach,
    capabilities = capabilities;

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            -- Set this to true to use jdtls as your formatter
            format = {
                enabled = false,
            },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                -- "org.hamcrest.MatcherAssert.assertThat",
                -- "org.hamcrest.Matchers.*",
                -- "org.hamcrest.CoreMatchers.*",
                "org.assertj.core.api.Assertions.assertThat",
                "org.assertj.core.api.Assertions.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
        },
        contentProvider = { preferred = "fernflower" },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },

    flags = {
        allow_incremental_sync = true,
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        -- bundles = {}
        bundles = bundles
    },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.java" },
    callback = function()
        vim.lsp.codelens.refresh()
    end,
})


-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)

vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require('jdtls')._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require('jdtls')._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)")
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
vim.cmd("command! -buffer JdtJol lua require('jdtls').jol()")
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

local status_wk_ok, which_key = pcall(require, "which-key")
if not status_wk_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- Use 'silent' when creating keymaps
    noremap = true, -- Use 'noremap' when creating keymaps
    nowait = true, -- Use 'nowait' when creating keymaps
}

local mappings = {
    l = {
        name = "LSP",
        J = {
            name = "Java",
            o = { "<Cmd>lua require('jdtls').organize_imports()<CR>", "Organize Imports" },
            v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
            c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant" },
            t = { "<Cmd>lua require('jdtls').test_nearest_method()<CR>", "Test Method" },
            T = { "<Cmd>lua require('jdtls').test_class()<CR>", "Test Class" },
            u = { "<Cmd>JdtUpdateConfig<CR>", "Update Config" },
        },
    }
}

local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- Use 'silent' when creating keymaps
    noremap = true, -- Use 'noremap' when creating keymaps
    nowait = true, -- Use 'nowait' when creating keymaps
}

local vmappings = {
    l = {
        name = "LSP",
        J = {
            name = "Java",
            v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
            c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant" },
            m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
        },
    }
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)


-- If using nvim-dap
-- -- This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
-- nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
-- nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
