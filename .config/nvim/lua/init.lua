--local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
--if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
--vim.cmd [[packadd packer.nvim]]
--end

--vim.loader.enable()

vim.api.nvim_command [[
function! DeleteTrailingWS()
exe 'normal mz'
%s/\s\+$//ge
exe 'normal `z'
endfunction
]]

local function select_executable(executables)
    return vim.tbl_filter(function(c) ---@param c string
        return c ~= vim.NIL and vim.fn.executable(c) == 1
    end, executables)[1]
end

vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

local lsp_status = vim.F.npcall(require, "lsp-status")
local blink, ok = pcall(require, "blink.cmp")
local capabilities = {}
if ok and lsp_status then
    capabilities = blink.get_lsp_capabilities()
    capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }
    vim.tbl_extend("keep", capabilities, {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
                relative_pattern_support = true,
            },
        },
    })
end

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method "textDocument/documentColor" then
            vim.lsp.document_color.enable(true, args.buf)
        end
    end,
})

local line_numbers = false
local function toggle_line_numbers()
    line_numbers = not line_numbers
    for _, win in pairs(vim.api.nvim_list_wins()) do
        vim.wo[win].number = line_numbers
        vim.wo[win].relativenumber = line_numbers
    end
end

vim.api.nvim_create_user_command("ToggleLineNumbers", toggle_line_numbers, {})

if vim.g.neovide then
    local fullscreen = false
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_title_background_color = "1a1b26"
    vim.g.neovide_floating_z_height = 5
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 1
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_floating_corner_radius = 10.0
    vim.keymap.set({ "i", "n" }, "<F11>", function()
        fullscreen = not fullscreen
        vim.g.neovide_fullscreen = fullscreen
    end, { silent = true })
end

require("vim.lsp.log").set_level(vim.log.levels.OFF)

function _G.D(a)
    print(vim.inspect(a))
    return a
end

function _G.R(a)
    require("dap.repl").append(vim.inspect(a))
    return a
end

function _G.E(...)
    print(vim.inspect { ... })
    return ...
end

vim.diagnostic.config {
    virtual_text = {
        source = "if_many", -- Or "if_many"
    },
    float = {
        source = "always", -- Or "if_many"
    },
    signs = {
        "DapBreakpoint",
        { text = "🛑", texthl = "", linehl = "", numhl = "" },
        "DapStopped",
        { text = "→", texthl = "", linehl = "NvimDapStopped", numhl = "" },
        "DapBreakpointRejected",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
    },
}

--nnoremap <silent> [d <cmd>lua vim.diagnostic.goto_prev()<CR>
--nnoremap <silent> ]d <cmd>lua vim.diagnostic.goto_next()<CR>
--nnoremap <silent> äk <cmd>lua vim.diagnostic.goto_prev()<CR>
--nnoremap <silent> äj <cmd>lua vim.diagnostic.goto_next()<CR>
local virtual_lines = false
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "<leader>lD", vim.diagnostic.setqflist, { silent = true })
vim.keymap.set("n", "<leader>dz", "<cmd>Neotree diagnostics reveal bottom<cr>", { silent = true })
vim.keymap.set("n", "<leader>ll", function()
    virtual_lines = not virtual_lines
    vim.diagnostic.config { virtual_lines = virtual_lines, virtual_text = not virtual_lines }
end, { silent = true })

vim.keymap.set("n", "<leader>rr", ":grep <cword> | copen<cr>", { silent = true, buffer = false, noremap = true })
vim.keymap.set("v", "<leader>rr", "y:grep <c-r>+ | copen<cr>", { silent = true, buffer = false, noremap = true })

