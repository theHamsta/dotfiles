-- packages.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.  vim.cmd [[packadd packer.nvim]]
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local lisp_filetypes = { "lisp", "clojure", "scheme", "vlime_repl", "fennel", "query" }

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
  "github.com/koron/iferr@master",
}

require("lazy").setup {
  {
    "RaafatTurki/hex.nvim",
    config = function()
      require("hex").setup()
    end,
  },
  --{ "kiyoon/jupynium.nvim", run = "pip3 install --user . --break-system-packages" },
  {
    "gabrielpoca/replacer.nvim",
    keys = "<leader>rG",
    config = function()
      vim.keymap.set("n", "<leader>rG", function()
        require("replacer").run { rename_files = false }
      end, { nowait = true, noremap = true, silent = true })
    end,
  },
  { "krady21/compiler-explorer.nvim", cmd = "CECompile" },
  {
    "liangxianzhe/nap.nvim",
    config = function()
      require("nap").setup {
        next_prefix = "<c-a-l>",
        prev_prefix = "<c-a-h>",
        next_repeat = "<c-a-l>",
        prev_repeat = "<c-a-h>",
      }
    end,
    event = "VeryLazy",
  },
  {
    "chrisgrieser/nvim-alt-substitute",
    opts = true,
    event = "CmdlineEnter",
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup()
    end,
  },
  { "folke/neodev.nvim" },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
    enabled = false,
  },
  {
    "phaazon/mind.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("mind").setup {}
    end,
    enabled = false,
  },
  {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup()
    end,
    keys = "<leader>os",
    cmd = { "OverseerRun", "OverseerOpen", "OverseerToggle" },
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
      require("lsp-inlayhints").setup()
      --require("inlay-hints").setup {
      --renderer = "inlay-hints/render/eol",
      --only_current_line = false,
      --eol = {
      --right_align = false,
      --},
      --}
    end,
    branch = "anticonceal",
  },
  "rafamadriz/friendly-snippets",
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config { virtual_lines = false, virtual_text = true }
    end,
    enabled = vim.fn.has "win32" ~= 1,
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },
  {
    "mrbjarksen/neo-tree-diagnostics.nvim",
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup {
        symbol_in_winbar = {
          enable = false,
          separator = " ",
          hide_keyword = true,
          show_file = true,
          folder_level = 2,
          respect_root = false,
          color_mode = true,
        },
      }
    end,
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
    lazy = true,
  },

  { "github/copilot.vim", lazy = true },
  {
    "emmanueltouzery/agitator.nvim",
    config = function()
      vim.cmd [[
nnoremap <silent> <leader>gt  :lua require'agitator'.open_file_git_branch()<cr>
    ]]
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        --winbar = {
        --lualine_a = { "mode" },
        --lualine_b = { "branch", "diff", "diagnostics" },
        --lualine_c = {
        --function()
        --return vim.fn.expand "%"
        --end,
        --},
        --lualine_x = {
        --function()
        --return table.concat(
        --vim.tbl_map(function(server)
        --return server.name
        --end, vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }),
        --" "
        --)
        --end,
        --"encoding",
        --"fileformat",
        --"filetype",
        --},
        --lualine_y = { "progress" },
        --lualine_z = { "location" },
        --},
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            function()
              return vim.fn.expand "%"
            end,
          },
          lualine_x = {
            function()
              return table.concat(
                vim.tbl_map(function(server)
                  return server.name
                end, vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }),
                " "
              )
            end,
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      }
    end,
    event = "VeryLazy",
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local function select_executables(executables)
        return vim.tbl_filter(function(c)
          return c ~= vim.NIL and vim.fn.executable(c) == 1
        end, executables)
      end
      require("lint").linters_by_ft = {
        markdown = select_executables { "markdownlint" },
        lua = select_executables { "luacheck" },
        glsl = select_executables { "glslc" },
        hlsl = select_executables { "dxc" },
      }
      table.insert(require("lint").linters.glslc.args, "--target-env=vulkan1.3")
      table.insert(require("lint").linters.dxc.args, "-spirv")
      table.insert(require("lint").linters.dxc.args, "-fspv-target-env=vulkan1.3")
      vim.cmd [[au BufEnter,BufWritePost * lua require('lint').try_lint()]]
    end,
    ft = { "hlsl", "glsl", "lua" },
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
    lazy = true,
  },
  { "mattboehm/vim-unstack", cmd = "UnstackFromText" },
  {
    "leoluz/nvim-dap-go",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("dap-go").setup {}
    end,
    ft = "go",
    --enabled = false,
  },
  {
    "ggandor/leap.nvim",
    keys = "s",
    config = function()
      require("leap").add_default_mappings()
      vim.keymap.del({ "n", "x", "o" }, "x")
    end,
  },
  --{
  --"ggandor/leap-spooky.nvim",
  --config = function()
  --require("leap-spooky").setup {
  --affixes = {
  ---- These will generate mappings for all native text objects, like:
  ---- (ir|ar|iR|aR|im|am|iM|aM){obj}.
  ---- Special line objects will also be added, by repeating the affixes.
  ---- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
  ---- window.
  ---- You can also use 'rest' & 'move' as mnemonics.
  --remote = { window = "r", cross_window = "R" },
  --magnetic = { window = "m", cross_window = "M" },
  --},
  ---- If this option is set to true, the yanked text will automatically be pasted
  ---- at the cursor position if the unnamed register is in use.
  --paste_on_remote_yank = false,
  --}
  --end,
  --},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    config = function()
      require("neo-tree").setup {
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "diagnostics",
          -- ...and any additional source
        },
        filesystem = {
          use_libuv_file_watcher = true,
          follow_current_file = true,
          filtered_items = {
            hide_dotfiles = false,
          },
        },
        window = {
          position = "left",
          mappings = {
            --["/"] = "normal! /",
          },
        },
        source_selector = {
          winbar = true,
          statusline = false,
        },
      }
    end,
    --cmd = { "Neotree" },
  },
  { "ray-x/lsp_signature.nvim" },
  {
    "L3MON4D3/LuaSnip",
    build = vim.fn.has "win32" ~= 1 and "make install_jsregexp" or nil,
    config = function()
      require "theHamsta_luasnips"
      require("luasnip.loaders.from_snipmate").lazy_load()

      vim.cmd [[
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
    ]]
    end,
    keys = "<tab>",
    dependencies = {},
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      --"quangnguyen30192/cmp-nvim-ultisnips",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-emoji",
      --"rcarriga/cmp-dap",
      --"kdheepak/cmp-latex-symbols",
    },
    event = "VeryLazy",
    config = function()
      -- Setup nvim-cmp.
      local cmp = require "cmp"
      cmp.mapping.preset["<C-y>"] = {
        i = cmp.mapping.confirm { select = true },
      }

      cmp.setup {
        experimental = {
          ghost_text = false,
        },
        view = {
          entries = "native",
        },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            --vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
          end,
        },
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" -- or require("cmp_dap").is_dap_buffer()
        end,
        sources = cmp.config.sources({
          { name = "jupynium", priority = 1000 },
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          --{ name = "ultisnips" }, -- For ultisnips users.
          { name = "emoji", insert = true },
          --{ name = "latex_symbols" },
          { name = "crates" },
          --{ name = "neorg" },
          --{ name = "dap" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },
  {
    "doxnit/cmp-luasnip-choice",
    config = function()
      require("cmp_luasnip_choice").setup {
        auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
      }
    end,
    event = "VeryLazy",
  },
  --{
  --"p00f/clangd_extensions.nvim",
  --ft = { "cuda", "cpp", "c" },
  --},
  { "earthly/earthly.vim", ft = "earthly" },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
      --vim.cmd[[nnoremap <leader>nd :DiffviewOpen<cr>]]
    end,
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      local mark = require "harpoon.mark"
      local ui = require "harpoon.ui"
      vim.keymap.set("n", ",ha", mark.add_file)
      vim.keymap.set("n", ",hn", ui.nav_next)
      vim.keymap.set("n", ",hp", ui.nav_prev)
      vim.keymap.set("n", ",hh", ui.toggle_quick_menu)
      require("telescope").load_extension "harpoon"
    end,
    enabled = false,
  },
  {
    "https://gitlab.com/yorickpeterse/nvim-pqf",
    config = function()
      require("pqf").setup {}
    end,
    enabled = vim.fn.has "win32" ~= 1,
  },
  { "jceb/emmet.snippets" },
  { "theHamsta/vim-snippets" },
  {
    "beauwilliams/focus.nvim",
    enabled = false,
    config = function()
      require("focus").setup()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    config = function()
      require("symbols-outline").setup {}
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
    cmd = "Zenmode",
  },
  { "nanotee/zoxide.vim", cmd = { "Z", "Zi" } },
  "nvim-lua/popup.nvim",
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
  { "mcchrish/nnn.vim", cmd = { "NnnPicker" } },
  --"jceb/emmet.snippets",
  {
    "folke/lsp-trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {}
    end,
    cmd = { "Trouble" },
  },
  { "windwp/nvim-ts-autotag", enabled = false },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  { "mfussenegger/nvim-treehopper", keys = "<space><space>" },
  { "dstein64/nvim-scrollview", enabled = false },
  { "TimUntersberger/neogit", cmd = { "Neogit" } },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      --local ih = require "inlay-hints"

      require("rust-tools").setup {
        tools = {
          on_initialized = function()
            --ih.set_all()
          end,
          inlay_hints = {
            auto = false,
          },
        },
        server = {
          on_attach = function(client, buffer)
            require("lsp-inlayhints").on_attach(client, buffer)
            --ih.on_attach(c, b)
          end,
        },
      }
    end,
    enable = true,
  },
  { "pwntester/octo.nvim", enabled = false },
  {
    "glepnir/indent-guides.nvim",
    config = function()
      require("indent_guides").setup {}
    end,
    enabled = false,
  },
  { "jiangmiao/auto-pairs", enabled = false },
  --{
  --"nvim-lua/lsp-status.nvim",
  --config = function()
  --local lsp_status = require "lsp-status"
  --lsp_status.register_progress()
  --end,
  --enabled = false,
  --},
  { "ojroques/nvim-lspfuzzy", enabled = false },
  {
    "ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
    --keys = { "<space>gy", mode = { "n", "v", "V" } },
    events = "VeryLazy",
  },
  --{ "onsails/lspkind-nvim" },
  --use {
  --"hrsh7th/nvim-compe",
  --opt = false,
  --config = function()
  --require("compe").setup {
  --enabled = true,
  --autocomplete = true,
  --debug = false,
  --min_length = 2,
  --preselect = "disable",
  --throttle_time = 100,
  --source_timeout = 200,
  --incomplete_delay = 399,
  --allow_prefix_unmatch = false,
  --source = {
  --path = true,
  --buffer = true,
  --calc = false,
  --ultisnips = false,
  --emoji = false,
  --vsnip = false,
  --nvim_lsp = true,
  --nvim_lua = true,
  --spell = true,
  --tags = true,
  --snippets_nvim = false,
  --},
  --}
  --end,
  --}
  --
  --

  "mfussenegger/nvim-dap-python",
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      --vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    end,
    enabled = false,
  },
  { "danilo-augusto/vim-afterglow", enabled = false },
  { "kevinhwang91/nvim-hlslens", enabled = false },
  --{
  --"norcalli/snippets.nvim",
  --config = function()
  --vim.cmd [[inoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>]]
  --end,
  --},
  { "tpope/vim-speeddating", enabled = false },
  { "nvim-telescope/telescope-symbols.nvim", enabled = false },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    config = function()
      require("dapui").setup {
        icons = { expanded = "", collapsed = "", current_frame = "" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- Use this to override mappings for specific elements
        element_mappings = {
          -- Example:
          -- stacks = {
          --   open = "<CR>",
          --   expand = "o",
          -- }
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has "nvim-0.7" == 1,
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40, -- 40 columns
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
        },
        controls = {
          -- Requires Neovim nightly (or 0.8 when released)
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = "pause",
            play = "play",
            step_into = "step into",
            step_over = "step over",
            step_out = "step out",
            step_back = "step back",
            run_last = "run last",
            terminate = "terminate",
          },
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        },
      }
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
  { "theHamsta/nvim-treesitter-commonlisp", ft = "lisp" },
  { "nvim-treesitter/nvim-treesitter-refactor", event = "VeryLazy" },
  {
    "Badhi/nvim-treesitter-cpp-tools",
    ft = { "cpp", "cuda" },
    config = function()
      require("nt-cpp-tools").setup {}
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
  },
  { "nvim-treesitter/playground", keys = "<leader>pl" },
  { "theHamsta/crazy-node-movement", event = "VeryLazy" },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup {
        open_fold_hl_timeout = 100,
        provider_selector = function(_bufnr, _filetype, _buftype)
          return { "treesitter", "indent" }
        end,
      }
    end,
    --keys = { "zc", "zC", "zO", "zo" },
    event = "VeryLazy",
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        enabled = true,
      }
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = { "Neogen" },
  },
  "rhysd/conflict-marker.vim",
  "mfussenegger/nvim-dap",
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup {
        --only_first_definition = true,
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        virt_text_pos = vim.fn.has "nvim-0.10" == 1 and "inline" or "eol", -- use `vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol'` for inlined text if supported
      }
    end,
    branch = "master",
  },
  --{ "theHamsta/crazy-node-movement", keys = { "<a-l>", "<a-k>", "<a-j>", "<a-h>" } },
  --"dm1try/git_fastfix",
  "rafcamlet/nvim-luapad",
  { "jsit/toast.vim", enabled = false },
  --use {
  --"theHamsta/nvim_rocks",
  --build = "pip3 install --r hererocks && hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua"
  --}
  "tjdevries/luvjob.nvim",
  --"svermeulen/nvim-moonmaker",
  "kbenzie/vim-spirv",
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension "dap"
    end,
    lazy = true,
  },
  {
    "nvim-telescope/telescope-fzy-native.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("telescope").setup {
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          },
        },
      }
      require("telescope").load_extension "fzy_native"
    end,
  },
  --{"Olical/conjure", enabled = false},
  --"Olical/nvim-local-fennel",
  --"bakpakin/fennel.vim",
  --"Olical/aniseed",
  --"szymonmaszke/vimpyter",
  "camspiers/animate.vim",
  "neovim/nvim-lspconfig",
  { "preservim/tagbar", cmd = { "TagbarToggle", "TagbarOpenAutoClose" } },
  { "voldikss/vim-floaterm", cmd = "FloatermToggle" },
  { "kkoomen/vim-doge", enabled = false },
  { "AndrewRadev/switch.vim", cmd = "Switch" },
  --"JuliaEditorSupport/julia-vim",
  --{ "SirVer/ultisnips", opt = false, build = ":UpdateRemotePlugins" },
  "Valloric/ListToggle",
  --"airblade/vim-gitgutter",
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { hl = "GitGutterAdd", text = "▋", numhl = "GitSignsAddNr" },
          change = { hl = "GitGutterChange", text = "▐", numhl = "GitSignsChangeNr" },
          delete = { hl = "GitGutterDelete", text = "_", numhl = "GitSignsDeleteNr" },
          topdelete = { hl = "GitGutterDelete", text = "‾", numhl = "GitSignsDeleteNr" },
          changedelete = { hl = "GitGutterChange", text = "▐_", numhl = "GitSignsChangeNr" },
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
          ["x ah"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
        },
        watch_gitdir = {
          interval = 1000,
        },
        sign_priority = 6,
        status_formatter = nil, -- Use default
      }
    end,
  },

  "airblade/vim-rooter",
  --"bronson/vim-visual-star-search",
  { "dbeniamine/cheat.sh-vim", cmd = { "Cheat" } },
  --{ "dyng/ctrlsf.vim", cmd = { "CtrlSFPrompt", "CtrlSFCwordPath", "CtrlSFVwordPath", "CtrlSFToggle", "CtrlSFOpen" } },
  { "dyng/ctrlsf.vim", event = "VeryLazy" },
  --{ "euclio/vim-markdown-composer", build = "cargo build --release", cmd = "ComposerStart", ft = "markdown" },
  {
    "fatih/vim-go",
    ft = "go",
    build = function()
      --require("nvim-treesitter.install").iter_cmd(
      --vim.tbl_map(function(p)
      --return {
      --cmd = "go",
      --info = "Installing " .. p,
      --opts = { args = { "install", p } },
      --}
      --end, go_packages),
      --1,
      --"",
      --"Installed all Go deps"
      --)
      for _, pkg in ipairs(go_packages) do
        require("nvim-treesitter.install").iter_cmd({
          {
            cmd = "go",
            info = "Installing " .. pkg,
            opts = { args = { "install", pkg } },
          },
        }, 1, "", "Installed " .. pkg)
      end
    end,
  },
  { "theHamsta/vlime", branch = "prompt", ft = "lisp" },
  "hotwatermorning/auto-git-diff",
  "idanarye/vim-merginal",
  { "janko/vim-test", ft = { "rust", "python" } },
  --{ "ionide/Ionide-vim", build = "make fsautocomplete", ft = "fsharp" },
  --{"fsprojects/fsharp-language-server", build = "npm install && dotnet build -c Release"},
  { "junegunn/fzf", build = ":call fzf#install()" },
  { "junegunn/fzf.vim", cmd = { "Blines", "Buffers", "GFiles", "GF", "Files", "Rg", "Helptags", "History" } },
  { "junegunn/gv.vim", cmd = "GV" },
  "justinmk/vim-gtfo",
  "kassio/neoterm",
  { "mbbill/undotree", cmd = { "UndotreeToggle" } },
  { "meain/vim-package-info", build = "npm install" },
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup {}
    end,
  },
  "moll/vim-bbye",
  { "jpalardy/vim-slime", enabled = false },
  "rhysd/git-messenger.vim",
  "scrooloose/nerdcommenter",
  "skywind3000/vim-preview",
  {
    "folke/todo-comments.nvim",
    enabled = false,
    config = function()
      require("todo-comments").setup {}
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        "vim",
        "html",
        "markdown",
        "tex",
        css = { rgb_fn = true, css = true, css_fn = true },
        scss = { rgb_fn = true, css = true, css_fn = true },
        "sass",
      }
    end,
    ft = {
      "vim",
      "html",
      "markdown",
      "tex",
      "css",
      "sass",
      "scss",
    },
    lazy = true,
  },
  { "terryma/vim-multiple-cursors", keys = { "<c-n>", "<a-n>" } },
  { "kana/vim-textobj-user", event = "VeryLazy" },
  { "theHamsta/vim-template", dependencies = "kana/vim-textobj-user", enabled = vim.fn.has "win32" ~= 1 },
  { "theHamsta/vim-textobj-entire", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "theHamsta/vim-rebase-mode", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "Julian/vim-textobj-variable-segment", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  { "tpope/vim-sexp-mappings-for-regular-people", ft = lisp_filetypes },
  { "guns/vim-sexp", ft = lisp_filetypes },
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  { "tpope/vim-unimpaired", enabled = false },

  "wellle/targets.vim",
  { "whiteinge/diffconflicts", cmd = "DiffConflicts" },
  "TravonteD/luajob",

  -- Color schemes
  { "rakr/vim-one", lazy = true },

  { "olimorris/onedarkpro.nvim", lazy = true },
  {
    "rose-pine/neovim",
    config = function()
      vim.cmd "colorscheme rose-pine"
    end,
    lazy = true,
  },
  { "JoosepAlviste/palenightfall.nvim", lazy = true },
  { "projekt0n/github-nvim-theme", lazy = true },
  { "Pocco81/Catppuccino.nvim", lazy = true },
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd [[colorscheme tokyonight-storm]]
    end,
  },
  { "bluz71/vim-nightfly-guicolors", lazy = true },
  { "bluz71/vim-moonfly-colors", lazy = true },
  { "chriskempson/base16-vim", lazy = true },
  { "doums/darcula", lazy = true },
  { "strange/vim-lore", lazy = true },
  { "pineapplegiant/spaceduck", lazy = true },
  { "ghifarit53/daycula-vim", lazy = true },
  { "aonemd/kuroi.vim", lazy = true },
  { "srcery-colors/srcery-vim", lazy = true },
  {
    "novakne/kosmikoa.nvim",
    config = function()
      require("kosmikoa").setup()
    end,
    lazy = true,
  },
  --{
  --"sourcegraph/sg.nvim",
  --build = "cargo build --workspace",
  --event = "BufReadPre sg://*",
  --dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  --enabled = vim.fn.has "win32" ~= 1,
  --lazy = true,
  --},
  --use {
  --"luukvbaal/statuscol.nvim",
  --config = function()
  ----require("statuscol").setup()
  ----vim.o.statuscolumn = "%@v:lua.ScFa@%C%T%@v:lua.ScLa@%s%T@v:lua.ScNa@%=%{v:lua.ScLn()}%T"
  --end,
  --}
}
