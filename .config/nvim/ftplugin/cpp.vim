nmap <buffer> <silent> <leader>bt :wa<cr>:DebugLLDB<cr>

call DapMaps()

nmap <buffer> <silent> <a-o> :ClangdSwitchSourceHeader<cr>

setlocal nospell
highlight link LspComment Comment
highlight LspDeprecated term=strikethrough cterm=strikethrough gui=strikethrough
