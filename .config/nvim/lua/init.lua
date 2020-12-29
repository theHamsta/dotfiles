vim.api.nvim_command [[
function! DeleteTrailingWS()
exe 'normal mz'
%s/\s\+$//ge
exe 'normal `z'
endfunction
]]

if not filter then
  local ok, _ = pcall(require, "fun")
  if ok then
    require "fun"()
    vim.o.shell =
      head(
      filter(
        function(e)
          return vim.fn.executable(e) == 1
        end,
        {"zsh", "fish", "bash"}
      )
    )
  end
end

--local ok, lsputil = pcall(require, "lsputil.codeAction")
--if ok then
--vim.lsp.callbacks["textDocument/codeAction"] = lsputil.code_action_handler
--vim.lsp.callbacks["textDocument/references"] = lsputil.references_handler
--vim.lsp.callbacks["textDocument/definition"] = lsputil.definition_handler
--vim.lsp.callbacks["textDocument/declaration"] = lsputil.declaration_handler
--vim.lsp.callbacks["textDocument/typeDefinition"] = lsputil.typeDefinition_handler
--vim.lsp.callbacks["textDocument/implementation"] = lsputil.implementation_handler
--vim.lsp.callbacks["textDocument/documentSymbol"] = lsputil.document_handler
--vim.lsp.callbacks["workspace/symbol"] = lsputil.workspace_handler
--end

function D(a)
  print(vim.inspect(a))
  return a
end

function E(...)
  print(vim.inspect {...})
  return ...
end

local completion_nvim_ok = pcall(require, "completion")
if completion_nvim_ok then
  vim.cmd [[
  autocmd BufEnter * lua require'completion'.on_attach()
  ]]
end

local ok, lspconfig = pcall(require, "lspconfig")

