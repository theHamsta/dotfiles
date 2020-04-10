autocmd FileType python nnoremap <buffer> <F5> :Topen<cr>:let $last_execution='python3 ' . expand('%:p',1)<cr>:wa<cr>:T python3 %<cr>
autocmd FileType python nnoremap <buffer> <s-F5> :let $last_execution='python3 ' . expand('%:p',1)<cr>:wa<cr>:execute ':GdbStartPDB python3 -m pdb ' . expand('%:p',1)<cr>
autocmd FileType python nnoremap <buffer> <F7> :let $last_execution='python3 -m pdb -c continue ' . expand('%:p',1)<cr>:wa<cr>:T python3 -m pdb -c continue %<cr>
autocmd FileType python nnoremap <buffer> <F4> :let $last_execution='ipython3 ' . expand('%:p',1)<cr>:wa<cr>:T ipython3 %<cr>

autocmd FileType python nmap <silent> <enter> <Plug>(IPy-Run)
autocmd FileType python nmap <silent> <leader>rr <Plug>(IPy-RunAll)
autocmd FileType python nmap <silent> <c-f> <Plug>(IPy-Complete)
autocmd FileType python nmap <silent> <s-enter> <Plug>(IPy-RunCell)
autocmd FileType python nmap <silent> <leader>? <Plug>(IPy-WordObjInfo)
autocmd FileType python nmap <silent> <leader>tn <c-w>o:wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestNearest -s<CR>
autocmd FileType python nmap <silent> <leader>tN <c-w>o:wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestNearest -s --pdb<CR>
autocmd FileType python nmap <silent> <leader>tf :wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestFile<CR>
autocmd FileType python nmap <silent> <leader>tF :wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestFile -s<CR>
autocmd FileType python command! Flynt !flynt %:p
