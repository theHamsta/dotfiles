nmap <buffer> <silent> <leader>bt :wa<cr>:lua require 'my_debug'.start_rust_debugger()<cr>

call DapMaps()