if ok then
  --local default_callback = vim.lsp.callbacks["textDocument/publishDiagnostics"]
  --vim.lsp.callbacks["textDocument/publishDiagnostics"] = function(...)
  --default_callback(...)

  --require "lsp-ext".update_diagnostics()
  --end

  local function on_attach()
    vim.fn.NvimLspMaps()
  end
  --pcall(require, "lspconfig/julials")
  --if not require("lspconfig/configs").julials.install_info().is_installed then
  -- require("lspconfig/configs").julials.install()
  --end

  pcall(require, "lspconfig/sumneko_lua")
  if not require("lspconfig/configs").sumneko_lua.install_info().is_installed then
    require("lspconfig/configs").sumneko_lua.install()
  end

  local configs = require "lspconfig.configs"
  configs.zls = {
    default_config = {
      cmd = {
        "zls"
      },
      filetypes = {"zig"},
      root_dir = function(fname)
        return require "lspconfig/util".find_git_ancestor(fname) or vim.loop.os_homedir()
      end
    }
  }

  lspconfig.julials.setup {
    on_attach = on_attach
  }
  lspconfig.ocamlls.setup {
    on_attach = on_attach
  }
  lspconfig.gopls.setup {
    on_attach = on_attach,
    settings = {
      initializationOptions = {
        usePlaceholders = false
      }
    }
  }

  --lspconfig.pyright.setup {
  --on_attach = on_attach,
  --}

  lspconfig.pyls.setup {
    on_attach = on_attach,
    settings = {
      pyls = {
        plugins = {
          pydocstyle = {
            enabled = false
          }
        }
      }
    }
  }

  lspconfig.tsserver.setup {
    on_attach = on_attach
  }
  lspconfig.hls.setup {
    on_attach = on_attach
  }
  lspconfig.clangd.setup {
    cmd = {
      "clangd-12",
      "--clang-tidy",
      "--all-scopes-completion",
      "--header-insertion=iwyu",
      "--background-index",
      "--suggest-missing-includes",
      "--cross-file-rename"
    },
    filetypes = {"c", "cpp", "objc", "objcpp", "cuda"},
    on_attach = on_attach
  }
  lspconfig.sumneko_lua.setup {
    settings = {
      Lua = {
        awakened = {cat = true},
        diagnostics = {
          globals = {"vim", "map", "filter", "range", "reduce", "head", "tail", "nth", "it", "describe"},
          disable = {"redefined-local"}
        },
        runtime = {version = "LuaJIT"},
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [require "nvim-treesitter.utils".get_package_path() .. "/lua"] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
          }
        }
      }
    },
    on_attach = on_attach
  }
  lspconfig.html.setup {
    on_attach = on_attach
  }

  lspconfig.rust_analyzer.setup {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        }
      },
      capabilities = {
        offsetEncoding = {"utf-8", "utf-16"},
        textDocument = {
          codeAction = {
            codeActionLiteralSupport = {
              codeActionKind = {
                valueSet = {}
              }
            },
            dynamicRegistration = false
          },
          completion = {
            completionItem = {
              commitCharactersSupport = false,
              deprecatedSupport = false,
              documentationFormat = {"markdown", "plaintext"},
              preselectSupport = false,
              snippetSupport = false
            },
            completionItemKind = {
              valueSet = {
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25
              }
            },
            contextSupport = false,
            dynamicRegistration = false
          },
          declaration = {
            linkSupport = true
          },
          definition = {
            linkSupport = true
          },
          documentHighlight = {
            dynamicRegistration = false
          },
          documentSymbol = {
            dynamicRegistration = false,
            hierarchicalDocumentSymbolSupport = true,
            symbolKind = {
              valueSet = {
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25,
                26
              }
            }
          },
          hover = {
            contentFormat = {"markdown", "plaintext"},
            dynamicRegistration = false
          },
          implementation = {
            linkSupport = true
          },
          references = {
            dynamicRegistration = false
          },
          signatureHelp = {
            dynamicRegistration = false,
            signatureInformation = {
              documentationFormat = {"markdown", "plaintext"}
            }
          },
          synchronization = {
            didSave = true,
            dynamicRegistration = false,
            willSave = false,
            willSaveWaitUntil = false
          },
          typeDefinition = {
            linkSupport = true
          }
        },
        workspace = {
          applyEdit = true,
          symbol = {
            dynamicRegistration = false,
            hierarchicalWorkspaceSymbolSupport = true,
            symbolKind = {
              valueSet = {
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25,
                26
              }
            }
          }
        }
      }
    },
    on_attach = on_attach
  }

  --local java = function()
  --pcall(require, "lspconfig/jdtls")
  --if not require("lspconfig/configs").jdtls.install_info().is_installed then
  --require("lspconfig/configs").jdtls.install()
  --end
  --local capabilities = vim.lsp.protocol.make_client_capabilities()
  --capabilities.textDocument.completion.completionItem.snippetSupport = true
  --capabilities.textDocument.codeAction = {
  --dynamicRegistration = false,
  --codeActionLiteralSupport = {
  --codeActionKind = {
  --valueSet = {
  --"source.generate.toString",
  --"source.generate.hashCodeEquals",
  --"source.organizeImports"
  --}
  --}
  --}
  --}
  --lspconfig.jdtls.setup {
  --init_options = {
  --bundles = {
  --vim.fn.glob("~/.local/share/nvim/plugged/nvim-jdtls/*.jar")
  --},
  --config = {
  --java = {
  --import = {
  --gradle = {
  --wrapper = {
  --checksums = {
  --{
  --sha256 = "803c75f3307787290478a5ccfa9054c5c0c7b4250c1b96ceb77ad41fbe919e4e",
  --allowed = true
  --}
  --}
  --}
  --}
  --}
  --}
  --}
  --},
  --capabilities = capabilities,
  --on_attach = function(client)
  --on_attach(client)
  --require("jdtls").setup_dap()
  --end
  --}
  --end
  pcall(java)
  lspconfig.vimls.setup {
    on_attach = on_attach
  }
  lspconfig.yamlls.setup {
    on_attach = on_attach
  }
  lspconfig.jsonls.setup {
    on_attach = on_attach
  }

  lspconfig.texlab.setup {
    settings = {
      latex = {
        build = {
          onSave = false
        },
        lint = {
          onSave = false,
          onChange = true
        }
      }
    },
    on_attach = on_attach
  }
end

local ok, colorizer = pcall(require, "colorizer")
if ok then
  colorizer.setup {
    "css",
    "javascript",
    "tex",
    "html",
    "vim",
    "tex"
  }
end

