nnoremap <buffer> <F5> :Topen<cr>:let g:last_execution='python3 ' . expand('%:p',1)<cr>:wa<cr>:T python3 %<cr>
nnoremap <buffer> <s-F5> :let g:last_execution='python3 ' . expand('%:p',1)<cr>:wa<cr>:execute ':GdbStartPDB python3 -m pdb ' . expand('%:p',1)<cr>
nnoremap <buffer> <F7> :let g:last_execution='python3 -m pdb -c continue ' . expand('%:p',1)<cr>:wa<cr>:T python3 -m pdb -c continue %<cr>
nnoremap <buffer> <F4> :let g:last_execution='ipython3 ' . expand('%:p',1)<cr>:wa<cr>:T ipython3 %<cr>

nmap <buffer> <silent> <enter> <Plug>(IPy-Run)
nmap <buffer> <silent> <leader>rr <Plug>(IPy-RunAll)
nmap <buffer> <silent> <c-f> <Plug>(IPy-Complete)
nmap <buffer> <silent> <s-enter> <Plug>(IPy-RunCell)
nmap <buffer> <silent> <leader>? <Plug>(IPy-WordObjInfo)
nmap <buffer> <silent> <leader>tn <c-w>o:wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestNearest -s<CR>
nmap <buffer> <silent> <leader>tN <c-w>o:wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestNearest -s --pdb<CR>
nmap <buffer> <silent> <leader>tf :wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestFile<CR>
nmap <buffer> <silent> <leader>tF :wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestFile -s<CR>
command! Flynt !flynt %:p


nmap <buffer> <silent> <leader>tF :wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestFile -s<CR>
nmap <buffer> <silent> <leader>db :wa<cr>:lua require 'my_debug'.start_python_debugger()<cr>
nmap <buffer> <silent> <leader>dB :wa<cr>:lua require 'my_debug'.start_python_debugger(true)<cr>
nmap <buffer> <silent> <leader>bp :wa<cr>:lua require 'my_debug'.start_python_debugger(true, true)<cr>
command! DebugRepl :lua require'dap'.repl.open()<cr>

"nnoremap <buffer> <silent> <F3> :lua require'dap'.stop()<CR>
nnoremap <buffer> <silent> <F8> :lua require'dap'.step_over()<CR>
nnoremap <buffer> <silent> <F9> :lua require'dap'.step_into()<CR>
nnoremap <buffer> <silent> <F10> :lua require'dap'.step_out()<CR>

nmap <buffer> <silent> <leader>bt :wa<cr>:lua require 'my_debug'.start_python_debugger(true)<cr>

nmap <buffer> <silent> <leader>bb :lua require'dap'.toggle_breakpoint()<CR>
nmap <buffer> <silent> <leader>br :lua require'dap'.restart()<CR>
nmap <buffer> <silent> <leader>bc :lua require'dap'.continue()<CR>
nmap <buffer> <silent> <leader>bn :lua require'dap'.step_over()<CR>
nmap <buffer> <silent> <leader>bi :lua require'dap'.step_into()<CR>
nmap <buffer> <silent> <leader>bo :lua require'dap'.step_out()<CR>
nmap <buffer> <silent> <leader>bm :DebugRepl<cr>