local function switch_source_header(bufnr)
    local util = require "lspconfig.util"
    bufnr = util.validate_bufnr(bufnr)
    local clangd_client = util.get_active_client_by_name(bufnr, "clangd")
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    if clangd_client then
        clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
            if err then
                vim.cmd [[:Telescope telescope-alternate alternate_file]]
                error(tostring(err))
            end
            if not result then
                vim.cmd [[:Telescope telescope-alternate alternate_file]]
                print "Corresponding file cannot be determined"
                return
            end
            vim.api.nvim_command("edit " .. vim.uri_to_fname(result))
        end, bufnr)
    else
        print "method textDocument/switchSourceHeader is not supported by any servers active on the current buffer"
    end
end

_G["NvimLspMaps"] = function()
    local C_FTYPES = { c = true, cpp = true, cuda = true }
    if C_FTYPES[vim.bo.filetype] then
        vim.keymap.set("n", "<a-o>", function()
            switch_source_header(0)
        end, { silent = true, buffer = true })
    end
    vim.keymap.set("n", "<c-a-o>", ":Telescope lsp_document_symbols<cr>", { silent = true, buffer = true })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
    vim.keymap.set("n", "gD", "<c-w>vgd", { silent = true, buffer = true })
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.implementation, { silent = true, buffer = true })
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { silent = true, buffer = true })
    vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, { silent = true, buffer = true })
    vim.keymap.set("n", "gk", vim.lsp.buf.declaration, { silent = true, buffer = true })
    vim.keymap.set("n", "gR", vim.lsp.buf.references, { silent = true, buffer = true })
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, { silent = true, buffer = true })
    vim.keymap.set({ "i", "n" }, "<c-g>", vim.lsp.buf.signature_help, { silent = true, buffer = true })
    vim.keymap.set("n", "<leader>lD", vim.diagnostic.setloclist, { silent = true, buffer = true })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, buffer = true })
    vim.keymap.set("n", "<leader>ic", vim.lsp.buf.incoming_calls, { silent = true, buffer = true })
    vim.keymap.set("n", "<leader>oc", vim.lsp.buf.outgoing_calls, { silent = true, buffer = true })
    vim.keymap.set("n", "<leader>ss", ":Telescope lsp_workspace_symbols<cr>", { silent = true, buffer = true })
    vim.keymap.set("n", "<c-t>", ":Telescope lsp_workspace_symbols<cr>", { silent = true, buffer = true })
    --vim.keymap.set("n", "<leader>de", require("lsp-ext").peek_definition, { silent = true, buffer = true })
    vim.keymap.set("n", "<2-LeftMouse", vim.lsp.buf.hover, { silent = true, buffer = true })
    vim.keymap.set("n", "<c-LeftMouse", vim.lsp.buf.definition, { silent = true, buffer = true })
    --vim.keymap.set("n", "üf", "<cmd>packadd lspsaga<cr><cmd>Lspsaga lsp_finder", { silent = true, buffer = true })
    --vim.keymap.set("n", "<leader>fi", function()
    --require("lspsaga.provider").lsp_finder()
    --end, { silent = true, buffer = true })
    vim.keymap.set("n", "<c-s>", function()
        require("conform").format({ lsp_fallback = true, async = true }, function()
            vim.lsp.buf.format { bufnr = 0 }
            vim.cmd "w"
        end)
    end, { silent = true, buffer = true })
    vim.cmd [[command! CodeLens autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]

    vim.cmd [[setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
    --vim.cmd [[Lazy load fidget.nvim]]
end

--vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
--vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
--vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
--vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
--vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
--vim.keymap.set("n", "<F6>", require("dap").continue, { desc = "DAP continue" })
--vim.keymap.set("n", "<F10>", require("dap").step_over, { desc = "DAP step over" })
--vim.keymap.set("n", "<F11>", require("dap").step_into, { desc = "DAP step into" })
--vim.keymap.set("n", "<PageUp>", require("dap").up, { desc = "DAP up" })
--vim.keymap.set("n", "<PageDown>", require("dap").down, { desc = "DAP down" })

local neodev = vim.F.npcall(require, "neodev")
if neodev then
    neodev.setup {
        -- add any options here, or leave empty to use the default settings
    }
end

local lsp_signature = vim.F.npcall(require, "lsp_signature")

local function on_attach(client, bufnr)
    if client:supports_method "textDocument/inlayHint" or client.name == "rust_analyzer" then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
    vim.fn.NvimLspMaps()
    if lsp_signature and vim.bo[bufnr].ft ~= "glsl" then
        lsp_signature.on_attach()
    end
    if lsp_status then
        lsp_status.on_attach(client)
    end
end

local function lsp_setup(name, config, disable)
    vim.lsp.config(name, config)
    if not disable then
        vim.lsp.enable(name)
    end
end

lsp_setup("neocmake", {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        format = {
            enable = true,
        },
        lint = {
            enable = true,
        },
    },
})
lsp_setup("slangd", {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "hlsl", "shaderslang", "glsl" },
    settings = {
        slang = {
            --predefinedMacros = {"MY_VALUE_MACRO=1"},
            --additionalSearchPaths
            inlayHints = {
                deducedTypes = true,
                parameterNames = true,
            },
        },
    },
})
lsp_setup("qmlls", {
    cmd = select_executable { "/usr/local/Qt-6.10.0/bin/qmlls", "qmlls" },
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_setup("asm_lsp", {
    on_attach = on_attach,
    capabilities = capabilities,
})
lsp_setup("eslint", {
    on_attach = on_attach,
    capabilities = capabilities,
})
lsp_setup("mesonlsp", {
    on_attach = on_attach,
    capabilities = capabilities,
})
lsp_setup("sourcekit", {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "swift" },
})
--lspconfig.helm_ls.setup {
--cmd = { "helm-ls", "serve" },
--filetypes = { "helm", "yaml" },
--on_attach = on_attach,
--capabilities = capabilities,
--}
lsp_setup("jdtls", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        -- config example: https://ptrtojoel.dev/posts/so-you-want-to-write-java-in-neovim/
        java = {
            inlayHints = {
                enabled = true,
                --parameterNames = {
                --   enabled = 'all' -- literals, all, none
                --}
            },
            import = {
                gradle = {
                    wrapper = {
                        checksums = {
                            { sha256 = "803c75f3307787290478a5ccfa9054c5c0c7b4250c1b96ceb77ad41fbe919e4e", allowed = true },
                            { sha256 = "ee3739525a995bcb5601621a6e2daec1f183bbefc375743acc235cec33547e04", allowed = true },
                        },
                    },
                },
            },
        },
    },
})
lsp_setup("taplo", { on_attach = on_attach, capabilities = capabilities })

