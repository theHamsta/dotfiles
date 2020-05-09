set conceallevel=0
command! TexlabBuild lua require'nvim_lsp'.texlab.buf_build(0)


" Disable overfull/underfull \hbox and all package warnings
let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \ 'packages' : {
      \   'default' : 1,
      \ },
      \}

nnoremap <buffer> ,lv :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>
nnoremap <buffer> <cr> :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>
nnoremap <buffer> <c-cr> :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>

nnoremap ,lc :VimtexCompile<cr>
nnoremap <leader>zen :Goyo<cr>
nnoremap <leader>buf :Buffers<cr>
nnoremap <leader>save :saveas

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'
let g:vimtex_view_general_options_latexmk = '--unique'
"let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'

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
