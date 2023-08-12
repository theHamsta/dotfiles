--local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
--if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
--vim.cmd [[packadd packer.nvim]]
--end

vim.loader.enable()
local shell = require "nvim-treesitter.shell_command_selectors"

vim.api.nvim_command [[
function! DeleteTrailingWS()
exe 'normal mz'
%s/\s\+$//ge
exe 'normal `z'
endfunction
]]

vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

local lsp_status = vim.F.npcall(require, "lsp-status")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
if lsp_status then
  capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)
end
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

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
}

require("nvim-treesitter.install").prefer_git = false

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

local neodev = vim.F.npcall(require, "neodev")
if neodev then
  neodev.setup {
    -- add any options here, or leave empty to use the default settings
  }
end

local lspconfig = vim.F.npcall(require, "lspconfig")
local lsp_signature = vim.F.npcall(require, "lsp_signature")

if lspconfig then
  --require("lspkind").init()
  local function on_attach(client, bufnr)
    --local ih = require "inlay-hints"
    --ih.on_attach(client, bufnr)
    --require("lsp-inlayhints").on_attach(client, bufnr)
    if client.supports_method "textDocument/inlayHint" or client.name == "rust_analyzer" then
      vim.lsp.inlay_hint(bufnr, true)
    end
    --local caps = client.server_capabilities
    --if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    --vim.cmd [[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.buf.semantic_tokens_full()]]
    --end
    vim.fn.NvimLspMaps()
    if lsp_signature and vim.bo[bufnr].ft ~= "glsl" then
      lsp_signature.on_attach()
    end
    if lsp_status then
      lsp_status.on_attach(client)
    end
  end

  local configs = require "lspconfig.configs"
  local nvim_lsp = require "lspconfig"
  if not configs.neocmake then
    configs.neocmake = {
      default_config = {
        cmd = { "neocmakelsp", "--stdio" },
        filetypes = { "cmake" },
        root_dir = function(fname)
          return nvim_lsp.util.find_git_ancestor(fname)
        end,
        single_file_support = true, -- suggested
        on_attach = on_attach,
      },
    }
    nvim_lsp.neocmake.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end

  --pcall(require, "lspconfig/julials")
  --if not require("lspconfig/configs").julials.install_info().is_installed then
  -- require("lspconfig/configs").julials.install()
  --end

  --pcall(require, "lspconfig/sumneko_lua")
  --if not require("lspconfig/configs").sumneko_lua.install_info().is_installed then
  --require("lspconfig/configs").sumneko_lua.install()
  --end
  lspconfig.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.jdtls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      java = {
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
  }
  require("lspconfig").intelephense.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  require("lspconfig").taplo.setup { on_attach = on_attach, capabilities = capabilities }

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

  lspconfig.flow.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.glslls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.wgsl_analyzer.setup {
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
          ["bevy_pbr::clustered_forward"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/clustered_forward.wgsl",
          ["bevy_pbr::mesh_bindings"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_bindings.wgsl",
          ["bevy_pbr::mesh_functions"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_functions.wgsl",
          ["bevy_pbr::mesh_types"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_types.wgsl",
          ["bevy_pbr::mesh_vertex_output"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_vertex_output.wgsl",
          ["bevy_pbr::mesh_view_bindings"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_view_bindings.wgsl",
          ["bevy_pbr::mesh_view_types"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/mesh_view_types.wgsl",
          ["bevy_pbr::pbr_bindings"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/pbr_bindings.wgsl",
          ["bevy_pbr::pbr_functions"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/pbr_functions.wgsl",
          ["bevy_pbr::lighting"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/pbr_lighting.wgsl",
          ["bevy_pbr::pbr_types"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/pbr_types.wgsl",
          ["bevy_pbr::shadows"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/shadows.wgsl",
          ["bevy_pbr::skinning"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/skinning.wgsl",
          ["bevy_pbr::utils"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_pbr/src/render/utils.wgsl",
          ["bevy_sprite::mesh2d_bindings"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_bindings.wgsl",
          ["bevy_sprite::mesh2d_functions"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_functions.wgsl",
          ["bevy_sprite::mesh2d_types"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_types.wgsl",
          ["bevy_sprite::mesh2d_vertex_output"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_vertex_output.wgsl",
          ["bevy_sprite::mesh2d_view_bindings"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_view_bindings.wgsl",
          ["bevy_sprite::mesh2d_view_types"] = "https://raw.githubusercontent.com/bevyengine/bevy/v0.10.0/crates/bevy_sprite/src/mesh2d/mesh2d_view_types.wgsl",
        },
      },
    },
  }

  lspconfig.marksman.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  --lspconfig.fsautocomplete.setup {
  --on_attach = on_attach,
  --capabilities = capabilities,
  --}
  lspconfig.csharp_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.zls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "sh", "bash", "make", "zsh" },
  }

  lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  }

  lspconfig.svelte.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.julials.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.ocamllsp.setup {
    on_attach = function(...)
      require("virtualtypes").on_attach(...)
      on_attach()
    end,
  }
  lspconfig.gopls.setup {
    on_attach = on_attach,
    settings = {
      initializationOptions = {
        usePlaceholders = true,
      },
      gopls = {
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
  }

  lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.pylsp.setup {
    on_attach = on_attach,
    settings = {
      pyls = {
        plugins = {
          pydocstyle = {
            enabled = false,
          },
          flake8 = {
            maxLineLength = 120,
          },
          pycodestyle = {
            ignore = { "E501" },
            maxLineLength = 120,
          },
        },
      },
    },
    capabilities = capabilities,
  }

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

  lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.kotlin_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.hls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
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
  local clangd = shell.select_executable { "clangd-18", "clangd-17", "clangd-16", "clangd-15", "clangd" }
  if clangd then
    lspconfig.clangd.setup {
      cmd = {
        clangd,
        "--clang-tidy",
        "--all-scopes-completion",
        "--header-insertion=iwyu",
        "--background-index",
        "--suggest-missing-includes",
        "--cross-file-rename",
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
    }
  end

  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        checkThirdParty = false,
        awakened = { cat = true },
        telemetry = { enable = false },
        hint = { enable = true },
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = { "vim", "map", "filter", "range", "reduce", "head", "tail", "nth", "it", "describe" },
          disable = { "redefined-local" },
        },
        runtime = { version = "LuaJIT" },
        --workspace = {
        --library = {
        --[vim.fn.expand "$VIMRUNTIME/lua"] = true,
        --[require("nvim-treesitter.utils").get_package_path() .. "/lua"] = true,
        --[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        --},
        --},
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.html.setup {
    on_attach = on_attach,
  }

  lspconfig.rust_analyzer.setup {
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
            enable = "true",
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
  }

  lspconfig.vimls.setup {
    on_attach = on_attach,
  }
  lspconfig.yamlls.setup {
    on_attach = on_attach,
  }
  lspconfig.jsonls.setup {
    on_attach = on_attach,
  }

  lspconfig.texlab.setup {
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
  }
end

local dap = vim.F.npcall(require, "dap")
if dap then
  vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "→", texthl = "", linehl = "NvimDapStopped", numhl = "" })

  require("dap-python").setup "/usr/bin/python3"
  require("dap-python").test_runner = "pytest"
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

  --local RUSTC_SYSROOT = vim.fn.system("rustc --print sysroot"):gsub("\n", "")
  dap.adapters.lldb = {
    type = "executable",
    attach = {
      pidProperty = "pid",
      pidSelect = "ask",
    },
    command = shell.select_executable {
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
    initCommands = 'command script import "/home/stephan/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/etc/lldb_lookup.py"',
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
    handle = vim.loop.spawn(
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

  --local ok, dapui = pcall(require, 'dapui')

  --if dap.custom_event_handlers then
  dap.listeners.after.event_initialized["my handler id"] = function(_, _)
    vim.cmd [[Lazy load nvim-dap-ui]]
    vim.cmd [[Lazy load telescope-dap.nvim]]
    dap.repl.open()
    --if ok then
    --dapui.open()
    --end
  end
  --dap.listeners.after.event_stopped["my handler id"] = function(_, response)
  --dap.repl.append(vim.inspect(response))
  --dap.repl.append(vim.inspect(dap.session().current_frame))
  --end
  dap.listeners.after.event_exited["my handler id"] = function(_, _)
    --dap.repl.close()
    --if ok then
    --dapui.close()
    --end
    --vim.cmd "stopinsert"
  end

  --dap.custom_response_handlers.gotoTargets["my handler id"] = function(_, _)
  ----dap.repl.append(vim.inspect(body))
  --end
  --dap.custom_event_handlers.event_stopped["my handler id"] = function(session, _)
  ----dap.repl.append(vim.inspect(body))
  ----dap.repl.append(vim.inspect(session))
  --end
  --end
  --"<name>: Attach": {
  --"adapter": "vscode-cpptools",
  --"configuration": {
  --"name": "<name>: Attach",
  --"type": "cppdbg",
  --"request": "attach",
  --"program": "<path to binary>",
  --"MIMode": "lldb"
  --}
  --}
end

local ok, _ = pcall(require, "nvim-treesitter.configs")
if ok then
  vim.treesitter.language.register("wgsl_bevy", "wgsl")
  --vim.cmd "set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()"
  --local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

  --parser_configs.norg = {
  --install_info = {
  --url = "https://github.com/nvim-neorg/tree-sitter-norg",
  --files = { "src/parser.c", "src/scanner.cc" },
  --branch = "main",
  --},
  --}
  --parser_configs.markdown = {
  --install_info = {
  --url = "https://github.com/MDeiml/tree-sitter-markdown",
  --files = { "src/parser.c", "src/scanner.cc" },
  --branch = "main",
  --},
  --}
  --local list = require("nvim-treesitter.parsers").get_parser_configs()
  --list.commonlisp = {
  --install_info = {
  --url = "~/projects/tree-sitter-commonlisp",
  --files = {"src/parser.c"}
  --},
  --filetype = "lisp",
  --maintainers = {"@theHamsta"}
  --}
  --list.make = {
  --install_info = {
  --url = "https://github.com/alemuller/tree-sitter-make",
  --files = { "src/parser.c" },
  --branch = "main",
  --filetype = "Makefile",
  --},
  --}

  --parser_configs.norg = {
  --install_info = {
  --url = "https://github.com/vhyrro/tree-sitter-norg",
  --files = { "src/parser.c" },
  --branch = "main",
  --},
  --}
  --
  require("nvim-treesitter.configs").setup {
    auto_install = false,
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {}, -- list of language that will be disabled
    },
    query_linter = {
      enable = false,
      lint_events = { "BufWrite", "CursorHold" },
    },
    tree_docs = {
      enable = true,
      keymaps = {
        doc_node_at_cursor = "<leader>GDD",
        doc_all_in_range = "<leader>GDD",
      },
    },
    playground = {
      enable = true,
    },
    incremental_selection = {
      -- this enables incremental selection
      enable = true,
      disable = {},
      keymaps = {
        init_selection = "<leader><enter>", -- maps in normal mode to init the node/scope selection
        node_incremental = "<leader><enter>", -- increment to the upper named parent
        scope_incremental = "Ts", -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "<bs>",
      },
    },
    node_movement = {
      enable = true,
      highlight_current_node = true,
      keymaps = {
        move_up = "<a-k>",
        move_down = "<a-j>",
        move_left = "<a-h>",
        move_right = "<a-l>",
        swap_up = "<s-a-k>",
        swap_left = "<s-a-h>",
        swap_right = "<s-a-l>",
        select_current_node = "<cr>",
      },
      allow_switch_parents = true,
      allow_next_parent = true,
    },
    rainbow = {
      enable = false,
      extended_mode = {
        latex = true,
      },
    },
    autotag = {
      enable = true,
    },
    pairs = {
      enable = true,
      highlight_pair_events = {},
      highlight_self = false,
      goto_right_end = false,
      fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')",
      keymaps = {
        goto_partner = "%",
        --delete_balanced = "x"
      },
      delete_balanced = {
        only_on_first_char = true,
        fallback_cmd_normal = "normal! x",
        longest_partner = true,
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        lookbehind = true,
        include_surrounding_whitespace = true,
        disable = {},
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["aü"] = "@conditional.outer",
          ["iü"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["is"] = "@statement.inner",
          --["as"] = "@statement.outer",
          ["ad"] = "@lhs.inner",
          ["id"] = "@rhs.inner",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner",
          ["iM"] = "@frame.inner",
          ["aM"] = "@frame.outer",
          ["ai"] = "@parameter.outer",
          ["ii"] = "@parameter.inner",
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },

          --["aS"] = { "@scope", "locals" }, -- selects `@scope` from locals.scm
        },
      },
      swap = {
        enable = true,
        super_repeat = { ["<c-ü>"] = "h" },
        swap_next = {
          ["<leader>ä"] = "@parameter.inner",
          ["<a-f>"] = "@function.outer",
          --["<a-s>"] = { "@scope", "locals" },
        },
        swap_previous = {
          ["<leader>Ä"] = "@parameter.inner",
          ["<a-F>"] = "@function.outer",
          --["<a-S>"] = { "@scope", "locals" },
        },
      },
      lsp_interop = {
        enable = true,
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
        peek_type_definition_code = {
          ["<leader>TF"] = "@class.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = false,
        goto_next_start = {
          ["öö"] = { "@function.inner", "locals" },
        },
        goto_previous_start = {
          ["ÖÖ"] = { "@function.inner", "locals" },
          ["üü"] = "@class.outer",
        },
      },
    },
    fold = {
      enable = false,
      fold_one_line_after = false,
    },
    refactor = {
      highlight_current_scope = {
        enable = false,
        inverse_highlighting = true,
        disable = { "python" },
      },
      highlight_definitions = {
        enable = false,
        disable = { "cpp", "c", "javascript", "typescript" },
      },
      smart_rename = {
        enable = false,
        disable = {},
        keymaps = {
          smart_rename = "grr",
        },
      },
      navigation = {
        enable = false,
        disable = {},
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>",
        },
      },
    },
    indent = {
      enable = true,
      --disable = "python",
    },
    --ensure_installed = "all",
    --update_strategy = "do not use lockfile, please!"
  }
  local hlmap = {}

  --misc
  hlmap["error"] = "tserror"
  hlmap["none"] = "None"
  hlmap["punctuation.delimiter"] = "delimiter"
  hlmap["interface"] = "Type"
  --hlmap["punctuation.bracket"] = nil

  -- constants
  hlmap["constant"] = "Constant"
  hlmap["attribute"] = "Type"
  hlmap["comment"] = "Comment"
  hlmap["constant"] = "Constant"
  hlmap["semshi"] = "semshiimported"
  hlmap["constant.builtin"] = "boolean"
  hlmap["constant.macro"] = "define"
  hlmap["string"] = "string"
  hlmap["string.regex"] = "string"
  hlmap["string.escape"] = "specialchar"
  hlmap["character"] = "number"
  hlmap["number"] = "number"
  hlmap["boolean"] = "boolean"
  hlmap["float"] = "float"

  hlmap["namespace"] = "constant"
  -- functions
  hlmap["function"] = "function"
  hlmap["keyword.function"] = "operator"
  hlmap["keyword.operator"] = "operator"
  hlmap["keyword.return"] = "repeat"
  hlmap["function.builtin"] = "special"
  hlmap["function.macro"] = "macro"
  hlmap["parameter"] = "identifier"
  hlmap["method"] = "function"
  hlmap["field"] = "identifier"
  hlmap["property"] = "identifier"
  hlmap["constructor"] = "function"

  -- keywords
  hlmap["conditional"] = "conditional"
  hlmap["conditional.ternary"] = "operator"
  hlmap["text.title"] = "markdownh1"
  hlmap["repeat"] = "repeat"
  hlmap["label"] = "label"
  hlmap["operator"] = "operator"
  hlmap["keyword"] = "repeat"
  hlmap["exception"] = "exception"
  hlmap["include"] = "include"
  hlmap["type"] = "type"
  hlmap["type.qualifier"] = "Keyword"
  hlmap["type.builtin"] = "type"
  hlmap["structure"] = "structure"
  hlmap["variable"] = "tsvariable"
  hlmap["variable.builtin"] = "type"
  hlmap["symbol"] = "type"
  hlmap["text.environment.name"] = "type"

  for k, v in pairs(hlmap) do
    vim.api.nvim_set_hl(0, "@" .. k, { link = v })
  end

  local docs = vim.F.npcall(require, "nvim-tree-docs")
  if docs then
    docs.init()
  end
  local play = vim.F.npcall(require, "nvim-treesitter-playground")
  if play then
    play.init()
  end
end

vim.cmd [[
command! -complete=file -nargs=* DebugRust lua require "my_debug".start_c_debugger({<f-args>}, "gdb", "rust-gdb")
]]
vim.cmd [[
command! -complete=file -nargs=* DebugLLDB lua require "my_debug".start_vscode_lldb({<f-args>})
]]
vim.cmd [[
command! -complete=file -nargs=* PythonDebug lua require "my_debug".python_debug({<f-args>})
]]

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.norg = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main",
  },
} --local function safe_read(filename, read_quantifier)  --local file, err = io.open(filename, "r")  --if not file then  --error(err)  --end  --local content = file:read(read_quantifier)  --io.close(file)  --return content  --end  --local function read_query_files(filenames)  --local contents = {}  --for _, filename in ipairs(filenames) do  --table.insert(contents, safe_read(filename, "*a"))  --end  --return table.concat(contents, "")  --end  --vim.treesitter.query.set_query(  --"lua",  --"highlights",  --read_query_files(vim.treesitter.query.get_query_files("lua", "highlights")):gsub(  --[[%[  --"goto"  --"in"  --"local"  --%] @keyword]],
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "Stopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapLogPoint",
  { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

for _, parser in ipairs(require("nvim-treesitter.parsers").get_parser_configs()) do
  parser.repo.use_makefile = true
end