local ok, dap = pcall(require, "dap")
if ok then
  require("dap-python").setup("/usr/bin/python3")
  require("dap-python").test_runner = "pytest"
  dap.adapters.python = {
    type = "executable",
    command = "python3",
    args = {
      "-m",
      "debugpy.adapter"
    }
  }
  dap.configurations.python = {
    {
      type = "python",
      request = "attach",
      name = "Launch file",
      program = "${file}",
      console = "internalConsole"
    },
    {
      type = "python",
      request = "attach",
      name = "Pytest file",
      program = "-m pytest ${file}",
      console = "externalTerminal"
      --return "/usr/bin/python3"
      --end
    },
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      console = "internalConsole"
    }
  }
  dap.repl.commands =
    vim.tbl_extend(
    "force",
    dap.repl.commands,
    {
      continue = {".continue", "c"},
      next_ = {".next", "n"},
      into = {".into", "s"},
      out = {".out", "r"},
      scopes = {".scopes", "a"},
      threads = {".threads", "t"},
      frames = {".frames", "f"},
      exit = {"exit", ".exit"},
      up = {".up", "up"},
      down = {".down", "down"},
      goto_ = {".goto", "j"},
      into_targets = {".into_targets", "t"},
      capabilities = {".capabilities", ".ca"},
      custom_commands = {
        [".echo"] = function(text)
          dap.repl.append(text)
        end
      }
    }
  )
  vim.g.dap_virtual_text = true -- 'all frames'

  dap.adapters.cpp = {
    name = "cppdbg",
    type = "executable",
    command = vim.api.nvim_get_runtime_file("gadgets/linux/vscode-cpptools/debugAdapters/OpenDebugAD7", false)[1],
    args = {},
    attach = {
      pidProperty = "processId",
      pidSelect = "ask"
    }
    --configuration = {
    --type = "cppdbg",
    --args = {},
    --cwd = "${workspaceRoot}",
    --environment = {}
    --}
  }
  dap.configurations.java = {
    {
      type = "java",
      request = "attach",
      name = "Debug (Attach) - Remote",
      hostName = "127.0.0.1",
      port = 5005
    }
  }
  dap.adapters.lldb = {
    type = "executable",
    attach = {
      pidProperty = "pid",
      pidSelect = "ask"
    },
    command = "lldb-vscode-12",
    env = {
      LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
    },
    name = "lldb"
  }
  dap.adapters.markdown = {
    type = "executable",
    name = "mockdebug",
    command = "node",
    args = {"./out/debugAdapter.js"},
    cwd = "/home/stephan/projects/vscode-mock-debug/"
  }

  if dap.custom_event_handlers then
    dap.custom_event_handlers.event_exited["my handler id"] = function(_, _)
      dap.repl.close()
      vim.cmd("stopinsert")
    end

    dap.custom_response_handlers.gotoTargets["my handler id"] = function(_, _)
      --dap.repl.append(vim.inspect(body))
    end
    dap.custom_event_handlers.event_stopped["my handler id"] = function(_, _)
      --dap.repl.append(vim.inspect(body))
      --dap.repl.append(vim.inspect(session))
    end
  end
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