vim.keymap.set("n", "<leader>nf", function()
    local url = vim.api.nvim_buf_get_name(0)
    if url:match "^sg:" then
        url = vim.fn.fnamemodify(url, ":h")
        if url:match "-$" then
            url = url .. "/."
        end
        vim.cmd(":e " .. url)
    else
        vim.cmd "Neotree filesystem reveal left"
    end
end, { silent = true, noremap = true, desc = "Nerdtree for local files or :e %:h" })

local sg = vim.F.npcall(require, "sg")
if sg then
    sg.setup {
        on_attach = function(...)
            on_attach(...)
        end,
    }
end

--lspconfig.obsidian_ls.setup {
--on_attach = on_attach,
--capabilities = capabilities,
--}

lsp_setup("flow", {
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_setup("glsl_analyzer", {
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable "qmlls"

lsp_setup("wgsl_analyzer", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["wgsl-analyzer"] = {
            shaderDefs = {
                "VERTEX_TANGENTS",
                "VERTEX_NORMALS",
                "VERTEX_COLORS",
                "VERTEX_UVS",
                "SKINNED",
            },
            inlayHints = {
                enabled = true,
                typeHints = true,
                parameterHints = true,
                structLayoutHints = true,
            },
            customImports = {
                ["bevy_pbr::clustered_forward"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/clustered_forward.wgsl",
                ["bevy_pbr::mesh_bindings"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_bindings.wgsl",
                ["bevy_pbr::mesh_functions"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_functions.wgsl",
                ["bevy_pbr::mesh_types"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_types.wgsl",
                ["bevy_pbr::mesh_vertex_output"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_vertex_output.wgsl",
                ["bevy_pbr::mesh_view_bindings"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_view_bindings.wgsl",
                ["bevy_pbr::mesh_view_types"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_view_types.wgsl",
                ["bevy_pbr::pbr_bindings"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/pbr_bindings.wgsl",
                ["bevy_pbr::pbr_functions"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/pbr_functions.wgsl",
                ["bevy_pbr::lighting"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/pbr_lighting.wgsl",
                ["bevy_pbr::pbr_types"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/pbr_types.wgsl",
                ["bevy_pbr::shadows"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/shadows.wgsl",
                ["bevy_pbr::skinning"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/skinning.wgsl",
                ["bevy_pbr::utils"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/utils.wgsl",
                ["bevy_sprite::mesh2d_bindings"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_bindings.wgsl",
                ["bevy_sprite::mesh2d_functions"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_functions.wgsl",
                ["bevy_sprite::mesh2d_types"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_types.wgsl",
                ["bevy_sprite::mesh2d_vertex_output"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_vertex_output.wgsl",
                ["bevy_sprite::mesh2d_view_bindings"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_view_bindings.wgsl",
                ["bevy_sprite::mesh2d_view_types"] =
                "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_view_types.wgsl",
            },
        },
    },
})

--lspconfig.marksman.setup {
--on_attach = on_attach,
--capabilities = capabilities,
--}
--lspconfig.fsautocomplete.setup {
--on_attach = on_attach,
--capabilities = capabilities,
--}
lsp_setup("csharp_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_setup("zls", {
    on_attach = on_attach,
    capabilities = capabilities,
})
lsp_setup("bashls", {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "sh", "bash", "make", "zsh" },
})

--lspconfig.tsserver.setup {
--on_attach = on_attach,
--capabilities = capabilities,
--settings = {
--javascript = {
--inlayHints = {
--includeInlayEnumMemberValueHints = true,
--includeInlayFunctionLikeReturnTypeHints = true,
--includeInlayFunctionParameterTypeHints = true,
--includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
--includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--includeInlayPropertyDeclarationTypeHints = true,
--includeInlayVariableTypeHints = true,
--},
--},
--typescript = {
--inlayHints = {
--includeInlayEnumMemberValueHints = true,
--includeInlayFunctionLikeReturnTypeHints = true,
--includeInlayFunctionParameterTypeHints = true,
--includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
--includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--includeInlayPropertyDeclarationTypeHints = true,
--includeInlayVariableTypeHints = true,
--},
--},
--},
--}

lsp_setup("svelte", {
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_setup("julials", {
    on_attach = on_attach,
    capabilities = capabilities,
})
lsp_setup("ocamllsp", {
    on_attach = function(...)
        require("virtualtypes").on_attach(...)
        on_attach()
    end,
})
lsp_setup("gopls", {
    on_attach = on_attach,
    settings = {
        initializationOptions = {
            usePlaceholders = true,
        },
        gopls = {
            semanticTokens = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
})

lsp_setup("basedpyright", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "off",
            },
        },
    },
})

--lspconfig.pylyzer.setup {
--on_attach = on_attach,
--settings = {
--python = {
--checkOnType = false,
--diagnostics = false,
--inlayHints = false,
--smartCompletion = true,
--},
--},
--capabilities = capabilities,
--}
lsp_setup("spirvls", {
    cmd = { "spirvls" },
    filetypes = { "spirv", "spvasm" },
    on_attach = on_attach,
})
vim.lsp.enable "spirvls"

lsp_setup("ruff", {
    on_attach = on_attach,
    settings = {},
    capabilities = capabilities,
})
vim.lsp.enable "ruff"
--lspconfig.ty.setup {
--on_attach = on_attach,
--settings = {},
--capabilities = capabilities,
--}
--vim.lsp.enable "ty"

--lspconfig.pylsp.setup {
--on_attach = on_attach,
--settings = {
--pyls = {
----plugins = {
----pydocstyle = {
----enabled = false,
----},
----flake8 = {
----maxLineLength = 120,
----},
----pycodestyle = {
----ignore = { "E501" },
----maxLineLength = 120,
----},
----},
--},
--},
--capabilities = capabilities,
--}
lsp_setup("jedi_language_server", {
    on_attach = on_attach,
    settings = {
        --pyls = {
        --plugins = {
        --pydocstyle = {
        --enabled = false,
        --},
        --flake8 = {
        --maxLineLength = 120,
        --},
        --pycodestyle = {
        --ignore = { "E501" },
        --maxLineLength = 120,
        --},
        --},
        --},
    },
    capabilities = capabilities,
})

--lspconfig.pylyzer.setup {
--on_attach = on_attach,
--settings = {
--python = {
--checkOnType = false,
--diagnostics = true,
--inlayHints = true,
--smartCompletion = true,
--},
--},
--}

lsp_setup("tinymist", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        exportPdf = "onType",
        outputPath = "$root/$name",
        formatterMode = "typstfmt",
    },
})
lsp_setup("ts_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
})

--lspconfig.clangd.setup {
--cmd = {
--"clangd-15",
--"--clang-tidy",
--"--all-scopes-completion",
--"--header-insertion=iwyu",
--"--background-index",
--"--suggest-missing-includes",
--"--cross-file-rename",
--},
--filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
--on_attach = on_attach,
--capabilities = capabilities,
--}
local clangd = select_executable {
    "clangd-21",
    "clangd-20",
    "clangd-19",
    "clangd-18",
    "clangd-17",
    "clangd-16",
    "clangd-15",
    "clangd-14",
    "clangd-13",
    "clangd",
}
if clangd then
    lsp_setup("clangd", {
        cmd = {
            clangd,
            "--clang-tidy",
            "--all-scopes-completion",
            "--header-insertion=iwyu",
            "--background-index",
        },
        filetypes = {
            "c",
            "cpp",
            "objc",
            "objcpp",
            "cuda", --[["glsl", "hlsl"]]
        },
        on_attach = on_attach,
        capabilities = capabilities,
        extensions = {
            -- defaults:
            -- Automatically set inlay hints (type hints)
            autoSetHints = false,
        },
    })
    vim.lsp.enable "clang"
end

lsp_setup("lua_ls", {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.uv.fs_stat(path .. "/.luarc.json") and not vim.uv.fs_stat(path .. "/.luarc.jsonc") then
            client.config.settings = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                checkThirdParty = false,
                awakened = { cat = true },
                telemetry = { enable = false },
                hint = { enable = true },
                completion = {
                    callSnippet = "Replace",
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    library = { vim.env.VIMRUNTIME },
                    checkThirdParty = false,
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                    -- library = vim.api.nvim_get_runtime_file("", true)
                },
                diagnostics = {
                    globals = { "vim", "map", "filter", "range", "reduce", "head", "tail", "nth", "it", "describe" },
                    disable = { "redefined-local" },
                },
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end,

    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_setup("rust_analyzer", {
    cmd = {
        select_executable {
            "rust-analyzer",
            ((os.getenv "HOME") or "") .. "/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rust-analyzer",
            ((os.getenv "HOME") or "") .. "/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer",
        },
    },
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
                enable = true,
            },
            completion = {
                postfix = {
                    enabled = true,
                },
                autoimport = {
                    enabled = true,
                },
            },
            procMacro = {
                enable = true,
            },
            lens = {
                methodReferences = true,
                references = true,
            },
            inlayHints = {
                bindingModeHints = { enable = false },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureCaptureHints = { enable = false },
                closureReturnTypeHints = { enable = "never" },
                closureStyle = "impl_fn",
                discriminantHints = { enable = "never" },
                expressionAdjustmentHints = {
                    --enable = "true",
                    hideOutsideUnsafe = false,
                    mode = "prefix",
                },
                lifetimeElisionHints = { enable = "never", useParameterNames = false },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = "never" },
                renderColons = true,
                typeHints = {
                    enable = true,
                    hideClosureInitialization = false,
                    hideNamedConstructor = false,
                },
            },
        },
    },
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp_setup("texlab", {
    settings = {
        latex = {
            build = {
                onSave = false,
            },
            lint = {
                onSave = false,
                onChange = true,
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

local dap = vim.F.npcall(require, "dap")
if dap then
    --  require("dap-python").setup "/usr/bin/python3"
    -- require("dap-python").test_runner = "pytest"
    dap.adapters.haskell = {
        type = "executable",
        command = "haskell-debug-adapter",
        args = { "--hackage-version=0.0.33.0" },
    }
    dap.configurations.haskell = {
        {
            type = "haskell",
            request = "launch",
            name = "Debug",
            workspace = "${workspaceFolder}",
            startup = "${file}",
            stopOnEntry = true,
            logFile = vim.fn.stdpath "data" .. "/haskell-dap.log",
            logLevel = "WARNING",
            ghciEnv = vim.empty_dict(),
            ghciPrompt = "λ: ",
            -- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
            ghciInitialPrompt = "λ: ",
            ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
        },
    }
    dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = {
            "-m",
            "debugpy.adapter",
        },
    }

    dap.adapters.cmake = {
        type = "pipe",
        pipe = "${pipe}",
        executable = {
            command = "cmake",
            args = { "--debugger", "--debugger-pipe", "${pipe}" },
        },
    }
    dap.configurations.cmake = {
        {
            name = "Build",
            type = "cmake",
            request = "launch",
        },
    }

    --dap.adapters.go = {
    --type = "executable",
    --command = "node",
    --args = {os.getenv("HOME") .. "/projects/vscode-go/dist/debugAdapter.js"}
    --}
    --dap.adapters.go = {
    --type = "executable",
    --command = "dlv",
    --args = { "dap" },
    --env = function()
    --local variables = {
    --LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
    --}
    --for k, v in pairs(vim.fn.environ()) do
    --if type(k) == "string" and type(v) == "string" then
    --table.insert(variables, string.format("%s=%s", k, v))
    --end
    --end
    --return variables
    --end,
    --}
    --dap.configurations.go = {
    --{
    --type = "go",
    --name = "Debug",
    --request = "launch",
    --showLog = false,
    --program = "${file}",
    --dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
    --},
    --}
    --dap.configurations.python = {
    --{
    --type = "python",
    --request = "attach",
    --name = "Launch file",
    --program = "${file}",
    --console = "internalConsole",
    --autoReload = { enable = true },
    --pythonPath = "/usr/bin/python3",
    --},
    --{
    --type = "python",
    --request = "attach",
    --name = "Pytest file",
    --program = "-m pytest ${file}",
    --console = "externalTerminal",
    --pythonPath = "/usr/bin/python3",
    --},
    --{
    --type = "python",
    --request = "launch",
    --name = "Launch file",
    --program = "${file}",
    --console = "internalConsole",
    --pythonPath = "/usr/bin/python3",
    --},
    --}
    require("dap.repl").commands = vim.tbl_extend("force", require("dap.repl").commands, {
        continue = { ".continue", "c" },
        next_ = { ".next", "n" },
        into = { ".into", "s" },
        into_targets = { "st" },
        out = { ".out", "r" },
        scopes = { ".scopes", "a" },
        threads = { ".threads", "t", "threads" },
        frames = { ".frames", "f", "bt" },
        exit = { "exit", ".exit", "q" },
        up = { ".up", "up" },
        down = { ".down", "down" },
        goto_ = { ".goto", "j" },
        capabilities = { ".capabilities", ".ca" },
        custom_commands = {
            [".echo"] = function(text)
                dap.repl.append(text)
            end,
        },
    })

    dap.adapters.cpp = {
        name = "cppdbg",
        type = "executable",
        command = vim.api.nvim_get_runtime_file("gadgets/linux/vscode-cpptools/debugAdapters/OpenDebugAD7", false)[1],
        args = {},
        attach = {
            pidProperty = "processId",
            pidSelect = "ask",
        },
        --configuration = {
        --type = "cppdbg",
        --args = {},
        --cwd = "${workspaceRoot}",
        --environment = {}
        --}
    }
    --dap.configurations.java = {
    --{
    --type = "java",
    --request = "attach",
    --name = "Debug (Attach) - Remote",
    --hostName = "127.0.0.1",
    --port = 5005
    --}
    --}

    dap.adapters.gdb = {
        type = "executable",
        attach = {
            pidProperty = "pid",
            pidSelect = "ask",
        },
        command = select_executable {
            "rust-gdb",
            "gdb",
        },
        args = {
            "--quiet",
            "-i",
            "dap",
        },
        --env = function()
        --local variables = {
        --LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
        --}
        --for k, v in pairs(vim.fn.environ()) do
        --table.insert(variables, string.format("%s=%s", k, v))
        --end
        --return variables
        --end,
        name = "gdb",
        stopOnEntry = true,
        --initCommands = 'command script import "/home/stephan/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/etc/lldb_lookup.py"',
    }
    --local RUSTC_SYSROOT = vim.fn.system("rustc --print sysroot"):gsub("\n", "")
    dap.adapters.lldb = {
        type = "executable",
        attach = {
            pidProperty = "pid",
            pidSelect = "ask",
        },
        command = select_executable {
            "lldb-dap-20",
            "lldb-dap-19",
            "lldb-vscode-18",
            "lldb-vscode-17",
            "lldb-vscode-16",
            "lldb-vscode-15",
            "lldb-vscode",
        },
        env = function()
            local variables = {
                LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
            }
            for k, v in pairs(vim.fn.environ()) do
                table.insert(variables, string.format("%s=%s", k, v))
            end
            return variables
        end,
        name = "lldb",
        stopOnEntry = true,
        initCommands =
        'command script import "/home/stephan/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/etc/lldb_lookup.py"',
    }
    dap.adapters.markdown = {
        type = "executable",
        name = "mockdebug",
        command = "node",
        args = { "./out/debugAdapter.js" },
        cwd = "/home/stephan/projects/vscode-mock-debug/",
    }

    dap.configurations.markdown = {
        {
            type = "mock",
            request = "launch",
            name = "mock test",
            program = "${file}",
            stopOnEntry = true,
            debugServer = 4711,
        },
    }

    dap.adapters.go = function(callback, config)
        local handle
        local port = 38697
        handle = vim.uv.spawn(
            "dlv",
            {
                args = { "dap", "-l", "127.0.0.1:" .. port },
                detached = true,
            },
            vim.schedule_wrap(function(code)
                handle:close()
                print("Delve exited with exit code: " .. code)
            end)
        )
        ------wait for delve to start
        vim.defer_fn(function()
            callback { type = "server", host = "127.0.0.1", port = port }
            dap.repl.open()
        end, 250)
        --dap.repl.open()
        --callback({type = "server", host = "127.0.0.1", port = port})
        --dap.repl.open()
    end
    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
        {
            type = "go",
            name = "Debug",
            mode = "debug",
            request = "launch",
            program = "${file}",
        },
    }

    dap.listeners.after.event_initialized["my handler id"] = function(_, _)
        --vim.cmd [[Lazy load nvim-dap-ui]]
        vim.cmd [[Lazy load telescope-dap.nvim]]
        dap.repl.open()
        --if ok then
        --dapui.open()
        --end
    end
    dap.listeners.after.event_exited["my handler id"] = function(_, _)
        vim.print "Process terminated"
    end
end

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "Stopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })
