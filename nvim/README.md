lua config를 기반으로 packer.nvim plugin manager로 환경 구성

# TODO
[x] Gather keymappings to keymaps.lua
[x] handlers.lua is too big. It may be better to separate some functions from it.
[x] Remap esc keymap on lazygit terminal. The esc key let the command window go in lazygit but on terminal the esc key is mapped to getting into normal mode
    * Set toggleterm opening keymap to <m-0> to utilize <c-\> back in terminal 
[x] Make notes on clangd and its configuration for nvim
[x] Review lsp config and fix some bugs


# 원칙
* lua config 사용
* 설정의 종류에 따라 각각 분리 저장하여 config파일이 단순하도록 함.
* config를 구조적으로 구성

# 구조
* nvim/
    * init.lua
    * lua/ : nvim configuration
        * plugins.lua : 사용하는 plugins 지정
        * options.lua : 기본 nvim settings
        * keymaps.lua : 기본 key-map
        * autocmd.lua : autocommand 설정
        * colorscheme.lua : colorscheme 정의
        * win32yank.lua : wsl2에서 win32yank를 활용한 clipboard사용 설정
    * config/ : plugin configuration
        * lualine.lua : lualine 설정
        * nvim-tree.lua : nvim-tree 설정
        * telescope.lua : telescope 설정
        * treesitter.lua : treesitter 설정 

# Plugins
lua/plugins.lua 파일에 사용하는 plugins 지정
* wbthomason/packer.nvim
* kyazdani42/nvim-tree.lua
* kyazdani42/nvim-web-devicons
* nvim-telescope/telescope.nvim
* nvim-lua/plenary.nvim
* nvim-treesitter/nvim-treesitter
* mhinz/vim-startify
* Mofiqul/dracula.nvim
* nvim-lualine/lualine.nvim


# Preventing Nested Neovim Processes
neovim-remote lets us to open files in the current nvim process from terminal mode.
It depends on the Python 3 Neovim client that must be installed first.
```bash
$ pip3 install --user --upgrade neovim
$ pip3 install --user --upgrade neovim-remote
$ nvr -h
```

In terminal mode, use nvr command instead of nvim.
```
>> nvr {file}
```

In order to prevent launching a nested neovim process accidentally, an alias needs to be set.
This alias will be defined only when bash is runnint inside a terminal buffer.
```bash
if [ -n "$NVIM" ]; then
    if [ -x "$(command -v nvr)" ]; then
        alias nvim=nvr
    else
        alias nvim='echo "No nesting!"'
    fi
fi
```
if nvr is installed, then typing nvim will call nvr. Otherwise, "No nesting" will be printed.
