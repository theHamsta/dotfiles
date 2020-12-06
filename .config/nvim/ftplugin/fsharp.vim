let g:fsharp#fsi_window_command = "80vnew"
autocmd FileType fsharp nnoremap <buffer> <c-s> ma:w<cr>:%!fantomas %<cr>:e!<cr>'azz
autocmd FileType fsharp nnoremap <buffer> <cr> :FsiEvalBuffer<cr>
