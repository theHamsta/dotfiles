nmap <buffer> <silent> <leader>bt :wa<cr>:lua require 'my_debug'.start_rust_debugger()<cr>

nmap <buffer> <silent> <leader>bb :lua require'dap'.toggle_breakpoint()<CR>
nmap <buffer> <silent> <leader>br :lua require'dap'.restart()<CR>
nmap <buffer> <silent> <leader>bc :lua require'dap'.continue()<CR>
nmap <buffer> <silent> <leader>bn :lua require'dap'.step_over()<CR>
nmap <buffer> <silent> <leader>bi :lua require'dap'.step_into()<CR>
nmap <buffer> <silent> <leader>bo :lua require'dap'.step_out()<CR>
nmap <buffer> <silent> <leader>bm :DebugRepl<cr>
