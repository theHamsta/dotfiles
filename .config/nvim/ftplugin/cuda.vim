nmap <buffer> <silent> <leader>bt :wa<cr>:DebugLLDB<cr>

call DapMaps()

nmap <buffer> <silent> <a-o> :ClangdSwitchSourceHeader<cr>

setlocal nospell
highlight link LspComment Comment
highlight link LspMacro Macro
highlight link LspType Type
highlight link LspClass Type
highlight link LspParameter Identifier
highlight link LspProperty Identifier
highlight link LspMethod Identifier
highlight link LspFunction Function
highlight LspDeprecated term=strikethrough cterm=strikethrough gui=strikethrough
