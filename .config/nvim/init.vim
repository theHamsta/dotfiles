set termguicolors     " enable true colors support

if has("win32")
  luafile ~/AppData/Local/nvim/packages.lua
  luafile ~/AppData/Local/nvim/lua/init.lua
else
  luafile ~/.config/nvim/packages.lua
  luafile ~/.config/nvim/lua/init.lua
end

let g:unstack_mapkey='<leader><F10>'
let g:dropbar=0
set tags=./tags,tags
set encoding=UTF-8

set nocompatible               " Be iMproved
set path=.,./debug,../release,/usr/local/include,/usr/include

set conceallevel=2
""let g:tex_conceal='abdmg'
let g:tex_flavor='latex'
noremap <expr> n 'Nn'[v:searchforward]
noremap <expr> N 'nN'[v:searchforward]

set wildignore+=tags,*.fasl,_minted-*,*.egg-info,tmp,*.so,*.swp,*.zip,*.log,*/CMakeFiles/*,*.aux,*.lof,*.lot,*.gz,*.fls,*.fdb_latexmk,*.toc,__*__,*[0-9]+,*.class,*.bak?,*.bak??,*.md5,*.snm,*.bbl,*.nav,*.out,*.run.xml,*.bcf,*.blg,*.auxlock,*.dvi,*.glo,*.glg,*.ist
set wildmode=longest:full,full

set lazyredraw
set ttyfast
set smartcase
set diffopt+=linematch:60
let g:paredit_leader=','
let g:rooter_patterns = ['gitmodules', '.git', '.git/']

let g:vim_bootstrap_langs = "c,python"
let g:vim_bootstrap_editor = "nvim"             " nvim or vim
"let g:fzf_command_prefix = 'fzf'
let g:sexp_insert_after_wrap = 0

map <SPACE> <leader>
map <space><space>f  :HopFunctions<cr>
map <space><space>w :HopWord<cr>
map <space><space>j :HopLineAC<cr>
map <space><space>k :HopLineBC<cr>

set history=10000
set splitbelow
set splitright
set smartcase
set ignorecase
set spell
set spelloptions=camel
set bufhidden=hide
set signcolumn=yes
set noshowmode
set noshowcmd
set joinspaces
set shortmess+=c
set sidescroll=1
set nobackup

let g:use_line_numbers=0

if g:use_line_numbers
  set number
  set relativenumber
endif

function! Toggle_line_numbers()
       windo set number!
       windo set relativenumber!
endfunction
command! LineNumbers call Toggle_line_numbers()
command! ToggleLineNumbers call Toggle_line_numbers()

nnoremap <leader>w :wa<cr>
nnoremap <leader>make :wa<Cr>:Neomake!<cr>
nnoremap <leader>line :call Toggle_line_numbers()<cr>
nnoremap <leader>hi :History<Cr>
nnoremap <leader>so :w<cr>:source %<cr>
nnoremap <leader>lime :Limelight!! 0.8<cr>
vnoremap < <gv
vnoremap > >gv
nnoremap Y y$
nnoremap y "+y
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
command! Wq :wq
command! Wqa :wqa
nnoremap <C-S-J> :m+<CR>==
nnoremap <C-S-K> :m-2<CR>==
nnoremap <c-w>O :tab :sp<cr>
nnoremap <c-w>C <c-w>c<c-w>c<c-w>c

nnoremap <Leader>cn :cn<cr>
nnoremap <Leader>cN :cN<cr>
nnoremap <Leader>sde :set spell<cr>:set spelllang=de<cr>
nnoremap <Leader>sen :set spell<cr>:set spelllang=en<cr>

nnoremap <Leader>bp :bN<cr>
nnoremap <Leader>bn :bn<cr>
nnoremap <Leader>tab :tabnew<cr>
nnoremap <Leader>tc :tabclose<cr>
nnoremap <Leader>oo :only<cr>

noremap <silent> <leader><C-k> :lprevious<cr>
noremap <silent> <leader><C-j> :lnext<cr>
noremap <silent> <c-k> :cprevious<cr>
noremap <silent> <c-j> :cnext<cr>
nmap <leader>bl :BLines<cr>

set nowrap
set linebreak
set nolist  " list disables linebreak
filetype plugin indent on
filetype plugin on
set shiftwidth=4

inoremap <c-V> <C-R><C-R>+
cnoremap <c-V> <C-R>+
nnoremap p "+p
nnoremap P "+P

inoremap jk <Esc>
smap <c-n> <Esc>a<tab>
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      :T cargo build --release
    else
      :T cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

let g:vimtex_complete_enabled = 0
set isfname -==

nnoremap <Leader>DO :diffoff!<CR>
nnoremap <Leader>dp :dp<CR>
nnoremap <Leader>do :do<CR>
nnoremap <Leader>dg :diffget<CR>
nnoremap <Leader>dt :diffthis<CR>

nmap <Leader>gs :G<CR>
nmap <Leader>gS :Git ministatus<CR>
nmap <Leader>ga :Gwrite<CR>
nmap <c-a-b> :Git blame<CR>
nmap <Leader>res:Git reset<CR>
nmap <Leader>me :MerginalToggle<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gc :Git commit -v<CR>
nmap <Leader>am :Git commit -v --amend<CR>
nmap <Leader>gh :Gvsplit :%<left><left>
nmap <Leader>gH :call GetOtherVersionAtSameLine('')<left><left>
nmap <Leader>g< :call GoPreviousCommit()<cr>
nmap <Leader>g> :call GoNextCommit()<cr>
nmap <C-Home> :call GoToCurrentCommit()<cr>
nmap <C-PageDown> :call GoPreviousCommit()<cr>
nmap <C-PageUp> :call GoNextCommit()<cr>
nmap <Leader>gv :GV<CR>
nmap <Leader>gu :Git reset -- %<CR>
nmap <Leader>gd <c-w>O:Gdiff<CR>
nmap <Leader>gD <c-w>O:Gvdiffsplit :%<left><left>
nmap <Leader>gr :Gread<CR>:w<cr>
nmap <Leader>gp :GitPushAsync<CR>
nmap <Leader>gP :GitPushAsyncForce<CR>
nmap <Leader>gl :Git pull<CR>
vnoremap // y/<C-R>"<CR>


nnoremap <silent> <F3> <c-w>o:Tkill<cr>:Topen<cr>:wa<cr>:exec 'T ' . g:last_execution<cr>
nnoremap <silent> <s-F3> :Tkill<cr>:wa<cr>:exec 'T ' . g:last_execution<cr>
""
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <s-F6> <c-w>o:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just clean<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <F7> <c-w>o:Topen<cr>:Tclear<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just release-run<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <s-F7> <c-w>o:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just release<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <F6> <c-w>o:Topen<cr>:Tclear<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just build<cr>
autocmd FileType java,kotlin,groovy nnoremap <buffer> <F5> <c-w>o:Topen<cr>:let g:last_execution='./gradlew run'<cr>:Tkill<cr>:wa<cr>:T ./gradlew run<cr>
autocmd FileType java,kotlin,groovy nnoremap <buffer> <F6> <c-w>o:Topen<cr>:let g:last_execution='./gradlew test'<cr>:Tkill<cr>:wa<cr>:T ./gradlew test<cr>
autocmd FileType tex,latex nnoremap <buffer> <F3> val<plug>(vimtex-compile-selected)
autocmd FileType tex,latex nnoremap <buffer> <F4> :VimtexCompileSS<cr>
autocmd FileType xml setlocal foldmethod=indent
autocmd FileType rust,toml nmap <buffer> <F7> :exec 'T cd' FindRootDirectory()<cr><c-w>o:Tkill<cr>:wa<cr>:T cargo run
autocmd FileType rust,toml nmap <buffer> <F4> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let g:last_execution='cargo build'<cr>:Tkill<cr>:Topen<cr>:wa<cr>:T cargo build<cr>:Topen<cr>
autocmd FileType rust,toml nmap <buffer> <F6> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let g:last_execution='cargo test -- --nocapture'<cr>:Tkill<cr>:Topen<cr>:wa<cr>:T cargo test -- --nocapture<cr>
autocmd FileType rust nmap <silent> <leader>tn :wa<cr>:RustTest<cr>
autocmd FileType rust nmap <silent> <leader>tN <c-w>o:wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestNearest -- --nocapture<CR>


autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

if has("win32")
  if isdirectory("F:\\dev")
    nmap <c-a-p> :cd F:\dev<cr>:Files<cr>
    nmap <space><c-p> :cd F:\dev<cr>:Files<cr>
  elseif isdirectory("C:\\Users\\admin\\projects")
    nmap <c-a-p> :cd C:\Users\admin\projects<cr>:Files<cr>
    nmap <space><c-p> :cd C:\Users\admin\projects<cr>:Files<cr>
  else
    nmap <c-a-p> :cd C:\dev<cr>:Files<cr>
    nmap <space><c-p> :cd C:\dev<cr>:Files<cr>
  endif
else
    nmap <c-a-p> :cd ~/projects<cr>:Files<cr>
    nmap <space><c-p> :cd ~/projects<cr>:Files<cr>
end
nmap <a-p> :Buffers<cr>
nnoremap <a-g> :GFiles?<cr>
nmap <leader>gg :GF?<cr>
"autocmd FileType lua nnoremap <buffer> <c-s> ma:w<cr>:!stylua %<cr>:e!<cr>'azz

"autocmd FileType cmake nnoremap <buffer> <c-s> ma:w<cr>:%!gersemi %<cr>'azz
autocmd FileType markdown nnoremap <buffer> <cr> :ComposerStart<cr>:ComposerOpen<cr>
autocmd FileType markdown nnoremap <buffer> <leader>ll :ComposerStart<cr>
autocmd FileType markdown nnoremap <buffer> <leader>lv :ComposerOpen<cr>
"" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand('$HOME/.cache' . '/undodir')
    " Create dirs
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

nnoremap <silent> <leader>ld <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> <leader>lD <cmd>lua vim.diagnostic.setqflist()<CR>
nnoremap <silent> [d <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> äk <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> äj <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>ll <cmd>lua vim.diagnostic.config({ virtual_lines = true, virtual_text = false })<CR>
nnoremap <silent> <leader>LL <cmd>lua vim.diagnostic.config({ virtual_lines = false, virtual_text = true })<CR>
nnoremap <silent> <leader>dz <cmd>Neotree diagnostics reveal bottom<cr>

function! NvimLspMaps()
  lua NvimLspMaps()
    Lazy load fidget.nvim
    nnoremap <buffer><silent> <f2>         <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <buffer><silent> gk         <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <buffer><silent> gR         <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <buffer> <silent> gd       <cmd>lua vim.lsp.buf.definition()<CR>
    nmap <buffer> <silent> gD  <c-w>vgd
    nnoremap <buffer><silent> gh         <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer><silent> <leader>gi         <cmd>lua vim.lsp.buf.implementation()<CR>
    inoremap <buffer><silent> <c-g>         <cmd>lua vim.lsp.buf.signature_help()<CR>
    "nnoremap <buffer><silent> <leader>lD <cmd>lua vim.diagnostic.setloclist()<CR>
    nnoremap <buffer><silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <buffer><silent> <leader>ic <cmd>lua vim.lsp.buf.incoming_calls()<CR>
    vnoremap <buffer><silent> <leader>oc <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
    nnoremap <buffer><silent> <leader>ss :lua vim.lsp.buf.workspace_symbol()<cr>
    nnoremap <buffer><silent> <leader>de :lua require'lsp-ext'.peek_definition()<cr>
    nnoremap <buffer> <silent> <2-LeftMouse> <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <silent> <c-LeftMouse> <cmd>lua require'nvim-treesitter.refactor.navigation'.goto_definition_lsp_fallback()<CR>
    nnoremap <buffer> <silent> <c-LeftMouse> <cmd>lua vim.lsp.buf.definition()<CR>

    nnoremap <buffer> <silent> üf <cmd>packadd lspsaga<cr><cmd>Lspsaga lsp_finder<cr>

    nnoremap <silent> <leader>fi <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
        nnoremap <buffer> <c-a-o> :Telescope lsp_document_symbols<cr>
        nnoremap <buffer> <leader><c-o> :Telescope lsp_document_symbols<cr>
    command! CodeLens autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    nnoremap <buffer><silent> <leader>gt    <cmd>lua vim.lsp.buf.type_definition()<CR>

    if &filetype == "java" 
        "nnoremap <buffer><silent> <c-s> :w<cr><cmd>lua vim.lsp.buf.formatting();require'jdtls'.organize_imports()<cr>
    elseif &filetype == "lua" 
      nnoremap <buffer><silent> <c-s> <cmd>lua require'conform'.format()<cr>:w<cr>
    else 
        nnoremap <buffer><silent> <c-s> :w<cr><cmd>lua vim.lsp.buf.format({async = true})<cr>
    endif

    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endfunction


set foldlevel=99

set colorcolumn=120


command! Q :q
command! Qa :qa

noremap <end> <c-w>o:Topen<cr><c-w>wi

let test#strategy = "neoterm"
let g:neoterm_autoinsert=0
let g:neoterm_autoscroll=1
let g:neoterm_fixedsize =100
let g:neoterm_default_mod='vert'
augroup terminal
    autocmd TermOpen * setlocal bufhidden=hide
    "autocmd TermOpen * set syntax=cpp
    autocmd TermOpen * setlocal nospell
    "autocmd TermOpen * nmap <silent> <buffer> <c-d> :bd!<cr>:q<cr>
augroup END


nnoremap <a-t> :Switch<CR>
let g:rainbow_active = 0

set clipboard=unnamedplus

function! GotoPython()
    let current_line = getline('.')
    let goto_file = matchstr(current_line, '\(File "\)\@<=\(.*\)\("\)\@=')
    let goto_line = matchstr(current_line, '\(line \)\@<=[0-9]*')
    execute "tabedit +" . goto_line . " " . goto_file
endfunction

nnoremap <silent> gP :call GotoPython()<cr>


let g:slime_target = "neovim"

nnoremap <leader>ag :Ag<cr>
nnoremap <leader>rg :Rg<cr>
let g:LanguageClient_diagnosticsList = "Location"
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_exit_from_visual_mode=0

let g:rooter_silent_chdir = 1

nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> 10gt
set updatetime=100

let g:license="GPLv3"
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual


nnoremap <c-p> :Files<CR>
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

let g:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction

augroup filetypedetect
    au! BufRead,BufNewFile *.osl set filetype=cpp
    au! BufRead,BufNewFile *.slang set filetype=shaderslang
    au! BufRead,BufNewFile *.sdp,*.SDP set filetype=sdp
    au! BufRead,BufNewFile *.gstlaunch set filetype=gstlaunch
    au! BufRead,BufNewFile *.nvmk set filetype=make
    au! BufRead,BufNewFile .busted set filetype=lua
    au! BufRead,BufNewFile *.proto2,*.proto, *.proto3 set filetype=proto
    au! BufRead,BufNewFile *.nim set filetype=nim
    au! BufRead,BufNewFile *.nu set filetype=nu
    au! BufRead,BufNewFile *.ny set filetype=scheme
    au! BufRead,BufNewFile .gitignore set filetype=gitignore
    au! BufRead,BufNewFile *.hlsli,*.hlsl,*.effect set filetype=hlsl
    au! BufRead,BufNewFile *.wgsl set filetype=wgsl
    au! BufRead,BufNewFile *.slint set filetype=slint
    au! BufRead,BufNewFile *.ll set filetype=llvm
    au! BufRead,BufNewFile *.cpp.tmpl set filetype=cpp
    au! BufRead,BufNewFile *.cui set filetype=cuda
    au! BufRead,BufNewFile *.fs,*.fsx set filetype=fsharp
    au! BufRead,BufNewFile *.fsproj,*.csproj,*.target,*.sln set filetype=xml
    au! BufRead,BufNewFile *.pdf_tex set filetype=tex
    au! BufRead,BufNewFile .justfile,justfile set filetype=make
    au! BufRead,BufNewFile *.tikz set filetype=tex
    au! BufRead,BufNewFile *.spirv set filetype=spirv
    au! BufRead,BufNewFile *.jl set filetype=julia
    au! BufRead,BufNewFile german.tex set spelllang=de
    au! BufRead,BufNewFile *.svelte set filetype=svelte
    au! BufRead,BufNewFile *.asd,.spacemacs set filetype=lisp
    au! BufRead,BufNewFile *.class set filetype=java
    au! BufRead,BufNewFile *.tl set filetype=teal
    au! BufRead,BufNewFile .luacheckrc set filetype=lua
    au! BufRead,BufNewFile *.fish set filetype=fish
    au! BufRead,BufNewFile *.v set filetype=v
    au! BufRead,BufNewFile *.zig set filetype=zig
    au! BufRead,BufNewFile Dockerfile.*,dockerfile.*,*.docker set filetype=dockerfile
    au! BufRead,BufNewFile Earthfile set filetype=Earthfile
    au! BufRead,BufNewFile build.earth set filetype=Earthfile
    au! BufRead,BufNewFile build.earth set filetype=Earthfile
    au! BufRead,BufNewFile *.vert,*.frag,*.comp,*.rchit,*.rmiss,*.rahit set filetype=glsl
augroup END

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sh', 'cpp', 'rust', 'java', 'go', 'lua', 'vim', 'lisp']
let g:vim_markdown_math = 1

let g:deoplete#enable_at_startup = 0
let g:lt_location_list_toggle_map = '<leader>ql'
let g:lt_quickfix_list_toggle_map = '<leader>qe'
nmap <leader>ch :Cheat! 


let g:netrw_browsex_viewer='xdg-open'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>n <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

set completeopt=menuone,menu,longest,noselect,noinsert
 autocmd FileType json syntax match Comment +\/\/.\+$+

  sign define DiagnosticSignError text=❌ texthl=LspDiagnosticsError linehl= numhl=
  sign define DiagnosticSignWarn text=⚠️ texthl=LspDiagnosticsWarning linehl= numhl=
  sign define DiagnosticSignInfo text=🔎 texthl=LspDiagnosticsInformation linehl= numhl=
  sign define DiagnosticSignHint text=💡 texthl=LspDiagnosticsHint linehl= numhl=

  let g:gitgutter_sign_added = '▋'
  let g:gitgutter_sign_modified = '▐'
  let g:gitgutter_sign_removed = '▋'
  let g:gitgutter_sign_removed_first_line = '▋'
  let g:gitgutter_sign_modified_removed = '▐_'

nmap <silent> <leader>tn :wa<cr>:Topen<cr>:TestNearest<CR>
nmap <silent> <leader>tf :wa<cr>:Topen<cr>:TestFile<CR>
nmap <silent> <leader>ts :wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestSuite<CR>
nmap <silent> <leader>tl <c-w>o:wa<cr>:Tkill<cr>:Topen<cr>:TestLast<CR>
nmap <silent> <leader>tL :wa<cr>:Tkill<cr>:Topen<cr>:TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

let maplocalleader = ','


if has('nvim')
  set wildoptions=pum
  set pumblend=20
endif

let g:UltiSnipsEnableSnipMate=1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

if has("win32") == 0
  autocmd BufReadPre *.pdf silent set ro
  autocmd BufReadPre *.pdf silent :T okular "%"
  autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
  autocmd BufReadPre *.png silent %!xdg-open "%"
  autocmd BufReadPre *.eps silent %!xdg-open "%"
  autocmd BufReadPre *.jpg silent %!xdg-open "%"
  autocmd BufReadPre *.bmp silent %!xdg-open "%"
  autocmd BufReadPre *.ipynb silent %!xdg-open "%"
endif

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 20
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  if height > 2 
   let opts = {
          \ 'relative': 'editor',
          \ 'row': 10,
          \ 'col': col,
          \ 'width': width,
          \ 'height': height
          \ }
    call nvim_open_win(buf, v:true, opts)
 else
   let opts = {
          \ 'relative': 'editor',
          \ 'row': 0,
          \ 'col': col,
          \ 'width': width,
          \ 'height': 10
          \ }
    call nvim_open_win(buf, v:true, opts)
  endif

  call nvim_open_win(buf, v:true, opts)
endfunction
au FileType fzf setlocal nonu nornu signcolumn=no

autocmd FileType gitcommit setlocal bufhidden=delete
autocmd FileType gitrebase setlocal bufhidden=delete

let g:email='stephan.seitz@fau.de'
let g:username='Stephan Seitz'

let g:rooter_patterns = ['.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
nnoremap <leader>JU :JustTargets<cr>
nnoremap <leader>ju :JustTargetsAsync<cr>


let g:auto_git_diff_disable_auto_update=1
let g:auto_git_diff_show_window_at_right=1

let g:LanguageClient_hoverPreview='always'

fun! RemoveTrailingWhitespaces()
    %s/\s\+$//e
endfun
command! RemoveTrailingWhitespaces call RemoveTrailingWhitespaces()
nnoremap <silent> <PageDown> :FloatermToggle<cr>
nnoremap <silent> <leader>fl :FloatermToggle<cr>
tnoremap <silent> <PageDown> <C-\><C-n>:FloatermToggle<cr>
tnoremap <silent> <leader>fl <C-\><C-n>:FloatermToggle<cr>
tnoremap <silent> jk <C-\><C-n>
tnoremap <silent> <c-d> <C-\><C-n>:bd!<cr>

if exists('g:GuiLoaded')
  let g:float_preview#docked = 1
endif

autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>
autocmd FileType * setlocal bufhidden=hide

command! Emoji %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

let g:vlime_contribs = ['SWANK-QUICKLISP', 'SWANK-ASDF', 'SWANK-PACKAGE-FU',
                      \ 'SWANK-PRESENTATIONS', 'SWANK-FANCY-INSPECTOR',
                      \ 'SWANK-C-P-C', 'SWANK-ARGLISTS', 'SWANK-REPL',
                      \ 'SWANK-FUZZY', 'SWANK-TRACE-DIALOG']

nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(-25)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(+25)<CR>

nnoremap K :s/,/,\r/g<cr>

let g:sexp_enable_insert_mode_mappings=1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

nnoremap <a-s-k> "ayy"aP
nnoremap <a-s-j> "ayy"ap

nnoremap <silent> gf gF

nnoremap Gtf :Tnew<cr>:T dolphin %:p:h 2>&1 >> /dev/null &<cr>:Tclose<cr>

command! CdToCurrentFile cd %:p:h

nnoremap <silent> <c-ScrollWheelUp> :lua require'my_gui'.increase_fontsize()<cr>
nnoremap <silent> <c-ScrollWheelDown> :lua require'my_gui'.decrease_fontsize()<cr>
nnoremap <silent> <c-0> :lua require'my_gui'.reset_fontsize()<cr>
"nnoremap <Leader>nf :Neotree filesystem reveal left<cr>
nnoremap <Leader>nt :Neotree toggle<cr>

command! GitPushAsync lua require'my_commands'.git_push()
command! GitPushAsyncForce lua require'my_commands'.git_push(true)

let g:vlime_leader='<space>'
let g:vlime_cl_use_terminal=v:true
let g:vlime_enable_autodoc = v:true
let g:vlime_window_settings = {'sldb': {'pos': 'belowright', 'vertical': v:true}, 'inspector': {'pos': 'belowright', 'vertical': v:true}, 'preview': {'pos': 'belowright', 'size': v:null, 'vertical': v:true}}

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
au TextYankPost * silent! lua require'vim.highlight'.on_yank({"IncSearch", 150})


let g:sexp_filetypes = 'clojure,scheme,lisp,timl,vlime_repl,fennel,query'
let g:sexp_enable_insert_mode_mappings = 0

let g:markdown_composer_autostart=0

nnoremap <c-h> :History<cr>
nnoremap <c-t> :Tags<cr>
nnoremap <c-s-t> :Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <c-a-o> :BTags<cr>
nnoremap <leader><c-o> :BTags<cr>

command! -buffer JdtCompile lua require('jdtls').compile()
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()

nnoremap <leader>bd :Bdelete<cr>

function DapMaps()
    nnoremap <f1> :lua require'dap'.goto_()<cr>
    nnoremap <buffer> <silent> <F4> :lua require'dap.repl'.toggle()<CR>
    nnoremap <buffer> <silent> <F5> :lua require'dap'.continue()<CR>
    nnoremap <buffer> <silent> <s-F5> :lua require'dap'.run_to_cursor()<CR>
    nnoremap <buffer> <silent> <F9> :lua require'dap'.step_over()<CR>
    nnoremap <buffer> <silent> <s-F9> :lua require'dap'.focus_frame()<CR>
    nnoremap <buffer> <silent> <F10> :lua require'dap'.step_into()<CR>
    nnoremap <buffer> <silent> <F11> :lua require'dap'.step_out()<CR>

    nmap <buffer> <silent> <leader>bb :lua require'dap'.toggle_breakpoint()<CR>
    nmap <buffer> <silent> <leader>bB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nmap <buffer> <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log message: '))<CR>
    nmap <buffer> <silent> <leader>br :lua require'dap'.restart()<CR>
    nmap <buffer> <silent> <leader>bn :lua require'dap'.step_over()<CR>
    nmap <buffer> <silent> <leader>bi :lua require'dap'.step_into()<CR>
    nmap <buffer> <silent> <leader>bo :lua require'dap'.step_out()<CR>
    nmap <buffer> <silent> <leader>lb :lua require'dap'.list_breakpoints()<CR>
    nmap <buffer> <silent> <leader>dh :lua require 'dap.ui.widgets'.hover()<cr>
    nmap <buffer> <silent> <leader>ds :lua require 'dap.ui.widgets'.centered_float(require 'dap.ui.widgets'.scopes)<cr>
    nmap <buffer> <silent> <leader>df :lua require 'dap.ui.widgets'.frames()<cr>
    nmap <buffer> <silent> <leader>TN :lua require'dap';require 'dap-python'.test_method()<cr>:lua require 'dap.repl'.open()<cr>
    nmap <buffer> <silent> <leader>bT :lua require 'dap'.run_last()<cr>:lua require 'dap.repl'.open()<cr>
    command! ExceptionBreakpoints :lua require'dap'.set_exception_breakpoints()<cr>
endfunction

nmap <silent> <leader>sf :lua require'telescope'.extensions.dap.frames{}<CR>

nnoremap <F8> :TagbarOpenAutoClose<CR>
nmap ,w ysiw)
nmap ,<s-w> ysiW)

"nnoremap <leader>pl :lua vim.treesitter.inspect_tree()<cr>
nnoremap <leader>pl :TSPlaygroundToggle<cr>

autocmd BufEnter,BufNewFile *.vh set filetype=verilog
autocmd BufEnter,BufNewFile *.verilog set filetype=verilog
autocmd BufEnter,BufNewFile *.org set filetype=org


    "g:echodoc#type
nmap <leader>qf  :lua require'telescope.builtin'.quickfix()
command TreeGrep  :lua require'telescope.builtin'.treesitter()
let g:NERDCustomDelimiters = { 'lisp': { 'left': '#|','right': '|#' },'query': { 'left': ';','right': '' }, 'fsharp': { 'left': '//','right': '' }}
let g:neovide_cursor_vfx_mode = "railgun"
let g:neovide_cursor_animation_length = 0.05
let g:neovide_position_animation_length = 0.05
"let g:neovide_cursor_vfx_mode = "wireframe"

autocmd BufReadPre,FileReadPre *.spirv setlocal bin
autocmd BufReadPost,FileReadPost *.spirv call spirv#disassemble()

" Set autocommands to assemble SPIR-V binaries on write
autocmd BufWriteCmd,FileWriteCmd *.spirv call spirv#assemble()

command! OpenDiagnostic :lua vim.lsp.diagnostic.set_loclist()<cr>

if exists('g:fvim_loaded')
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif



let g:sneak#label = 1
let g:AutoPairsShortcutToggle = '<M-m>'
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

let g:completion_enable_auto_popup = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case = 1
highlight def link LspDiagnosticsUnderlineError Error
highlight def link LspDiagnosticsUnderlineWarning LspWarning
highlight def link LspDiagnosticsVirtualTextError Error
highlight def link LspDiagnosticsVirtualTextWarning LspWarning

let g:completion_trigger_keyword_length = 2 " default = 1

vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv
nnoremap K :s/,/,\r/g<cr>
vnoremap K :s/,/,\r/g<cr>
nnoremap <silent> <leader>ng :Neogit kind=split<cr>

au FileType dap-repl lua require('dap.ext.autocompl').attach()

nnoremap <leader>sy :lua require "telescope.builtin".symbols {sources = {"emoji", "kaomoji", "math", "latex"}}<cr>
nnoremap <ins> :next<cr>
nnoremap <del> :previous<cr>

highlight DapStopped guibg=#000099
highlight DapBreakpoint guibg=#661111

highlight ColorColumn ctermbg=0 guibg=lightgrey

hi def semshiLocal           ctermfg=209 guifg=#ff875f
hi def semshiGlobal          ctermfg=214 guifg=#ffaf00
hi def semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
hi def semshiParameter       ctermfg=75  guifg=#5fafff
hi def semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
hi def semshiFree            ctermfg=218 guifg=#ffafd7
hi def semshiBuiltin         ctermfg=207 guifg=#ff5fff
hi def semshiAttribute       ctermfg=49  guifg=#00ffaf
hi def semshiSelf            ctermfg=249 guifg=#b2b2b2
hi def semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
hi def semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

hi def semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
hi def semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000

autocmd ColorScheme * highlight NvimDapStopped guibg=#000055

autocmd ColorScheme * highlight default link TSDefinitionUsage Visual
autocmd ColorScheme * highlight link LspComment Comment

autocmd ColorScheme * highlight default link TSDefinition Search
autocmd ColorScheme * highlight default link TSCurrentScope CursorLine

nnoremap <silent> X :normal! x<cr>
noremap <silent> <leader>tb :Tagbar<cr>

command! Tokyo let g:tokyonight_style = "night" | colorscheme tokyonight
command! TokyoStorm  let g:tokyonight_style = "storm" | colorscheme tokyonight
command! TokyoDay  let g:tokyonight_style = "day" | colorscheme tokyonight
command! Nightfly :packadd vim-nightfly-guicolors | colorscheme nightfly
command! Moonfly colorscheme moonfly
command! OneDark colorscheme one
command! OhLucy colorscheme oh-lucy
command! RosePine colorscheme rose-pine

nnoremap <leader>nd :DiffviewOpen<cr>

autocmd FileType cpp set commentstring=//\ %s

nmap <leader>tt <Plug>PlenaryTestFile

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>os <cmd>OverseerRun<cr>
nnoremap <leader>ol <cmd>OverseerToggle<cr>

let g:copilot_node_command = "/usr/bin/node"

highlight @deprecated term=strikethrough cterm=strikethrough gui=strikethrough
highlight default link @injected None 
onoremap <silent> m :<C-U>lua require('tsht').nodes()<CR>
xnoremap <silent> m :lua require('tsht').nodes()<CR>
nnoremap <leader>SS <cmd>lua require('sg.telescope').fuzzy_search_results()<CR>

let g:query_lint_on = ["InsertLeave", "BufEnter", "TextChanged"]


colorschem tundra
lua vim.api.nvim_set_hl(0, "LspInlayHint", {link = "Comment"})