vim.fn.sign_define("DapBreakpoint", {text = "🛑", texthl = "", linehl = "", numhl = ""})
vim.fn.sign_define("DapStopped", {text = "→", texthl = "", linehl = "NvimDapStopped", numhl = ""})
local ok, _ = pcall(require, "nvim-treesitter.configs")
if ok then
  vim.cmd("set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()")
  --require "nvim-treesitter.parsers".get_parser_configs().toml = {
  --install_info = {
  --url = "~/projects/tree-sitter-toml",
  --files = {"src/parser.c", "src/scanner.c"}
  --}
  --}
  --require "nvim-treesitter.parsers".get_parser_configs().lisp = {
  --install_info = {
  --url = "~/projects/clojure-lisp2",
  --files = {"src/parskwser.c"}
  --}
  --}
  --require "nvim-treesitter.parsers".get_parser_configs().julia = {
  --install_info = {
  --url = "~/projects/tree-sitter-julia",
  --files = {"src/parser.c", "src/scanner.c"}
  --}
  --}
  --require "nvim-treesitter.parsers".get_parser_configs().zig = {
  --install_info = {
  --url = "https://github.com/GrayJack/tree-sitter-zig",
  --files = {"src/parser.c"}
  --}
  --}
  --require "nvim-treesitter.parsers".get_parser_configs().dart = {
  --install_info = {
  --url = "~/projects/tree-sitter-dart",
  --files = {"src/parser.c", "src/scanner.c"}
  --}
  --}
  --require "nvim-treesitter.parsers".get_parser_configs().kotlin = {
  --install_info = {
  --url = "https://github.com/QthCN/tree-sitter-kotlin",
  --files = {"src/parser.c"}
  --}
  --}
  require "nvim-treesitter.configs".setup(
    {
      highlight = {
        enable = true -- false will disable the whole extension
        --disable = {"html"} -- list of language that will be disabled
      },
      query_linter = {
        enable = true
      },
      tree_docs = {
        enable = true,
        keymaps = {
          doc_node_at_cursor = "<leader>GDD",
          doc_all_in_range = "<leader>GDD"
        }
      },
      playground = {
        enable = true
      },
      incremental_selection = {
        -- this enables incremental selection
        enable = true,
        disable = {},
        keymaps = {
          init_selection = "<enter>", -- maps in normal mode to init the node/scope selection
          node_incremental = "<enter>", -- increment to the upper named parent
          scope_incremental = "Ts", -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "<bs>"
        }
      },
      node_movement = {
        -- this enables incremental selection
        enable = true,
        highlight_current_node = true,
        disable = {"python"},
        keymaps = {
          move_up = "<a-k>",
          move_down = "<a-j>",
          move_left = "<a-h>",
          move_right = "<a-l>",
          swap_up = "<s-a-k>",
          swap_down = "<s-a-j>",
          swap_left = "<s-a-h>",
          swap_right = "<s-a-l>",
          select_current_node = "<leader>ff"
        }
      },
      textobjects = {
        select = {
          enable = true,
          disable = {},
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["ae"] = "@block.outer",
            ["ie"] = "@block.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["is"] = "@statement.inner",
            ["as"] = "@statement.outer",
            ["ad"] = "@lhs.inner",
            ["id"] = "@rhs.inner",
            ["am"] = "@call.outer",
            ["im"] = "@call.inner"
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ["<a-l>"] = "@parameter.inner",
            ["<a-f>"] = "@function.outer",
            ["<a-s>"] = "@statement.outer"
          },
          swap_previous = {
            ["<a-L>"] = "@parameter.inner",
            ["<a-F>"] = "@function.outer",
            ["<a-S>"] = "@statement.outer"
          }
        },
        lsp_interop = {
          enable = true,
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer"
          },
          peek_type_definition_code = {
            ["<leader>TF"] = "@class.outer"
          }
        },
        move = {
          enable = true,
          goto_next_start = {
            ["öö"] = "@function.inner"
          },
          goto_next_end = {
            ["ÖÖ"] = "@function.inner"
          },
          goto_previous_start = {
            ["üü"] = "@function.inner"
          },
          goto_previous_end = {
            ["ÜÜ"] = "@function.inner"
          }
        }
      },
      fold = {
        enable = true
      },
      refactor = {
        highlight_current_scope = {
          enable = false,
          inverse_highlighting = true,
          disable = {"python"}
        },
        highlight_definitions = {
          enable = true,
          disable = {"cpp", "c"}
        },
        smart_rename = {
          enable = true,
          disable = {},
          keymaps = {
            smart_rename = "grr"
          }
        },
        navigation = {
          enable = true,
          disable = {},
          keymaps = {
            goto_definition = "gnd",
            list_definitions = "gnD",
            goto_next_usage = "<a-*>",
            goto_previous_usage = "<a-#>"
          }
        }
      },
      indent = {
        enable = false
      }
      --ensure_installed = "all",
      --update_strategy = "lockfile"
    }
  )
  require "nvim-treesitter.highlight"
  local hlmap = vim.treesitter.highlighter.hl_map

  --Misc
  hlmap.error = nil
  hlmap["punctuation.delimiter"] = "Delimiter"
  --hlmap["punctuation.bracket"] = nil

  -- Constants
  hlmap["constant"] = "Constant"
  hlmap["constant.builtin"] = "Type"
  hlmap["constant.macro"] = "Define"
  hlmap["string"] = "String"
  hlmap["string.regex"] = "String"
  hlmap["string.escape"] = "SpecialChar"
  hlmap["character"] = "Character"
  hlmap["number"] = "Number"
  hlmap["boolean"] = "Boolean"
  hlmap["float"] = "Float"

  hlmap["namespace"] = "Constant"
  -- Functions
  hlmap["function"] = "Function"
  hlmap["keyword.function"] = "Function"
  hlmap["keyword.operator"] = "Operator"
  hlmap["function.builtin"] = "Special"
  hlmap["function.macro"] = "Macro"
  hlmap["parameter"] = "Identifier"
  hlmap["method"] = "Identifier"
  hlmap["field"] = "Identifier"
  hlmap["property"] = "Identifier"
  hlmap["constructor"] = "Type"

  -- Keywords
  hlmap["conditional"] = "Conditional"
  hlmap["repeat"] = "Repeat"
  hlmap["label"] = "Label"
  hlmap["operator"] = "Operator"
  hlmap["keyword"] = "Repeat"
  hlmap["exception"] = "Exception"
  hlmap["include"] = "Include"
  hlmap["type"] = "Type"
  hlmap["type.builtin"] = "Type"
  hlmap["structure"] = "Structure"
  hlmap["keyword.function"] = "Function"
  hlmap["variable"] = nil

  --for k, _ in pairs(hlmap) do
  --if k~="punctuation.bracket" then
  --hlmap[k] = nil
  --end
  --end

  local ok, docs = pcall(require, "nvim-tree-docs")
  if ok then
    docs.init()
  end
  local ok, play = pcall(require, "nvim-treesitter-playground")
  if ok then
    play.init()
  end
