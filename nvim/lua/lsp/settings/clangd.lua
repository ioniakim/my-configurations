return {
    cmd = {
        "clangd",
        "--background-index",
        "--pch-storage=memory",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion-decorators",
        "--header-insertion=iwyu"
    },
    filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
}
