"GuiLinespace 0

let g:my_font = 'FuraCode Nerd Font'
let g:my_fontsize = 8
call rpcnotify(1, 'Gui', 'Font', g:my_font .. ' ' .. string(g:my_fontsize))

"call rpcnotify(1, 'Gui', 'Font', 'Monospace 9')
"call rpcnotify(1, 'Gui', 'Option', 'Cmdline', 1)
"
"
"set completeopt=menuone,menu,longest,preview
"
"
