packer plugin manager를 기반으로 구성하였음.

lua/ 에 config files을 두었음

# 기본 config files
* plugins.lua : 사용하는 plugins 지정
* my-setting.lua : 기본 nvim settings
* basic-keymap.lua : 기본 key-map
* win32yank.lua : wsl2에서 win32yank를 활용한 clipboard사용 설정
* colorscheme.lua : colorscheme 정의
* lualine-setup.lua : lualine 설정
* nvim-tree-setup.lua : nvim-tree 설정
* telescope-setup.lua : telescope 설정
* treesitter-config.lua : treesitter 설정 

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