end

--

vim.cmd [[
    command! JustTargets lua require'my_launcher'.fuzzy_just()<cr>
]]
vim.cmd [[
    command! JustTargetsAsync lua require'my_launcher'.fuzzy_just(true)<cr>
]]
vim.cmd [[
    command! -nargs=1 JustRun lua require "my_launcher".run_just_task(<f-args>)
]]
vim.cmd [[
    command! -nargs=1 JustRunAsync lua require "my_launcher".run_just_task(<f-args>, true)
]]
vim.cmd [[
    command! -complete=file -nargs=* DebugC lua require "my_debug".start_c_debugger({<f-args>}, "gdb")
]]
vim.cmd [[
    command! -complete=file -nargs=* DebugRust lua require "my_debug".start_c_debugger({<f-args>}, "gdb", "rust-gdb")
]]
vim.cmd [[
    command! -complete=file -nargs=* DebugLLDB lua require "my_debug".start_vscode_lldb({<f-args>})
]]
vim.cmd [[
    command! -complete=file -nargs=* ReverseDebug lua require "my_debug".reverse_debug({<f-args>})
]]
vim.cmd [[
    command! MockDebug lua require "my_debug".mock_debug()
]]
vim.cmd [[
    command! -nargs=* DebugJava lua require "my_debug".debug_java({<f-args>})
]]
vim.cmd [[
    command! SwitchHeaderSource lua require "lsp-ext".switch_header_source()
]]
vim.g.my_font = '"FuraCode Nerd Font"'
vim.g.my_fontsize = 8
vim.cmd("set guicursor+=a:blinkon333")
vim.cmd("set guifont=" .. vim.g.my_font .. ":h" .. (vim.g.my_fontsize))
vim.cmd [[
command! StopLspClients :lua vim.lsp.stop_client(vim.lsp.get_active_clients())
]]

--vim.api.nvim_command [[
--command! -nargs=1 JustTargets lua require "my_launcher".fuzzy_just(<f-args>)
--]]

local ok, context = pcall(require, "treesitter-context")
if ok then
  context.enable()
end

local ok, lspfuzzy = pcall(require, "lspfuzzy")
if ok then
  lspfuzzy.setup {}
end

require "toggleterm".setup {
  size = 20,
  open_mapping = [[<f4>]],
  shade_filetypes = {},
  shade_terminals = true,
  persist_size = true,
  direction = "horizontal"
}
