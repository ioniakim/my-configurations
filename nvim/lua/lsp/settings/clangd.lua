return {
    cmd = {
        "clangd",
        "--background-index",
        "--pch-storage=memory",
        "--clang-tidy",
        "--suggest-missing-includes",
        "--cross-file-rename",
        "--completion-style=detailed",
        "--header-insertion-decorators",
        "--header-insertion=iwyu"
    },
    filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    -- root_dir = {
    -- },
    init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        -- semanticHighlighting = true,
    },
}
