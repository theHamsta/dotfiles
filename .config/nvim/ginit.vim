"GuiLinespace 0

"let g:my_font = 'Hack'
"let g:my_fontsize = 9
"call rpcnotify(1, 'Gui', 'Font', g:my_font .. ' ' .. string(g:my_fontsize))
if has("win32")
    set guifont=Cascadia\ Code:h9
else
    set guifont=Hack:h9
end

""call rpcnotify(1, 'Gui', 'Font', 'Monospace 9')
""call rpcnotify(1, 'Gui', 'Option', 'Cmdline', 1)
""
""
""set completeopt=menuone,menu,longest,preview
""
""set mouse=a

"" Set Editor Font
"if exists(':GuiFont')
    "" Use GuiFont! to ignore font errors
    "GuiFont Hack:h9
"endif

"" Disable GUI Tabline
"if exists(':GuiTabline')
    "GuiTabline 1
"endif

"" Disable GUI Popupmenu
"if exists(':GuiPopupmenu')
    "GuiPopupmenu 1
"endif

"" Enable GUI ScrollBar
"if exists(':GuiScrollBar')
    "GuiScrollBar 1
"endif

"" Right Click Context Menu (Copy-Cut-Paste)
"nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
"inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
"vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv


"if exists(':GuiTreeviewToggle')
  "nnoremap <Leader>nf :GuiTreeviewToggle<cr>
"endif
