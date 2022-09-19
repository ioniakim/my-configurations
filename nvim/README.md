lua config를 기반으로 packer.nvim plugin manager로 환경 구성

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

# TODO
[x] Gather keymappings to keymaps.lua
[x] handlers.lua is too big. It may be better to separate some functions from it.
[x] Remap esc keymap on lazygit terminal. The esc key let the command window go in lazygit but on terminal the esc key is mapped to getting into normal mode
    * Set toggleterm opening keymap to <m-0> to utilize <c-\> back in terminal 
[x] Make notes on clangd and its configuration for nvim
[x] Review lsp config and fix some bugs

