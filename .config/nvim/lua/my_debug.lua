--
-- my_debug.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

local luajob = require "luajob"

local ENV = {}
for k, v in pairs(vim.fn.environ()) do
  table.insert(ENV, string.format("%s=%s", k, v))
end

local function luajob_on_stdout(err, data)
  if err then
    vim.cmd.echoerr("error: ", err)
  elseif data then
    local lines = vim.fn.split(data, "\n")
    for _, line in ipairs(lines) do
      print(line)
    end
  end
end

local M = {
  default_port = 5788,
}

local function get_init_commands()
  -- Find out where to look for the pretty printer Python module
  local rustc_sysroot = vim.fn.trim(vim.fn.system "rustc --print sysroot")

  local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
  local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

  local commands = {}
  local file = io.open(commands_file, "r")
  if file then
    for line in file:lines() do
      table.insert(commands, line)
    end
    file:close()
  end
  table.insert(commands, 1, script_import)

  return commands
end

M.set_debug_target = function(is_pytest)
  M.debug_target = (is_pytest and "-m pytest " or "") .. vim.fn.expand "%:p"
end

M.start_debugpy = function(target, port)
  M.debugpy = luajob:new {
    cmd = "python3 -m debugpy --listen localhost:"
      .. tostring(port or M.default_port)
      .. " --wait-for-client "
      .. target,
    on_stdout = luajob_on_stdout,
    on_stderr = luajob_on_stdout,
    on_exit = function(code, _)
      if code == 0 then
        print "debugpy terminated!"
      end
    end,
  }
  M.debugpy.start()
end

function M.python_debug(args)
  local dap = require "dap"

  dap.launch(dap.adapters.python, {
    type = "python",
    name = args[1],
    console = "integratedTerminal",
    justMyCode = false,
    request = "launch",
    program = table.remove(args, 1),
    args = args,
    --pythonPath = function()
    --return "/usr/bin/python3"
    --end
  }, dap.configurations.python[1])
  dap.repl.open()
end

function M.start_python_debugger(use_this_file, is_pytest)
  if use_this_file then
    M.set_debug_target(is_pytest)
  end
  if M.debugpy then
    M.debugpy:stop()
  end
  print("Debugging " .. M.debug_target)

  if not M.debug_target then
    vim.cmd 'echoerr "No debug target set!"'
  end

  --M.start_debugpy(M.debug_target, M.default_port)
  --os.execute("sleep 1.2")
  local dap = require "dap"
  --dap.attach("127.0.0.1", M.default_port, dap.configurations.python[1])

  dap.launch(dap.adapters.python, {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = M.debug_target,
    console = "integratedTerminal",
    --console = "internalConsole",
    justMyCode = false,
    --pythonPath = function()
    --return "/usr/bin/python3"
    --end
  }, dap.configurations.python[1])
  dap.repl.open()
end

local last_gdb_config
M.start_gdb = function(args)
  local dap = require "dap"
  args = vim.tbl_map(function(arg)
    return vim.fn.expand(arg)
  end, args)
  if args and #args > 0 then
    last_gdb_config = {
      type = "rust",
      name = args[1],
      request = "launch",
      program = table.remove(args, 1),
      args = args,
      cwd = vim.fn.getcwd(),
      --initCommands = get_init_commands(),
    }
  end

  if not last_gdb_config then
    print 'No binary to debug set! Use ":DebugLLDB <binary> <args>"'
    return
  end

  assert(dap.adapters.gdb.command)
  dap.launch(dap.adapters.gdb, last_gdb_config)
  dap.repl.open()
end

local last_lldb_config
M.start_vscode_lldb = function(args)
  local dap = require "dap"
  args = vim.tbl_map(function(arg)
    return vim.fn.expand(arg)
  end, args)
  if args and #args > 0 then
    last_lldb_config = {
      type = "rust",
      name = args[1],
      request = "launch",
      program = table.remove(args, 1),
      env = ENV,
      args = args,
      cwd = vim.fn.getcwd(),
      environment = {},
      stopOnEntry = true,
      externalConsole = true,
      expressions = "python",
      initCommands = get_init_commands(),
    }
  end

  if not last_lldb_config then
    print 'No binary to debug set! Use ":DebugLLDB <binary> <args>"'
    return
  end

  assert(dap.adapters.lldb.command)
  dap.launch(dap.adapters.lldb, last_lldb_config)
  dap.repl.open()
end

local rr_port = 232322

M.reverse_debug = function(args)
  local dap = require "dap"
  if args and #args > 0 then
    last_lldb_config = {
      name = "Replay",
      type = "lldb",
      request = "custom",
      targetCreateCommands = { "target create " .. args[1] },
      processCreateCommands = { "gdbserver 127.0.0.1:" .. rr_port },
      reverseDebugging = true,
    }
  end

  if not last_lldb_config then
    print 'No binary to debug set! Use ":DebugLLDB <binary> <args>"'
    return
  end

  dap.launch(dap.adapters.lldb, last_lldb_config)
  dap.repl.open()
end

local last_java_config
M.debug_java = function()
  local dap = require "dap"
  local dap_ui = require "dap/ui"

  last_java_config = dap_ui.pick_one(dap.configurations.java, "Main Class", function(it)
    return it.mainClass
  end)

  if not last_java_config then
    print "No Java config set!"
    return
  end
  dap.adapters.java(function(adapter)
    dap.attach(adapter.host, adapter.port, last_java_config)
  end)
  --dap.repl.open()
end

M.mock_debug = function()
  local dap = require "dap"
  local config = {
    type = "mock",
    request = "launch",
    name = "mock test",
    program = "/home/stephan/projects/vscode-mock-debug/readme.md",
    stopOnEntry = true,
    debugServer = 4711,
  }
  dap.launch(dap.adapters.markdown, config)
end

return M
