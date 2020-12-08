--
-- packages.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
local use = packer.use

--packer.init {
--display = {
--open_fn = function()
--local current_win = api.nvim_get_current_win()

--vim.cmd 'vsplit'
--vim.cmd 'edit'
--local win = api.nvim_get_current_win()
--local buf = api.nvim_get_current_buf()
--api.nvim_set_current_win(current_win)
--return win, buf
--end
--}
--}

local go_packages = {
  "github.com/klauspost/asmfmt/cmd/asmfmt@master",
  "github.com/go-delve/delve/cmd/dlv@master",
  "github.com/kisielk/errcheck@master",
  "github.com/davidrjenni/reftools/cmd/fillstruct@master",
  "github.com/rogpeppe/godef@master",
  "golang.org/x/tools/cmd/goimports@master",
  "golang.org/x/lint/golint@master",
  "golang.org/x/tools/gopls@latest",
  "github.com/golangci/golangci-lint/cmd/golangci-lint@master",
  "honnef.co/go/tools/cmd/staticcheck@latest",
  "github.com/fatih/gomodifytags@master",
  "golang.org/x/tools/cmd/gorename@master",
  "github.com/jstemmer/gotags@master",
  "golang.org/x/tools/cmd/guru@master",
  "github.com/josharian/impl@master",
  "honnef.co/go/tools/cmd/keyify@master",
  "github.com/fatih/motion@master",
  "github.com/koron/iferr@master"
}

