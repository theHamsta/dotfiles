setlocal completeopt-=preview


command! DebugRepl :lua require'dap'.repl.open()<cr>
command! Debug :lua require'dap'.launch(require'dap'.adapters.go, require'dap'.configurations.go)<cr>:lua require'dap'.repl.open()<cr>

call DapMaps()

