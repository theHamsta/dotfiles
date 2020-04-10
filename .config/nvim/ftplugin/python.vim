nnoremap <buffer> <F5> :Topen<cr>:let $last_execution='python3 ' . expand('%:p',1)<cr>:wa<cr>:T python3 %<cr>
nnoremap <buffer> <s-F5> :let $last_execution='python3 ' . expand('%:p',1)<cr>:wa<cr>:execute ':GdbStartPDB python3 -m pdb ' . expand('%:p',1)<cr>
nnoremap <buffer> <F7> :let $last_execution='python3 -m pdb -c continue ' . expand('%:p',1)<cr>:wa<cr>:T python3 -m pdb -c continue %<cr>
nnoremap <buffer> <F4> :let $last_execution='ipython3 ' . expand('%:p',1)<cr>:wa<cr>:T ipython3 %<cr>

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