return packer.startup(
  function()
    use {'wbthomason/packer.nvim', opt = true}
    use "nvim-lua/popup.nvim"
    use {"liuchengxu/vista.vim"}
    use "mfussenegger/nvim-dap-python"
    use {"jubnzv/virtual-types.nvim", ft = 'ocaml'}
    use "ocaml/vim-ocaml"
    use "ghifarit53/tokyonight-vim"
    use "chrisbra/unicode.vim"
    use "nvim-lua/telescope.nvim"
    use "chuling/vim-equinusocio-material"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/nvim-treesitter-refactor"
    use {"nvim-treesitter/nvim-treesitter", run = ':TSUpdate'}
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-tree-docs"
    use "bluz71/vim-nightfly-guicolors"
    use "bluz71/vim-moonfly-colors"
    use {'doums/darcula', opt = true}
    use "ziglang/zig.vim"
    use "mfussenegger/nvim-jdtls"
    use "mattn/emmet-vim"
    use "rhysd/conflict-marker.vim"
    use {"theHamsta/nvim-dap", branch = "variable-ui"}
    use "theHamsta/nvim-dap-virtual-text"
    use "dm1try/git_fastfix"
    use "rafcamlet/nvim-luapad"
    use {"jsit/toast.vim", opt = true}
    use {
      "theHamsta/nvim_rocks",
      run = "pip3 install --r hererocks && hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua"
    }
    use "tjdevries/luvjob.nvim"
    use "tjdevries/plenary.nvim"
    use "svermeulen/nvim-moonmaker"
    use "kbenzie/vim-spirv"

    use {"theHamsta/nvim-tree.lua", branch = "exa"}

    use {"nvim-telescope/telescope-dap.nvim"}
    use "Olical/nvim-local-fennel"
    use "Olical/conjure"
    use "bakpakin/fennel.vim"
    use "Olical/aniseed"
    use "camspiers/animate.vim"
    use "neovim/nvim-lspconfig"
    use "udalov/kotlin-vim"
    use {"preservim/tagbar", cmd = {'TagbarToggle', 'TagbarOpenAutoClose'}}
    use "szymonmaszke/vimpyter"
    use "voldikss/vim-floaterm"
    use "kkoomen/vim-doge"
    use "AndrewRadev/switch.vim"
    use "JuliaEditorSupport/julia-vim"
    use "Julian/vim-textobj-variable-segment"
    use "SirVer/ultisnips"
    use "Valloric/ListToggle"
    use "airblade/vim-gitgutter"
    use "airblade/vim-rooter"
    use "bronson/vim-visual-star-search"
    use {"dbeniamine/cheat.sh-vim", cmd = {"Cheat"}}
    use "dyng/ctrlsf.vim"
    use {"euclio/vim-markdown-composer", run = "cargo build --release", cmd = "ComposerStart", ft = 'markdown'}
    --use {"fatih/vim-go", ft = "go", run = ":GoInstallBinaries"}
    use {
      "fatih/vim-go",
      ft = "go",
      run = table.concat(
        vim.tbl_map(
          function(p)
            return "go get -u " .. p
          end,
          go_packages
        ),
        " && "
      )
    }
    use {"theHamsta/vlime", branch = "prompt", rtp = "vim/", ft = "lisp"}
    use "hotwatermorning/auto-git-diff"
    use "idanarye/vim-merginal"

    use {"ivalkeen/nerdtree-execute", cmd = {"NERDTreeToggle", "NERDTreeFind"}}
    use {"Xuyuanp/nerdtree-git-plugin", cmd = {"NERDTreeToggle", "NERDTreeFind"}}
    use {"scrooloose/nerdtree", cmd = {"NERDTreeToggle", "NERDTreeFind"}}
    use {"tiagofumo/vim-nerdtree-syntax-highlight", cmd = {"NERDTreeToggle", "NERDTreeFind"}}
    use {"janko/vim-test", ft = {"rust", "python"}}
    use {"ionide/Ionide-vim", run = 'make fsautocomplete', ft = "fsharp" }
    --use {"fsprojects/fsharp-language-server", run = "npm install && dotnet build -c Release"}
    --use { 'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile', ft = 'fsharp'}
    use {
      "autozimu/LanguageClient-neovim",
      branch = "next",
      run = "bash install.sh",
      ft = 'fsharp',
    }
    use {"jceb/vim-orgmode", ft = "org"}
    use "jpalardy/vim-slime"
    use {"junegunn/fzf", run = ":call fzf#install()"}
    use "junegunn/fzf.vim"
    use "junegunn/goyo.vim"
    use "junegunn/gv.vim"
    use "junegunn/limelight.vim"
    use "justinmk/vim-gtfo"
    use "justinmk/vim-sneak"
    use "kassio/neoterm"
    use {"luochen1990/rainbow", disable = false}
    use {"lervag/vimtex", ft = "tex"}
    use "machakann/vim-swap"
    use "markonm/traces.vim"
    use {"mbbill/undotree", cmd = {"UndotreeToggle"}}
    use {"meain/vim-package-info", run = "npm install"}
    use "mhinz/vim-startify"
    use "moll/vim-bbye"
    use "pboettch/vim-cmake-syntax"
    use {"peterhoeg/vim-qml", ft = "qml"}
    use "rhysd/git-messenger.vim"
    use "rking/ag.vim"
    use {"rust-lang/rust.vim", ft = {"rust", "toml"}}
    use "ryanoasis/vim-devicons"
    use "scrooloose/nerdcommenter"
    use "sgur/vim-textobj-parameter"
    --use "skywind3000/vim-preview"
    use "terryma/vim-multiple-cursors"
    use "kana/vim-textobj-user"
    use "theHamsta/vim-snippets"
    use "theHamsta/vim-template"
    use "theHamsta/vim-textobj-entire"
    use "theHamsta/vim-rebase-mode"
    use "tpope/vim-eunuch"
    use "theHamsta/vim-fugitive"
    use {"tpope/vim-markdown", ft='markdown'}
    use "tpope/vim-repeat"
    use "tpope/vim-rhubarb"
    use {"tpope/vim-sexp-mappings-for-regular-people", ft = "lisp"}
    use {"guns/vim-sexp", ft = {"lisp", "clojure", "scheme", "vlime_repl", "fennel", "query"}}
    use "tpope/vim-sleuth"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"
    use {"vim-airline/vim-airline", requires="vim-airline/vim-airline-themes", opt=true}
    use {"glepnir/galaxyline.nvim", requires='kyazdani42/nvim-web-devicons', config=function() require'my_statusline' end }
    use "wellle/targets.vim"
    use "whiteinge/diffconflicts"
    use "TravonteD/luajob"
    use "Shougo/deoplete-lsp"
    use {"Shougo/deoplete.nvim", run = ":UpdateRemotePlugins"}
    use "rakr/vim-one"
  end
)
