--
-- packages.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
local use = packer.use
local function bubbly_config()
  vim.g.bubbly_palette = {
    background = "#34343c",
    foreground = "#c5cdd9",
    black = "#3e4249",
    red = "#ec7279",
    green = "#a0c980",
    yellow = "#deb974",
    blue = "#6cb6eb",
    purple = "#d38aea",
    cyan = "#5dbbc1",
    white = "#c5cdd9",
    lightgrey = "#57595e",
    darkgrey = "#404247"
  }
end

local lisp_filetypes = {"lisp", "clojure", "scheme", "vlime_repl", "fennel", "query"}

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
    use {"wbthomason/packer.nvim", opt = true}
    use "nvim-lua/popup.nvim"
    use {"olimorris/onedark.nvim", requires = "rktjmp/lush.nvim", opt = true}
    use {
      "nvim-telescope/telescope-project.nvim",
      config = function()
        require "telescope".load_extension("project")
        vim.api.nvim_set_keymap(
          "n",
          "<c-q>",
          ":lua require'telescope'.extensions.project.project{}<CR>",
          {noremap = true, silent = true}
        )
      end,
      requires = "nvim-telescope/telescope.nvim"
    }
    use {"dstein64/nvim-scrollview", opt = true}
    use {"lucc/nvimpager"}
    use {"Mofiqul/vim-code-dark", opt = true}
    use {"TimUntersberger/neogit", opt = true}
    --use {
    --"nvim-lua/lsp_extensions.nvim",
    --ft = "rust",
    --config = function()
    --vim.cmd [[command! InlayHints :lua require "lsp_extensions".inlay_hints({enabled = {"TypeHint", "ChainingHint", "ParameterHint"}, highlight = "Comment", prefix = " ? "})]]
    --end
    --}
    use {
      "simrat39/rust-tools.nvim",
      --filetype = "rust",
      config = function()
        local opts = {
          autoSetHints = true
        }
        require("rust-tools").setup(opts)
      end
    }
    use "pwntester/octo.nvim"
    use {
      "glepnir/indent-guides.nvim",
      config = function()
        require("indent_guides").setup({})
      end,
      opt = true
    }
    use {"jiangmiao/auto-pairs", opt = true}
    use {"tpope/vim-endwise", ft = "lua", opt = true}
    use {"ojroques/nvim-lspfuzzy", opt = true}
    use {
      "steelsojka/pears.nvim",
      opt = false,
      config = function()
        local pears = require("pears")
        local config = require("pears.config")
        local utils = require("pears.utils")

        pears.setup()
        pears.config =
          config.make_user_config(
          function(c)
            c.pair(
              "{",
              {
                close = "}",
                should_expand = utils.negate(utils.has_leading_alpha)
              }
            )
            c.pair(
              "[",
              {
                close = "]",
                should_expand = utils.negate(utils.has_leading_alpha)
              }
            )
            c.pair(
              "'",
              {
                close = "'",
                should_expand = utils.negate(utils.has_leading_alpha)
              }
            )
            c.pair(
              "[",
              {
                close = "]",
                should_expand = utils.negate(utils.has_leading_alpha)
              }
            )
          end
        )
      end
    }
    --use {
    --"gabrielpoca/replacer.nvim",
    --config = function()
    --vim.api.nvim_set_keymap("n", "<Leader>hh", ':lua require("replacer").run()<cr>', {silent = true})
    --end
    --}
    use {"onsails/lspkind-nvim"}
    use {
      "hrsh7th/nvim-compe",
      config = function()
        require "compe".setup {
          enabled = true,
          autocomplete = true,
          debug = false,
          min_length = 2,
          preselect = "disable",
          throttle_time = 80,
          source_timeout = 200,
          incomplete_delay = 399,
          allow_prefix_unmatch = false,
          source = {
            path = true,
            buffer = true,
            calc = true,
            vsnip = false,
            nvim_lsp = true,
            nvim_lua = true,
            spell = true,
            tags = true,
            snippets_nvim = false
          }
        }
      end
    }
    --
    --

    use "mfussenegger/nvim-dap-python"
    use {
      "kosayoda/nvim-lightbulb",
      config = function()
        --vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      end,
      opt = true
    }
    --use {
    --"nvim-lua/completion-nvim",
    --config = function()
    --vim.cmd [[
    --autocmd BufEnter * lua if vim.bo.filetype~='dap-repl' then require'completion'.on_attach() end
    --]]
    --end
    --}
    --use "steelsojka/completion-buffers"
    use {"danilo-augusto/vim-afterglow", opt = true}
    use {"jubnzv/virtual-types.nvim"}
    use "ocaml/vim-ocaml"
    use {"kevinhwang91/nvim-hlslens", opt = true}
    use "ghifarit53/tokyonight-vim"
    use "akinsho/nvim-toggleterm.lua"
    use "chrisbra/unicode.vim"
    use "tpope/vim-speeddating"
    use "nvim-telescope/telescope-symbols.nvim"
    use {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end
    }
    --use {
    --"nvim-telescope/telescope-frecency.nvim",
    --config = function()
    --require "telescope".load_extension("frecency")
    --end
    --}
    --use "nvim-telescope/telescope.nvim"
    use "chuling/vim-equinusocio-material"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "theHamsta/nvim-treesitter-pairs"
    use "nvim-treesitter/nvim-treesitter-refactor"
    use {"nvim-treesitter/nvim-treesitter"}
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-tree-docs"
    use {"bluz71/vim-nightfly-guicolors", opt = true}
    use {"bluz71/vim-moonfly-colors", opt = true}
    use {"chriskempson/base16-vim", opt = true}
    use {"doums/darcula", opt = true}
    use {"strange/vim-lore", opt = true}
    use {"pineapplegiant/spaceduck", opt = true}
    use {"ghifarit53/daycula-vim", opt = true}
    use {"aonemd/kuroi.vim", opt = true}
    use {"srcery-colors/srcery-vim", opt = true}
    use {
      "novakne/kosmikoa.nvim",
      opt = true,
      config = function()
        require "kosmikoa".setup()
      end
    }
    use "ziglang/zig.vim"
    use "mfussenegger/nvim-jdtls"
    use "mattn/emmet-vim"
    use "rhysd/conflict-marker.vim"
    use {"mfussenegger/nvim-dap"}
    use "theHamsta/nvim-dap-virtual-text"
    use "theHamsta/crazy-node-movement"
    use "dm1try/git_fastfix"
    use "rafcamlet/nvim-luapad"
    use {"jsit/toast.vim", opt = true}
    --use {
    --"theHamsta/nvim_rocks",
    --run = "pip3 install --r hererocks && hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua"
    --}
    use "tjdevries/luvjob.nvim"
    use "nvim-lua/plenary.nvim"
    use "svermeulen/nvim-moonmaker"
    use "kbenzie/vim-spirv"
    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup {
          break_line_filetype = {"javascript", "cuda", "cpp", "java", "c", "typescript", "typescriptreact", "go"}
        }
        --vim.cmd [[inoremap <cr> :lua require('nvim-autopairs').check_break_line_char()<cr>]]
      end,
      opt = true
    }

    --use {"theHamsta/nvim-tree.lua", branch = "exa"}

    use {
      "nvim-telescope/telescope-dap.nvim",
      requires = "nvim-telescope/telescope.nvim"
    }
    use {
      "nvim-telescope/telescope-fzy-native.nvim",
      requires = "nvim-telescope/telescope.nvim",
      config = function()
        require("telescope").setup {
          extensions = {
            fzy_native = {
              override_generic_sorter = false,
              override_file_sorter = true
            }
          }
        }
        require("telescope").load_extension("fzy_native")
      end
    }
    use "Olical/nvim-local-fennel"
    use {"Olical/conjure", opt = true}
    use "bakpakin/fennel.vim"
    use "Olical/aniseed"
    use "camspiers/animate.vim"
    use "neovim/nvim-lspconfig"
    use "udalov/kotlin-vim"
    use {"preservim/tagbar", cmd = {"TagbarToggle", "TagbarOpenAutoClose"}}
    use "szymonmaszke/vimpyter"
    use {"voldikss/vim-floaterm", cmd = "FloatermToggle"}
    use "kkoomen/vim-doge"
    use "AndrewRadev/switch.vim"
    --use "JuliaEditorSupport/julia-vim"
    use "Julian/vim-textobj-variable-segment"
    use {"SirVer/ultisnips", opt = false}
    use "Valloric/ListToggle"
    --use "airblade/vim-gitgutter"
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      },
      opt = true,
      config = function()
        --if 1 ~= vim.g.GtkGuiLoaded then
        if true then
          require("gitsigns").setup {
            signs = {
              add = {hl = "GitGutterAdd", text = "▋", numhl = "GitSignsAddNr"},
              change = {hl = "GitGutterChange", text = "▐", numhl = "GitSignsChangeNr"},
              delete = {hl = "GitGutterDelete", text = "_", numhl = "GitSignsDeleteNr"},
              topdelete = {hl = "GitGutterDelete", text = "‾", numhl = "GitSignsDeleteNr"},
              changedelete = {hl = "GitGutterChange", text = "▐_", numhl = "GitSignsChangeNr"}
            },
            numhl = false,
            keymaps = {
              -- Default keymap options
              noremap = true,
              buffer = true,
              --['n <c-a-j>'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
              --['n <c-a-h>'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
              ["n <c-a-j>"] = '<cmd>lua require"gitsigns".next_hunk()<CR>',
              ["n <c-a-h>"] = '<cmd>lua require"gitsigns".prev_hunk()<CR>',
              ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
              ["n <leader>hr"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
              ["n <leader>hu"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
              ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
              ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
              -- Text objects
              ["o ah"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
              ["x ah"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
            },
            watch_index = {
              interval = 1000
            },
            sign_priority = 6,
            status_formatter = nil -- Use default
          }
        else
          require("gitsigns").setup {
            signs = {
              add = {hl = "GitGutterAdd", text = "+"},
              change = {hl = "GitGutterChange", text = "~"},
              delete = {hl = "GitGutterDelete", text = "_"},
              topdelete = {hl = "GitGutterDelete", text = "‾"},
              changedelete = {hl = "GitGutterChange", text = "~"}
            },
            numhl = false,
            keymaps = {
              -- Default keymap options
              noremap = true,
              buffer = true,
              ["n ]c"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''},
              ["n [c"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''},
              ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
              ["n <leader>hr"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
              ["n <leader>hu"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
              ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
              ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
              -- Text objects
              ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
              ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>'
            },
            watch_index = {
              interval = 1000
            },
            sign_priority = 6,
            status_formatter = nil -- Use default
          }
        end
      end
    }

    use "airblade/vim-rooter"
    use "bronson/vim-visual-star-search"
    use {"dbeniamine/cheat.sh-vim", cmd = {"Cheat"}}
    use "dyng/ctrlsf.vim"
    use {"euclio/vim-markdown-composer", run = "cargo build --release", cmd = "ComposerStart", ft = "markdown"}
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
    use {"preservim/nerdtree"}
    --use {"preservim/nerdtree", cmd = {"NERDTreeToggle", "NERDTreeFind"}}
    use {"tiagofumo/vim-nerdtree-syntax-highlight", cmd = {"NERDTreeToggle", "NERDTreeFind"}}
    use {"janko/vim-test", ft = {"rust", "python"}}
    use {"ionide/Ionide-vim", run = "make fsautocomplete", ft = "fsharp"}
    --use {"fsprojects/fsharp-language-server", run = "npm install && dotnet build -c Release"}
    --use { 'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile', ft = 'fsharp'}
    use {
      "autozimu/LanguageClient-neovim",
      branch = "next",
      run = "bash install.sh",
      ft = "fsharp"
    }
    use {"jceb/vim-orgmode", ft = "org"}
    use {"junegunn/fzf", run = ":call fzf#install()"}
    use "junegunn/fzf.vim"
    use "junegunn/goyo.vim"
    use "junegunn/gv.vim"
    use "junegunn/limelight.vim"
    use "justinmk/vim-gtfo"
    use {"justinmk/vim-sneak", opt = false}
    use "kassio/neoterm"
    use {"luochen1990/rainbow", disable = true}
    use {"lervag/vimtex", opt = true}
    use "machakann/vim-swap"
    use "p00f/nvim-ts-rainbow"
    use "markonm/traces.vim"
    use {"mbbill/undotree", cmd = {"UndotreeToggle"}}
    use {"meain/vim-package-info", run = "npm install"}
    use "mhinz/vim-startify"
    use "moll/vim-bbye"
    use {"jpalardy/vim-slime", opt = true}
    use "pboettch/vim-cmake-syntax"
    use {"peterhoeg/vim-qml", ft = "qml"}
    use "rhysd/git-messenger.vim"
    use "rking/ag.vim"
    use {"rust-lang/rust.vim", ft = {"rust", "toml"}}
    use "ryanoasis/vim-devicons"
    use "scrooloose/nerdcommenter"
    use "sgur/vim-textobj-parameter"
    use "skywind3000/vim-preview"
    use "terryma/vim-multiple-cursors"
    use "kana/vim-textobj-user"
    use "theHamsta/vim-snippets"
    use "theHamsta/vim-template"
    use "theHamsta/vim-textobj-entire"
    use "theHamsta/vim-rebase-mode"
    use "tpope/vim-eunuch"
    use "theHamsta/vim-fugitive"
    use {"tpope/vim-markdown", ft = "markdown"}
    use "tpope/vim-repeat"
    use "tpope/vim-rhubarb"
    use {"tpope/vim-sexp-mappings-for-regular-people", ft = lisp_filetypes}
    use {"guns/vim-sexp", ft = lisp_filetypes}
    use "tpope/vim-sleuth"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"
    use {"vim-airline/vim-airline", requires = "vim-airline/vim-airline-themes", opt = true}

    use {
      "glepnir/galaxyline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require "my_statusline"
      end,
      opt = false
    }
    use {"datwaft/bubbly.nvim", config = bubbly_config, disable = true}
    use "wellle/targets.vim"
    use "whiteinge/diffconflicts"
    use "TravonteD/luajob"
    --use "Shougo/deoplete-lsp"
    --use {"Shougo/deoplete.nvim", run = ":UpdateRemotePlugins"}
    use "rakr/vim-one"
  end
)
