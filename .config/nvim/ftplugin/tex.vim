setlocal conceallevel=0
let g:vimtex_complete_enabled = 0
"setlocal foldmethod=indent
command! TexlabBuild lua require'nvim_lsp'.texlab.buf_build(0)



nnoremap <buffer> ,lv :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>
nnoremap <buffer> <cr> :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>
nnoremap <buffer> <c-cr> :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>

nnoremap ,lc :VimtexCompile<cr>
nnoremap <leader>zen :Goyo<cr>
nnoremap <leader>buf :Buffers<cr>
nnoremap <leader>save :saveas

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'
"let g:vimtex_compiler_progname = 'nvr'
"let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
