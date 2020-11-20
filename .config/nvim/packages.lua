--
-- packages.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--
vim.cmd [[packadd packer.nvim]]

local use = require'packer'.use

return require('packer').startup(function()
    use 'nvim-lua/popup.nvim'
    use 'mfussenegger/nvim-dap-python'
    use 'ghifarit53/tokyonight-vim'
    use 'chrisbra/unicode.vim'
    use 'nvim-lua/telescope.nvim'
    use 'chuling/vim-equinusocio-material'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'theHamsta/nvim-treesitter'
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-tree-docs'
    use 'bluz71/vim-nightfly-guicolors'
    use 'bluz71/vim-moonfly-colors'
    use 'ziglang/zig.vim'
    use 'mfussenegger/nvim-jdtls'
    use 'mattn/emmet-vim'
    use 'rhysd/conflict-marker.vim'
    use 'mfussenegger/nvim-dap'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'dm1try/git_fastfix'
    use 'rafcamlet/nvim-luapad'
    use {'theHamsta/nvim_rocks', run = 'pip3 install --r hererocks && hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua'}
    use 'tjdevries/luvjob.nvim'
    use 'tjdevries/plenary.nvim'
    use 'svermeulen/nvim-moonmaker'
    use 'kbenzie/vim-spirv'

    use {'theHamsta/nvim-tree.lua', branch= 'exa'}
    use 'Olical/nvim-local-fennel'
    use 'Olical/conjure'
    use 'bakpakin/fennel.vim'
    use 'Olical/aniseed'
    use 'camspiers/animate.vim'
    use 'neovim/nvim-lspconfig'
    use 'udalov/kotlin-vim'
    use  'szymonmaszke/vimpyter'
    use 'voldikss/vim-floaterm'
    use 'kkoomen/vim-doge'
    use 'AndrewRadev/switch.vim'
    use 'JuliaEditorSupport/julia-vim'
    use 'Julian/vim-textobj-variable-segment'
    use 'SirVer/ultisnips'
    use 'Valloric/ListToggle'
    use 'airblade/vim-gitgutter'
    use 'airblade/vim-rooter'
    use 'bronson/vim-visual-star-search'
    use {'cespare/vim-toml', ft = 'toml'}
    use { 'dbeniamine/cheat.sh-vim', cmd =  {'Cheat!'} }
    use 'dyng/ctrlsf.vim'
    use {'euclio/vim-markdown-composer', run =  'cargo build --release',  cmd = ':ComposerStart'}
    use {'fatih/vim-go', ft = 'go', run = ':GoInstallBinaries'}
    use {'theHamsta/vlime', branch= 'prompt', rtp= 'vim/', ft='lisp'}
    use 'hotwatermorning/auto-git-diff'
    use 'idanarye/vim-merginal'

    use {'ivalkeen/nerdtree-execute', ft =  { 'NERDTreeToggle', 'NERDTreeFind' }}
    use {'Xuyuanp/nerdtree-git-plugin'  , ft =  { 'NERDTreeToggle', 'NERDTreeFind' }}
    use {'scrooloose/nerdtree' , ft =  { 'NERDTreeToggle', 'NERDTreeFind' }}
    use {'tiagofumo/vim-nerdtree-syntax-highlight' , cmd = { 'NERDTreeToggle', 'NERDTreeFind' }}
    use 'janko/vim-test'
    use 'fsharp/vim-fsharp'
    use 'fsprojects/fsharp-language-server'
    use 'jceb/vim-orgmode'
    use 'jpalardy/vim-slime'
    use {'junegunn/fzf', run = function() vim.cmd 'call fzf#install' end }
    use 'junegunn/fzf.vim'
    use 'junegunn/goyo.vim'
    use 'junegunn/gv.vim'
    use 'junegunn/limelight.vim'
    use 'justinmk/vim-gtfo'
    use 'justinmk/vim-sneak'
    use 'kassio/neoterm'
    use 'luochen1990/rainbow'
    use {'lervag/vimtex', ft = 'tex'}
    use 'machakann/vim-swap'
    use {'maralla/vim-toml-enhance', ft = 'toml'}
    use 'markonm/traces.vim'
    use {'mbbill/undotree', cmd=  { 'UndotreeToggle' }}
    use {'meain/vim-package-info', run= 'npm install'}
    use 'mhinz/vim-startify'
    use 'moll/vim-bbye'
    use 'pboettch/vim-cmake-syntax'
    use {'peterhoeg/vim-qml', ft = 'qml'}
    use 'rhysd/git-messenger.vim'
    use 'rking/ag.vim'
    use {'rust-lang/rust.vim', ft = {'rust', 'toml'}}
    use 'ryanoasis/vim-devicons'
    use 'scrooloose/nerdcommenter'
    use 'sgur/vim-textobj-parameter'
    use 'skywind3000/vim-preview'
    use 'terryma/vim-multiple-cursors'
    use 'kana/vim-textobj-user'
    use 'theHamsta/vim-snippets'
    use 'theHamsta/vim-template'
    use 'theHamsta/vim-textobj-entire'
    use 'theHamsta/vim-rebase-mode'
    use 'tpope/vim-eunuch'
    use 'theHamsta/vim-fugitive'
    use 'tpope/vim-markdown'
    use 'tpope/vim-repeat'
    use 'tpope/vim-rhubarb'
    use {'tpope/vim-sexp-mappings-for-regular-people', ft = 'lisp'}
    use {'guns/vim-sexp', ft = { 'lisp', 'clojure', 'scheme', 'vlime_repl', 'fennel', 'query' }}
    use 'tpope/vim-sleuth'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'wellle/targets.vim'
    use 'whiteinge/diffconflicts'
    use 'TravonteD/luajob'
    use 'Shougo/deoplete-lsp'
    use {'Shougo/deoplete.nvim', cmd = 'UpdateRemotePlugins'}
    use 'rakr/vim-one'
  end)
