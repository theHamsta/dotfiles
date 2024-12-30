vim.cmd [[
call DapMaps()

highlight link LspComment Comment
highlight link LspMacro Macro
highlight link LspType Type
highlight link LspClass Type
highlight link LspParameter Identifier
highlight link LspProperty Identifier
highlight link LspMethod Function
highlight link LspFunction Function
highlight LspDeprecated term=strikethrough cterm=strikethrough gui=strikethrough
highlight link cppLspVariableReadOnly Constant
highlight cppLspGlobalScope guibg=#773244 " #444422
]]
