-- packages.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.  vim.cmd [[packadd packer.nvim]]
if not vim.uv then
    vim.uv = vim.loop
end
--
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

--local analyzers = {}
--local SONARDIR = "/home/stephan/Downloads/sonar"
--local SONARLS_JAR = "sonarlint-ls.jar"
--local SONARLS_JAR_PATH = vim.fs.joinpath(SONARDIR, SONARLS_JAR)
--for file, type in vim.fs.dir(SONARDIR) do
--if type == "file" and vim.endswith(file, ".jar") and file ~= SONARLS_JAR then
--table.insert(analyzers, vim.fs.joinpath(SONARDIR, file))
--end
--end
pcall(vim.cmd.packadd,"nvim.undotree")
--vim.o.fillchars = 'eob: ,fold: ,foldopen:v,foldsep: ,foldinner: ,foldclose:'

require("lazy").setup {
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "zathura"
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require("ufo").setup {
                provider_selector = function(bufnr, filetype, buftype)
                    return { "treesitter", "indent" }
                end,
            }
        end,
    },
    "TravonteD/luajob",
    { "kana/vim-textobj-user",               event = "VeryLazy" },
    { "theHamsta/vim-template",              dependencies = "kana/vim-textobj-user", enabled = vim.fn.has "win32" ~= 1 },
    { "theHamsta/vim-textobj-entire",        dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
    { "theHamsta/vim-rebase-mode",           dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
    { "Julian/vim-textobj-variable-segment", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
    { "ray-x/lsp_signature.nvim" },
    "tpope/vim-eunuch",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    { "junegunn/fzf",     build = ":call fzf#install()" },
    { "junegunn/fzf.vim", cmd = { "Blines", "Buffers", "GFiles", "GF", "Files", "Rg", "Helptags", "History" } },
    { "junegunn/gv.vim",  cmd = "GV" },
    "justinmk/vim-gtfo",
    "kassio/neoterm",
    "scrooloose/nerdcommenter",
    { "mbbill/undotree",             cmd = { "UndotreeToggle" } },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                    ---- Conform will run multiple formatters sequentially
                    --python = { "isort", "black" },
                    ---- Use a sub-list to run only the first available formatter
                    javascript = { { "prettierd", "prettier" } },
                    ["_"] = { "trim_whitespace" },
                },
                --format_on_save = {
                ---- I recommend these options. See :help conform.format for details.
                --lsp_fallback = true,
                --timeout_ms = 500,
                --},
            }
        end,
        event = "VeryLazy",
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
                --end, vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }),
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
                                end, vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }),
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
                yaml = select_executables { "actionlint" },
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
        lazy = false,
        branch = "legacy",
    },
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
    --{ "ray-x/lsp_signature.nvim" },
    {
        "L3MON4D3/LuaSnip",
        build = vim.fn.has "win32" ~= 1 and "make install_jsregexp" or nil,
        config = function()
            vim.cmd [[
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
    ]]
        end,
        keys = "<tab>",
        --dependencies = {},
    },
    {
        "saghen/blink.cmp",
        build = "cargo build --release",
        dependencies = "rafamadriz/friendly-snippets",
        --build = function()
        --vim.notify("Building blink.cmp", vim.log.levels.INFO)
        --local obj = vim
        --.system({ "cargo", "build", "--release" }, { [>cwd = params.path<]
        --})
        --:wait()
        --if obj.code == 0 then
        --vim.notify("Building blink.cmp done", vim.log.levels.INFO)
        --else
        --vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
        --end
        --end,
        --version = "*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            signature = { enabled = false },
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = {
                preset = "default",
            },
            cmdline = {
                keymap = {
                    preset = "default",

                    ["<tab>"] = { "show", "select_and_accept" },
                },
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "cmdline" },
            },
            snippets = { preset = "luasnip" },
            completion = {
                -- 'prefix' will fuzzy match on the text before the cursor
                -- 'full' will fuzzy match on the text before *and* after the cursor
                -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
                keyword = { range = "prefix" },

                -- Disable auto brackets
                -- NOTE: some LSPs may add auto brackets themselves anyway
                accept = { auto_brackets = { enabled = true } },

                ---- Don't select by default, auto insert on selection
                --list = { selection = { preselect = false, auto_insert = true } },
                ---- or set either per mode via a function
                --list = { selection = {
                --preselect = function(ctx)
                --return ctx.mode ~= "cmdline"
                --end,
                --} },

                menu = {
                    -- Don't automatically show the completion menu
                    auto_show = true,

                    -- nvim-cmp style menu
                    draw = {
                        columns = {
                            { "label",     "label_description", gap = 1 },
                            { "kind_icon", "kind" },
                        },
                    },
                },

                -- Show documentation when selecting a completion item
                documentation = { auto_show = true, auto_show_delay_ms = 500 },

                -- Display a preview of the selected item on the current line
                ghost_text = { enabled = false },
            },
        },
        opts_extend = { "sources.default" },
    },
    {
        "https://gitlab.com/yorickpeterse/nvim-pqf",
        config = function()
            require("pqf").setup {}
        end,
        enabled = vim.fn.has "win32" ~= 1,
    },
    --{ "jceb/emmet.snippets" },
    { "theHamsta/nvim-dap-commands", opts = {} },
    { "theHamsta/vim-snippets" },
    {
        "simrat39/symbols-outline.nvim",
        cmd = { "SymbolsOutline" },
        config = function()
            require("symbols-outline").setup {}
        end,
    },
    { "nanotee/zoxide.vim",     cmd = { "Z", "Zi" } },
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
    --{ "mcchrish/nnn.vim", cmd = { "NnnPicker" } },
    --"jceb/emmet.snippets",
    --{
    --"folke/lsp-trouble.nvim",
    --dependencies = { "nvim-tree/nvim-web-devicons" },
    --config = function()
    --require("trouble").setup {}
    --end,
    --cmd = { "Trouble" },
    --},
    -- { "windwp/nvim-ts-autotag", enabled = false },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end,
    },
    --{
    --"mfussenegger/nvim-treehopper",
    --keys = "<space><space>",
    --config = function(...)
    --vim.cmd [[
    --omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
    --xnoremap <silent> m :lua require('tsht').nodes()<CR>
    --]]
    --end,
    --},
    --{ "dstein64/nvim-scrollview", enabled = false },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",   -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",  -- optional
            --"ibhagwan/fzf-lua", -- optional
        },
        config = true,
        cmd = { "Neogit" },
    },
    --{
    --"simrat39/rust-tools.nvim",
    --ft = "rust",
    --config = function()
    ----local ih = require "inlay-hints"

    --require("rust-tools").setup {
    --tools = {
    --on_initialized = function()
    ----ih.set_all()
    --end,
    --inlay_hints = {
    --auto = true,
    --},
    --},
    --server = {
    --on_attach = function(client, buffer)
    --require("lsp-inlayhints").on_attach(client, buffer)
    ----ih.on_attach(c, b)
    --end,
    --},
    --}
    --end,
    --enable = true,
    --},
    --{ "pwntester/octo.nvim", enabled = false },
    {
        "glepnir/indent-guides.nvim",
        config = function()
            require("indent_guides").setup {}
        end,
        enabled = false,
    },
    { "jiangmiao/auto-pairs",   enabled = false },
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
        event = "VeryLazy",
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        branch = "main",
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = {
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    include_surrounding_whitespace = false,
                },
            }
            vim.keymap.set({ "x", "o" }, "af", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "if", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ac", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ic", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "<PageUp>", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "<PageDown>", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
            end)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        branch = "main",
    },
    "mfussenegger/nvim-dap",
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup {
                --only_first_definition = true,
                all_references = false,                                    -- show virtual text on all all references of the variable (not only definitions)
                virt_text_pos = vim.fn.has "nvim-0.10" == 1 and "inline" or "eol", -- use `vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol'` for inlined text if supported
            }
        end,
        branch = "master",
    },
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
    --{ "voldikss/vim-floaterm", cmd = "FloatermToggle" },
    --"JuliaEditorSupport/julia-vim",
    --{ "SirVer/ultisnips", opt = false, build = ":UpdateRemotePlugins" },
    --"airblade/vim-gitgutter",
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "BufReadPre",
        enabled = true,
        config = function()
            require("gitsigns").setup {
                signs = {
                    add = { text = "▋" },
                    change = { text = "▐" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "▐_" },
                },
                numhl = false,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    map("n", "<c-a-k>", gs.prev_hunk)
                    map("n", "<c-a-j>", gs.next_hunk)
                    map("n", "<leader>hu", gs.reset_hunk)
                    map("n", "<leader>hs", gs.stage_hunk)
                    map("v", "<leader>hs", function()
                        gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                    end)
                    map("v", "<leader>hr", function()
                        gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                    end)
                    map("n", "<leader>hS", gs.stage_buffer)
                    map("n", "<leader>hU", gs.undo_stage_hunk)
                    map("n", "<leader>hR", gs.reset_buffer)
                    map("n", "<leader>hp", gs.preview_hunk)
                    map("n", "<leader>hb", function()
                        gs.blame_line { full = true }
                    end)
                    map("n", "<leader>tb", gs.toggle_current_line_blame)
                    map("n", "<leader>hd", gs.diffthis)
                    map("n", "<leader>hD", function()
                        gs.diffthis "~"
                    end)
                    map("n", "<leader>td", gs.toggle_deleted)

                    -- Text object
                    map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>")
                end,
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
    --{ "dbeniamine/cheat.sh-vim", cmd = { "Cheat" } },
    --{ "dyng/ctrlsf.vim", cmd = { "CtrlSFPrompt", "CtrlSFCwordPath", "CtrlSFVwordPath", "CtrlSFToggle", "CtrlSFOpen" } },
    { "dyng/ctrlsf.vim",  event = "VeryLazy" },
    "idanarye/vim-merginal",
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
    { "guns/vim-sexp",        ft = lisp_filetypes },
    "tpope/vim-sleuth",
    "tpope/vim-surround",
    { "tpope/vim-unimpaired", enabled = false },
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd [[
  set background=dark
  colorscheme tokyonight-night
  ]]
        end,
        enable = false,
        --lazy = true,
    },
}
