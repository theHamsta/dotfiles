nmap <buffer> <silent> <leader>bt :wa<cr>:lua require 'my_debug'.start_rust_debugger()<cr>

call DapMaps()

nmap <buffer> <silent> <a-o> :ClangdSwitchSourceHeader<cr>


fun! IgnoreCamelCaseSpell()
  syn match CamelCase /\<[A-Z][a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  syn cluster Spell add=CamelCase
endfun
autocmd BufReadPost,BufWritePost,BufNewFile *.cpp :call IgnoreCamelCaseSpell()
