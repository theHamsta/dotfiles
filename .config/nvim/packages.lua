-- packages.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.  vim.cmd [[packadd packer.nvim]]
local packer = require "packer"
local use = packer.use
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

return packer.startup(function()
  use { "wbthomason/packer.nvim", opt = true }
  --use {
  --"folke/noice.nvim",
  --requires = {
  ---- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --"MunifTanjim/nui.nvim",
  ---- OPTIONAL:
  ----   `nvim-notify` is only needed, if you want to use the notification view.
  ----   If not available, we use `mini` as the fallback
  --"rcarriga/nvim-notify",
  --},
  --config = function()
  --require("noice").setup {
  --lsp = {
  ---- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --override = {
  --["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --["vim.lsp.util.stylize_markdown"] = true,
  --["cmp.entry.get_documentation"] = true,
  --},
  --},
  ---- you can enable a preset for easier configuration
  --presets = {
  --bottom_search = true, -- use a classic bottom cmdline for search
  --command_palette = true, -- position the cmdline and popupmenu together
  --long_message_to_split = true, -- long messages will be sent to a split
  --inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --lsp_doc_border = false, -- add a border to hover docs and signature help
  --},
  --}
  --end,
  --}
  use {
    "RaafatTurki/hex.nvim",
    config = function()
      require("hex").setup()
    end,
  }
  use "krady21/compiler-explorer.nvim"
  use {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup()
    end,
  }
  use { "folke/neodev.nvim" }
  use {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  }
  use {
    "phaazon/mind.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("mind").setup {}
    end,
  }
  use {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup {
        open_fold_hl_timeout = 100,
        provider_selector = function(_bufnr, _filetype, _buftype)
          return { "treesitter", "indent" }
        end,
      }
    end,
  }
  use {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup()
    end,
  }
  use {
    "simrat39/inlay-hints.nvim",
    config = function()
      require("inlay-hints").setup {
        renderer = "inlay-hints/render/eol",
        only_current_line = false,
        eol = {
          right_align = false,
        },
      }
    end,
  }
  --use { "famiu/nvim-reload", opt = true }
  --use { "theHamsta/nvim-semantic-tokens", opt = false }
  use "rafamadriz/friendly-snippets"
  if vim.fn.has "win32" ~= 1 then
    use {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config { virtual_lines = false, virtual_text = true }
      end,
    }
  end
  use {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  }
  use {
    "mrbjarksen/neo-tree-diagnostics.nvim",
    --requires = "nvim-neo-tree/neo-tree.nvim",
    --module = "neo-tree.sources.diagnostics", -- if wanting to lazyload
  }
  use {
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
    opt = true,
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
    opt = true,
  }

  use { "github/copilot.vim", opt = true }
  --use {
  --"nvim-treesitter/nvim-treesitter-context",
  --config = function()
  --require("treesitter-context").setup {
  --enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
  --max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  --trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  --patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
  ---- For all filetypes
  ---- Note that setting an entry here replaces all other patterns for this entry.
  ---- By setting the 'default' entry below, you can control which nodes you want to
  ---- appear in the context window.
  --default = {
  --"class",
  --"function",
  --"method",
  ---- 'for', -- These won't appear in the context
  ---- 'while',
  ---- 'if',
  ---- 'switch',
  ---- 'case',
  --},
  ---- Example for a specific filetype.
  ---- If a pattern is missing, *open a PR* so everyone can benefit.
  ----   rust = {
  ----       'impl_item',
  ----   },
  --},
  --exact_patterns = {
  ---- Example for a specific filetype with Lua patterns
  ---- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
  ---- exactly match "impl_item" only)
  ---- rust = true,
  --},

  ---- ( ! ) The options below are exposed but shouldn't require your attention,
  ----     you can safely ignore them.

  --zindex = 20, -- The Z-index of the context window
  --mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
  --}
  --end,
  --}
  use {
    "emmanueltouzery/agitator.nvim",
    config = function()
      vim.cmd [[
nnoremap <silent> <leader>gt  :lua require'agitator'.open_file_git_branch()<cr>
    ]]
    end,
  }

  use { "kyazdani42/nvim-web-devicons" }
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
  }
  use {
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
      vim.cmd [[au BufEnter,BufWritePost * lua require('lint').try_lint()]]
    end,
  }
  use {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
  }
  use { "mattboehm/vim-unstack", cmd = "UnstackFromText" }
  --use {
  --"numToStr/Comment.nvim",
  --config = function()
  --require("Comment").setup()
  --end,
  --}
  use {
    "leoluz/nvim-dap-go",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("dap-go").setup {}
    end,
    --opt = true,
  }
  use {
    "ggandor/lightspeed.nvim",
    config = function()
      require("lightspeed").setup {
        --jump_to_first_match = true,
        exit_after_idle_msecs = { labeled = 1500, unlabeled = 1000 },
        match_only_the_start_of_same_char_seqs = true,
        limit_ft_matches = 4,
        --x_mode_prefix_key = "<c-x>",
        substitute_chars = { ["\r"] = "¬" },
        instant_repeat_fwd_key = nil,
        instant_repeat_bwd_key = nil,
        -- If no values are given, these will be set at runtime,
        -- based on `jump_to_first_match`.
        labels = nil,
        cycle_group_fwd_key = nil,
        cycle_group_bwd_key = nil,
      }
    end,
  }
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
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
  }
  use { "ray-x/lsp_signature.nvim" }
  use {
    "L3MON4D3/LuaSnip",
    run = vim.fn.has "win32" ~= 1 and "make install_jsregexp" or nil,
    config = function()
      require "theHamsta_luasnips"

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
    requires = {},
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      --"quangnguyen30192/cmp-nvim-ultisnips",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-emoji",
      --"rcarriga/cmp-dap",
      "kdheepak/cmp-latex-symbols",
    },
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
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          --{ name = "ultisnips" }, -- For ultisnips users.
          { name = "emoji", insert = true },
          { name = "latex_symbols" },
          { name = "crates" },
          --{ name = "neorg" },
          --{ name = "dap" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  }
  use {
    "doxnit/cmp-luasnip-choice",
    config = function()
      require("cmp_luasnip_choice").setup {
        auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
      }
    end,
  }
  use {
    "p00f/clangd_extensions.nvim",
  }
  use { "earthly/earthly.vim", filetype = "earthly" }
  use {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
      --vim.cmd[[nnoremap <leader>nd :DiffviewOpen<cr>]]
    end,
  }
  use {
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
  }
  if vim.fn.has "win32" ~= 1 then
    use {
      "https://gitlab.com/yorickpeterse/nvim-pqf",
      config = function()
        require("pqf").setup {}
      end,
    }
  end
  use { "jceb/emmet.snippets" }
  use { "theHamsta/vim-snippets" }
  --use {
  --"rmagatti/goto-preview",
  --config = function()
  --require("goto-preview").setup {}
  --end,
  --}
  use {
    "beauwilliams/focus.nvim",
    opt = true,
    config = function()
      require("focus").setup()
    end,
  }
  use {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    config = function()
      require("symbols-outline").setup {}
    end,
  }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  }
  use { "nanotee/zoxide.vim", cmd = { "Z", "Zi" } }
  --use {
  --"vhyrro/neorg",
  --config = function()
  --require("neorg").setup {
  ---- Tell Neorg what modules to load
  --load = {
  --["core.defaults"] = {}, -- Load all the default modules
  --["core.keybinds"] = { -- Configure core.keybinds
  --config = {
  --default_keybinds = true, -- Generate the default keybinds
  --neorg_leader = "<Leader>o", -- This is the default if unspecified
  --},
  --},
  --["core.norg.concealer"] = {}, -- Allows for use of icons
  --["core.norg.dirman"] = { -- Manage your directories with Neorg
  --config = {
  --workspaces = {
  --my_workspace = "~/projects/norg",
  --},
  --},
  --},
  --["core.gtd.base"] = {
  --config = {
  --workspace = "my_workspace",
  --},
  --},
  --["core.gtd.queries"] = {},
  --["core.gtd.ui"] = {},
  --["core.queries.native"] = {},
  --["core.norg.completion"] = {
  --config = {
  --engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
  --},
  --},
  --},
  --}
  --end,
  --}
  use "nvim-lua/popup.nvim"
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  }
  use { "mcchrish/nnn.vim", cmd = { "NnnPicker" } }
  --use "jceb/emmet.snippets"
  use {
    "folke/lsp-trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("trouble").setup {}
    end,
    cmd = { "Trouble" },
  }
  --use { "kdav5758/TrueZen.nvim", opt = true }
  use { "windwp/nvim-ts-autotag", opt = true }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end,
    opt = false,
  }
  use { "mfussenegger/nvim-treehopper", opt = false }
  --use {
  --"nvim-telescope/telescope-project.nvim",
  --config = function()
  --require "telescope".load_extension("project")
  --vim.api.nvim_set_keymap(
  --"n",
  --"<c-q>",
  --":lua require'telescope'.extensions.project.project{}<CR>",
  --{noremap = true, silent = true}
  --)
  --end,
  --requires = "nvim-telescope/telescope.nvim"
  --}
  use { "dstein64/nvim-scrollview", opt = true }
  --use { "Mofiqul/vim-code-dark", opt = true }
  use { "TimUntersberger/neogit", cmd = { "Neogit" } }
  use {
    "simrat39/rust-tools.nvim",
    --filetype = "rust",
    config = function()
      local ih = require "inlay-hints"

      require("rust-tools").setup {
        tools = {
          on_initialized = function()
            ih.set_all()
          end,
          inlay_hints = {
            auto = false,
          },
        },
        server = {
          on_attach = function(c, b)
            ih.on_attach(c, b)
          end,
        },
      }
    end,
  }
  use { "pwntester/octo.nvim", opt = true }
  use {
    "glepnir/indent-guides.nvim",
    config = function()
      require("indent_guides").setup {}
    end,
    opt = true,
  }
  use { "jiangmiao/auto-pairs", opt = true }
  use {
    "nvim-lua/lsp-status.nvim",
    config = function()
      local lsp_status = require "lsp-status"
      lsp_status.register_progress()
    end,
    opt = true,
  }
  use { "theHamsta/nvim-treesitter-commonlisp" }
  --use { "glepnir/zephyr-nvim", opt = true }
  use { "tpope/vim-endwise", ft = "lua", opt = true }
  use { "ojroques/nvim-lspfuzzy", opt = true }
  use {
    "ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  }
  use {
    "steelsojka/pears.nvim",
    opt = true,
    config = function()
      local pears = require "pears"
      local utils = require "pears.utils"

      local function has_trailing_whitespaces(bufnr)
        local _, after = utils.get_surrounding_chars(bufnr, nil, 1)

        return (not after or after == "" or string.match(after, "%s") or string.match(after, "[)%]}]"))
      end
      local function check_quotes(bufnr)
        local before, after = utils.get_surrounding_chars(bufnr, nil, 1)

        return (not after or after == "" or string.match(after, "%s") or string.match(after, "[)%]}]"))
          and not (before and before:match "%w")
      end

      pears.setup(function(c)
        --c.on_enter(function(pears_handle)
        --if vim.fn.pumvisible() == 1 then
        ----if vim.fn.pumvisible() ==1 and vim.fn.complete_info().selected ~= -1 then
        ----return vim.fn["compe#confirm"]("<CR>")
        --return
        --else
        --pears_handle()
        --end
        --end)
        c.preset "tag_matching"
        c.preset "html"
        --c.pair(
        --"then",
        --{
        --close = "end",
        --filetypes = {"lua"}
        --}
        --)
        c.pair("(", {
          close = ")",
          should_expand = has_trailing_whitespaces,
        })
        c.pair("{", {
          close = "}",
          should_expand = has_trailing_whitespaces,
        })
        c.pair("$", {
          close = "$",
          should_expand = has_trailing_whitespaces,
          filetypes = { "latex" },
        })
        c.pair("[", {
          close = "]",
          should_expand = has_trailing_whitespaces,
        })
        c.pair('"', {
          close = '"',
          should_expand = check_quotes,
        })
        c.pair("'", {
          close = "'",
          should_expand = check_quotes,
        })
        c.pair("[", {
          close = "]",
          should_expand = has_trailing_whitespaces,
        })
      end)
    end,
  }

  --use {
  --"gabrielpoca/replacer.nvim",
  --config = function()
  --vim.api.nvim_set_keymap("n", "<Leader>hh", ':lua require("replacer").run()<cr>', {silent = true})
  --end
  --}
  --use { "onsails/lspkind-nvim" }
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

  use "mfussenegger/nvim-dap-python"
  use {
    "kosayoda/nvim-lightbulb",
    config = function()
      --vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    end,
    opt = true,
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
  use { "danilo-augusto/vim-afterglow", opt = true }
  use "ocaml/vim-ocaml"
  use { "kevinhwang91/nvim-hlslens", opt = true }
  use {
    "norcalli/snippets.nvim",
    config = function()
      vim.cmd [[inoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>]]
    end,
  }
  --use "ghifarit53/tokyonight-vim"
  --use "akinsho/nvim-toggleterm.lua"
  --use "chrisbra/unicode.vim"
  use "tpope/vim-speeddating"
  use "nvim-telescope/telescope-symbols.nvim"
  use {
    "rcarriga/nvim-dap-ui",
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
  }
  --use {
  --"nvim-telescope/telescope-frecency.nvim",
  --config = function()
  --require("telescope").load_extension "frecency"
  --end,
  --}
  --use "nvim-telescope/telescope.nvim"
  use "chuling/vim-equinusocio-material"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  --setheHamsta/nvim-treesitter-commonlisp
  --use "theHamsta/nvim-treesitter-pairs"
  use "nvim-treesitter/nvim-treesitter-refactor"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function() end,
  }
  use "nvim-treesitter/playground"
  --use "nvim-treesitter/nvim-tree-docs"
  use { "ziglang/zig.vim", ft = "zig", opt = false }
  --use {
  --"mfussenegger/nvim-jdtls",
  --opt = false,
  --config = function()
  --vim.cmd [[au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}, settings = {java = { import = { gradle = { wrapper = { checksums = { { sha256 = "803c75f3307787290478a5ccfa9054c5c0c7b4250c1b96ceb77ad41fbe919e4e", allowed = true } } } } } }}, init_options = { bundles = { vim.fn.glob("/home/stephan/projects/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar") } }, on_attach= function(client, bufnr) require('jdtls').setup_dap() end})]]
  --end,
  --}
  --use "mattn/emmet-vim"
  use "rhysd/conflict-marker.vim"
  use { "mfussenegger/nvim-dap" }
  use {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup {
        --only_first_definition = true,
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
      }
    end,
  }
  use "theHamsta/crazy-node-movement"
  --use "dm1try/git_fastfix"
  use "rafcamlet/nvim-luapad"
  use { "jsit/toast.vim", opt = true }
  --use {
  --"theHamsta/nvim_rocks",
  --run = "pip3 install --r hererocks && hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua"
  --}
  use "tjdevries/luvjob.nvim"
  --use "svermeulen/nvim-moonmaker"
  use "kbenzie/vim-spirv"

  --use {"theHamsta/nvim-tree.lua", branch = "exa"}

  use {
    "nvim-telescope/telescope-dap.nvim",
    requires = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension "dap"
    end,
  }
  use {
    "nvim-telescope/telescope-fzy-native.nvim",
    requires = "nvim-telescope/telescope.nvim",
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
  }
  --use {"Olical/conjure", opt = true}
  --use "Olical/nvim-local-fennel"
  --use "bakpakin/fennel.vim"
  --use "Olical/aniseed"
  --use "szymonmaszke/vimpyter"
  use "camspiers/animate.vim"
  use "neovim/nvim-lspconfig"
  use { "preservim/tagbar", cmd = { "TagbarToggle", "TagbarOpenAutoClose" } }
  use { "voldikss/vim-floaterm", cmd = "FloatermToggle" }
  use { "kkoomen/vim-doge", opt = true }
  use "AndrewRadev/switch.vim"
  --use "JuliaEditorSupport/julia-vim"
  use "Julian/vim-textobj-variable-segment"
  --use { "SirVer/ultisnips", opt = false, run = ":UpdateRemotePlugins" }
  use "Valloric/ListToggle"
  --use "airblade/vim-gitgutter"
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    opt = false,
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
  }
  use {
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        enabled = true,
      }
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    --cmd = { "Neogen" }
  }

  use "airblade/vim-rooter"
  --use "bronson/vim-visual-star-search"
  use { "dbeniamine/cheat.sh-vim", cmd = { "Cheat" } }
  use "dyng/ctrlsf.vim"
  --use { "euclio/vim-markdown-composer", run = "cargo build --release", cmd = "ComposerStart", ft = "markdown" }
  use {
    "fatih/vim-go",
    ft = "go",
    run = table.concat(
      vim.tbl_map(function(p)
        return "go instal -u " .. p .. "@latest"
      end, go_packages),
      " && "
    ),
  }
  use { "theHamsta/vlime", branch = "prompt", rtp = "vim/", ft = "lisp" }
  use "hotwatermorning/auto-git-diff"
  use "idanarye/vim-merginal"

  --use { "ivalkeen/nerdtree-execute", cmd = { "NERDTreeToggle", "NERDTreeFind" } }
  --use { "Xuyuanp/nerdtree-git-plugin", cmd = { "NERDTreeToggle", "NERDTreeFind" } }
  --use { "preservim/nerdtree" }
  ----use {"preservim/nerdtree", cmd = {"NERDTreeToggle", "NERDTreeFind"}}
  --use { "tiagofumo/vim-nerdtree-syntax-highlight", cmd = { "NERDTreeToggle", "NERDTreeFind" } }
  use { "janko/vim-test", ft = { "rust", "python" } }
  --use { "ionide/Ionide-vim", run = "make fsautocomplete", ft = "fsharp" }
  --use {"fsprojects/fsharp-language-server", run = "npm install && dotnet build -c Release"}
  --use { 'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile', ft = 'fsharp'}
  --use {
  --"autozimu/LanguageClient-neovim",
  --branch = "next",
  --run = "bash install.sh",
  --ft = "fsharp",
  --}
  --use {
  --"nvim-orgmode/orgmode",
  --ft = "org",
  --config = function()
  --require("orgmode").setup_ts_grammar()
  --require("orgmode").setup {
  --org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
  --org_default_notes_file = "~/Dropbox/org/refile.org",
  --}
  --end,
  --}
  use { "junegunn/fzf", run = ":call fzf#install()" }
  use "junegunn/fzf.vim"
  use "junegunn/gv.vim"
  use "justinmk/vim-gtfo"
  --use "junegunn/goyo.vim"
  --use "junegunn/limelight.vim"
  use "kassio/neoterm"
  --use { "lervag/vimtex", opt = true }
  --use "machakann/vim-swap"
  --use "p00f/nvim-ts-rainbow"
  use { "mbbill/undotree", cmd = { "UndotreeToggle" } }
  use { "meain/vim-package-info", run = "npm install" }
  use { "IndianBoy42/hop.nvim" }
  --use { "ms-jpq/coq_nvim"}
  --use { "mhinz/vim-startify", opt = true }
  --use {
  --"goolord/alpha-nvim",
  --requires = { "kyazdani42/nvim-web-devicons" },
  --opt = false,
  --config = function()
  --require("alpha").setup(require("alpha.themes.startify").opts)
  --end,
  --}
  use "moll/vim-bbye"
  use { "jpalardy/vim-slime", opt = true }
  use "rhysd/git-messenger.vim"
  --use { "rust-lang/rust.vim", ft = { "rust", "toml" } }
  use "scrooloose/nerdcommenter"
  use "skywind3000/vim-preview"
  use {
    "folke/todo-comments.nvim",
    opt = true,
    config = function()
      require("todo-comments").setup {}
    end,
  }

  use {
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
    opt = false,
  }
  use "terryma/vim-multiple-cursors"
  use "kana/vim-textobj-user"
  --use "theHamsta/vim-snippets"
  use "theHamsta/vim-template"
  use "theHamsta/vim-textobj-entire"
  use "theHamsta/vim-rebase-mode"
  use "tpope/vim-eunuch"
  use "tpope/vim-fugitive"
  use "tpope/vim-repeat"
  use { "tpope/vim-sexp-mappings-for-regular-people", ft = lisp_filetypes }
  use { "guns/vim-sexp", ft = lisp_filetypes }
  use "tpope/vim-sleuth"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"

  use "wellle/targets.vim"
  use "whiteinge/diffconflicts"
  use "TravonteD/luajob"

  -- Color schemes
  use { "rakr/vim-one", opt = true }

  use { "olimorris/onedarkpro.nvim", opt = true }
  use {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      vim.cmd "colorscheme rose-pine"
    end,
    opt = true,
  }
  use { "JoosepAlviste/palenightfall.nvim", opt = true }
  use { "projekt0n/github-nvim-theme", opt = true }
  use { "Pocco81/Catppuccino.nvim", opt = true }
  --use {"tiagovla/tokyodark.nvim", opt = true}
  use { "folke/tokyonight.nvim", opt = true }
  use { "bluz71/vim-nightfly-guicolors", opt = true }
  use { "bluz71/vim-moonfly-colors", opt = true }
  use { "chriskempson/base16-vim", opt = true }
  use { "doums/darcula", opt = true }
  use { "strange/vim-lore", opt = true }
  use { "pineapplegiant/spaceduck", opt = true }
  use { "ghifarit53/daycula-vim", opt = true }
  use { "aonemd/kuroi.vim", opt = true }
  use { "srcery-colors/srcery-vim", opt = true }
  use {
    "novakne/kosmikoa.nvim",
    config = function()
      require("kosmikoa").setup()
    end,
    opt = true,
  }
  --use {
  --"luukvbaal/statuscol.nvim",
  --config = function()
  ----require("statuscol").setup()
  ----vim.o.statuscolumn = "%@v:lua.ScFa@%C%T%@v:lua.ScLa@%s%T@v:lua.ScNa@%=%{v:lua.ScLn()}%T"
  --end,
  --}
end)
