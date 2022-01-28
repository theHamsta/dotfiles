setlocal completeopt-=preview


command! DebugRepl :lua require'dap'.repl.open()<cr>
command! Debug :lua require'dap'.launch(require'dap'.adapters.go, require'dap'.configurations.go)<cr>:lua require'dap'.repl.open()<cr>
nmap <buffer> <silent> <leader>bt :wa<cr>:lua require("dap").run(require'dap'.configurations.go[1])<cr>

call DapMaps()

autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
