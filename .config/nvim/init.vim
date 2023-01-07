set termguicolors     " enable true colors support
set background=dark 
"packadd github-nvim-theme | colorscheme github_dark_default
"packadd onedarkpro.nvim | colorscheme onedark
"colorscheme one
packadd tokyonight.nvim | let g:tokyonight_style = "storm" | colorscheme tokyonight

let g:unstack_mapkey='<leader><F10>'
set tags=./tags,tags
set encoding=UTF-8

set nocompatible               " Be iMproved
set path=.,./debug,../release,/usr/local/include,/usr/include

set conceallevel=2
""let g:tex_conceal='abdmg'
let g:tex_flavor='latex'


"set wildignore+=tags,_minted-*,*.egg-info,tmp,*.so,*.swp,*.zip,*.log,*/CMakeFiles/*,*.aux,*.lof,*.lot,*.gz,*.fls,*.fdb_latexmk,*.toc,__*__,*/pybind11/*,*[0-9]+,*.class,*.bak?,*.bak??,*.md5,*.snm,*.bbl,*.nav,*.out,*.run.xml,*.bcf,*.blg,*.auxlock,*.dvi,*.glo,*.glg,*.ist
set wildignore+=tags,*.fasl,_minted-*,*.egg-info,tmp,*.so,*.swp,*.zip,*.log,*/CMakeFiles/*,*.aux,*.lof,*.lot,*.gz,*.fls,*.fdb_latexmk,*.toc,__*__,*[0-9]+,*.class,*.bak?,*.bak??,*.md5,*.snm,*.bbl,*.nav,*.out,*.run.xml,*.bcf,*.blg,*.auxlock,*.dvi,*.glo,*.glg,*.ist
set wildmode=longest:full,full

set lazyredraw
set ttyfast
set smartcase
let g:paredit_leader=','
let g:rooter_patterns = ['gitmodules', '.git', '.git/']

let g:vim_bootstrap_langs = "c,python"
let g:vim_bootstrap_editor = "nvim"             " nvim or vim
"let g:fzf_command_prefix = 'fzf'
let g:sexp_insert_after_wrap = 0

"let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
"if !filereadable(vimplug_exists)
    "if !executable("curl")
        "echoerr "You have to install curl or first install vim-plug yourself!"
        "execute "q!"
    "endif
    "echo "Installing Vim-Plug..."
    "echo ""
    "silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "let g:not_finish_vimplug = "yes"

    "autocmd VimEnter * PlugInstall
"endif
""vim-scripts/VimPdb Identify platform {
"let g:MAC = has('macunix')
"let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
"let g:WINDOWS = has('win32') || has('win64')
"" }

"" Windows Compatible {
"" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
"" across (heterogeneous) systems easier.
"if g:WINDOWS
    "set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
"endif
"" }
map <SPACE> <leader>
map <space><space>f  :HopFunctions<cr>
map <space><space>w :HopWord<cr>
map <space><space>j :HopLineAC<cr>
map <space><space>k :HopLineBC<cr>
nnoremap <space>td :cd ~/projects/norg<cr>:Neorg gtd views<cr>
map <space>td :cd ~/projects/norg<cr>:Neorg gtd views<cr>

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


autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"let g:textobj_entire_no_default_key_mappings=1

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set nonumber
  set norelativenumber
  set scrolloff=999
  lua require'my_gui'.set_fontsize(12)
  Limelight
  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  lua require'my_gui'.set_fontsize(12)
    if g:use_line_numbers
      set number
      set relativenumber
    endif
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"au WinLeave * :setlocal nonumber
"
"" " Automatically resize vertical splits.
"au WinEnter * :set winfixheight
"au WinEnter * :wincmd =

nnoremap <leader>w :wa<cr>
"nnoremap <f4> :wa<cr>:make<cr>
function! ClearQuickfixList()
      call setqflist([])
endfunction
command! ClearQuickfixList call ClearQuickfixList()
"nnoremap <f4> :ClearQuickfixList<cr>:copen<cr>:wa<cr>:Neomake!<cr>
nnoremap <leader>make :wa<Cr>:Neomake!<cr>
nnoremap <leader>line :call Toggle_line_numbers()<cr>
nnoremap <leader>hi :History<Cr>
"nnoremap <leader>te :set shell=/usr/bin/zsh<cr>:split<cr>:Tnew<Cr>:exe "resize " . 13<CR>i
nnoremap <leader>so :w<cr>:source %<cr>
nnoremap <leader>lime :Limelight!! 0.8<cr>
"nnoremap <space><space> o<Esc>
"nnoremap c "_c
"nnoremap x "_x
vnoremap < <gv
vnoremap > >gv
nnoremap Y y$
nnoremap y "+y
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
"command! W :execute ':silent w !sudo tee % > /dev/null'
command! Wq :wq
command! Wqa :wqa
nnoremap <C-S-J> :m+<CR>==
nnoremap <C-S-K> :m-2<CR>==
"inoremap <C-S-J> <Esc>:m+<CR>==gi
"inoremap <C-S-K> <Esc>:m-2<CR>==gi
"vnoremap <C-S-J> :m'>+<CR>gv=gv
"vnoremap <C-S-K> :m-2<CR>gv=gv
"inoremap  y/<C-R>"<CR>
nnoremap <c-w>O :tab :sp<cr>
nnoremap <c-w>C <c-w>c<c-w>c<c-w>c

"let &path.="/usr/include,/usr/local/include,../include,/usr/local/include/opencv2"
nnoremap <Leader>cn :cn<cr>
nnoremap <Leader>cN :cN<cr>
nnoremap <Leader>sde :set spell<cr>:set spelllang=de<cr>
nnoremap <Leader>sen :set spell<cr>:set spelllang=en<cr>

nnoremap <Leader>bp :bN<cr>
nnoremap <Leader>bn :bn<cr>
nnoremap <Leader>tab :tabnew<cr>
nnoremap <Leader>tc :tabclose<cr>
  "let g:NERDTreeShowIgnoredStatus = 1
nnoremap <Leader>oo :only<cr>
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
"nmap <silent> <C-k> [L
"nmap <silent> <C-j> ]L
"nmap <silent> <C-k> :lua vim.lsp.diagnostic.goto_prev()<cr>
"nmap <silent> <C-j> :lua vim.lsp.diagnostic.goto_next()<cr>

noremap <silent> <leader><C-k> :lprevious<cr>
noremap <silent> <leader><C-j> :lnext<cr>
noremap <silent> <c-k> :cprevious<cr>
noremap <silent> <c-j> :cnext<cr>
"nmap <silent> <C-k> [m<cr>
"nmap <silent> <C-j> ]m<cr>
nmap <leader>bl :BLines<cr>
"nmap <Leader>ag :GonvimFuzzyAg

set nowrap
set linebreak
set nolist  " list disables linebreak
filetype plugin indent on
filetype plugin on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4

"nnoremap <c-r><c-r> vap:TREPLSendSelection<cr>
"inoremap <A-v> <C-R><C-R>+
inoremap <c-V> <C-R><C-R>+
cnoremap <c-V> <C-R>+
nnoremap p "+p
nnoremap P "+P

"inoremap II <Esc>I
"inoremap AA <Esc>A
"inoremap OO <Esc>O
inoremap jk <Esc>
"vnoremap jk <Esc>
smap <c-n> <Esc>a<tab>
"smap <c-t> <Esc>a<s-tab>
"snoremap <c-u> <Esc>a<tab>
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
 
"luafile ~/.config/nvim/packages.lua

autocmd BufWritePost ~/.config/nvim/packages.lua PackerCompile

nnoremap <Leader>DO :diffoff!<CR>
nnoremap <Leader>dp :dp<CR>
nnoremap <Leader>do :do<CR>
nnoremap <Leader>dg :diffget<CR>
nnoremap <Leader>dt :diffthis<CR>

"let g:easymotion_smartcase = 1
"let g:easymotion_smartsign = 1
"map <space><space>l <Plug>(easymotion-lineforward)
"map <space><space>j <Plug>(easymotion-j)
"map <space><space>k <Plug>(easymotion-k)
"map <space><space>h <Plug>(easymotion-linebackward)

nmap <Leader>gs :G<CR>
nmap <Leader>gS :Git ministatus<CR>
nmap <Leader>ga :Gwrite<CR>
nmap <c-a-b> :Git blame<CR>
nmap <Leader>res:Git reset<CR>
nmap <Leader>me :MerginalToggle<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gc :Git commit -v<CR>
nmap <Leader>am :Git commit -v --amend<CR>
"nmap <Leader>gH :Gvsplit HEAD^1:%:@<cr>
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




" valid values: 'default' (default), 'darker', 'pure'
let g:equinusocio_material_style = 'darker'

"inoremap <expr><cr> pumvisible() ? "\<c-n>" : "\<cr>"
"packadd! base16
"colorscheme base16-atelier-dune

"packadd srcery-vim
"colorscheme srcery

nnoremap <silent> <F3> <c-w>o:Tkill<cr>:Topen<cr>:wa<cr>:exec 'T ' . g:last_execution<cr>
nnoremap <silent> <s-F3> :Tkill<cr>:wa<cr>:exec 'T ' . g:last_execution<cr>
""
"autocmd FileType cpp nnoremap <buffer> <F5> :let g:last_execution='./build/' . $target<cr>:wa<cr>:CMake<cr>:Neomake!<cr>:exec 'T' expand($g:last_exection,1)<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <s-F6> <c-w>o:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just clean<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <F7> <c-w>o:Topen<cr>:Tclear<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just release-run<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <s-F7> <c-w>o:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just release<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <F6> <c-w>o:Topen<cr>:Tclear<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just build<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm,latex,tex nnoremap <buffer> <F5> <c-w>o:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:let g:last_execution='just run'<cr>:Tkill<cr>:wa<cr>:T just run<cr>
"autocmd FileType java nnoremap <buffer> <F6> :Topen<cr>:let g:last_execution='pyconrad_run ' . expand('%:r',1)<cr>:Tkill<cr>:wa<cr>:T pyconrad_run %:r<cr>
"autocmd FileType java nnoremap <buffer> <F4> :Topen<cr>:let g:last_execution='pyconrad_run --gui ' . expand('%:r',1)<cr>:Tkill<cr>:wa<cr>:T pyconrad_run --gui %:r<cr>
autocmd FileType java,kotlin,groovy nnoremap <buffer> <F5> <c-w>o:Topen<cr>:let g:last_execution='./gradlew run'<cr>:Tkill<cr>:wa<cr>:T ./gradlew run<cr>
autocmd FileType java,kotlin,groovy nnoremap <buffer> <F6> <c-w>o:Topen<cr>:let g:last_execution='./gradlew test'<cr>:Tkill<cr>:wa<cr>:T ./gradlew test<cr>
autocmd FileType tex,latex nnoremap <buffer> <F3> val<plug>(vimtex-compile-selected)
autocmd FileType tex,latex nnoremap <buffer> <F4> :VimtexCompileSS<cr>
autocmd FileType vim,cmake,xml setlocal foldmethod=indent
"autocmd FileType tex,latex :let  maplocalleader="<space>"
autocmd FileType rust,toml nmap <buffer> <F5> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let g:last_execution='cargo run'<cr>:Tkill<cr>:wa<cr>:T cargo run<cr>:Topen<cr>
autocmd FileType rust,toml nmap <buffer> <F7> :exec 'T cd' FindRootDirectory()<cr><c-w>o:Tkill<cr>:wa<cr>:T cargo run
autocmd FileType rust,toml nmap <buffer> <F4> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let g:last_execution='cargo build'<cr>:Tkill<cr>:Topen<cr>:wa<cr>:T cargo build<cr>:Topen<cr>
autocmd FileType rust,toml nmap <buffer> <F6> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let g:last_execution='cargo test -- --nocapture'<cr>:Tkill<cr>:Topen<cr>:wa<cr>:T cargo test -- --nocapture<cr>
autocmd FileType rust nmap <silent> <leader>tn :wa<cr>:RustTest<cr>
autocmd FileType rust nmap <silent> <leader>tN <c-w>o:wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestNearest -- --nocapture<CR>


"autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

if has("win32")
    nmap <c-a-p> :cd C:\dev<cr>:Files<cr>
    nmap <space><c-p> :cd C:\dev<cr>:Files<cr>
else
    nmap <c-a-p> :cd ~/projects<cr>:Files<cr>
    nmap <space><c-p> :cd ~/projects<cr>:Files<cr>
end
nmap <a-p> :Buffers<cr>
nnoremap <a-g> :GFiles?<cr>
nmap <leader>gg :GF?<cr>
"autocmd BufRead *.prm :setfiletype prm
"" jump to the previous function
"autocmd FileType cpp nnoremap <buffer> [f :call
"\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
"" jump to the next function
"autocmd FileType cpp nnoremap <buffer> ]f :call
"\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>
""autocmd FileType cpp nnoremap <buffer> <F5> :let g:last_execution='
"":letg:last_execution=@%<cr>
""
"autocmd FileType go nmap <buffer> <c-a-p> :cd $GOPATH/src<cr>:Files<cr>
""autocmd FileType lisp nmap <buffer> <c-a-p> :cd ~/quicklisp/local-projects<cr>:Files<cr>
"autocmd FileType lisp nmap <buffer> :let maplocalleader = ','
"autocmd FileType lisp nmap <buffer> <leader>w :wa<cr>
"autocmd FileType lisp nmap <silent> <buffer> <tab> <c-x><c-o>
""autocmd FileType lisp nmap call deoplete#custom#option('auto_complete', v:false)


"autocmd FileType lisp nmap <buffer> <s-enter> <space>of
"autocmd FileType lisp nmap <silent> call vlime#plugin#InteractionMode(v:true)
"autocmd FileType clojure nmap <buffer> <enter> <Plug>(iced_eval_outer_top_list)
""

"autocmd FileType cmake SemanticHighlight
"autocmd FileType lua nnoremap <buffer> <F5> :exec '!lua' shellescape(@%:p, 1)<cr>:letg:last_execution=@%:p <cr>

"autocmd FileType lua nnoremap <buffer> <c-s> ma:w<cr>:%!luafmt --stdin --indent-count 2<cr>'azz
autocmd FileType lua nnoremap <buffer> <c-s> ma:w<cr>:!stylua %<cr>:e!<cr>'azz

autocmd FileType cmake nnoremap <buffer> <c-s> ma:w<cr>:%!gersemi %<cr>'azz
"autocmd FileType tex,latex nnoremap <buffer> <c-s> :w<cr>:silent !latexindent % -w<cr>:e<cr>
""autocmd FileType tex,latex call neomake#configure#automake('w')
""autocmd FileType rst call neomake#configure#automake('w')
"autocmd FileType tex,latex nnoremap <buffer> <c-a-o> :call vimtex#fzf#run()<cr>
autocmd FileType markdown nnoremap <buffer> <cr> :ComposerStart<cr>:ComposerOpen<cr>
autocmd FileType markdown nnoremap <buffer> <leader>ll :ComposerStart<cr>
autocmd FileType markdown nnoremap <buffer> <leader>lv :ComposerOpen<cr>
"autocmd FileType markdown <buffer> set conceallevel=1

"autocmd FileType bib command! Format normal :w<cr>:silent !latexindent % -w<cr>:e<cr>
""<cr>:e

"let g:ag_working_path_mode="r"


"" Put plugins and dictionaries in this dir (also on Windows)
"let &runtimepath.=','.vimDir

"" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand('$HOME/.cache' . '/undodir')
    " Create dirs
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif


    ""\ 'clojure': ['clojure-lsp'],
    ""\ 'rust': ['rls'],
    "\ 'rust': ['rust-analyzer'],
let g:LanguageClient_serverCommands = {
    \ 'kotlin': ['kotlin-language-server', '.'],
    \ 'dockerfile': ['docker-langserver', '--stdio'],
    \ 'd': ['dls'],
    \ 'crystal': ['/home/stephan/projects/scry/scry/bin/scry'],
    \ 'gluon': ['gluon_language-server'],
    \ 'cmake': ['cmake-language-server'],
    \ }
    "\ 'zig': ['zls'],
    "\ 'haskell': ['hie-wrapper', '--lsp'],
    "\ 'fsharp': ['dotnet', expand('~').'.local/share/nvim/site/pack/packer/opt/fsharp-language-server/bin/Release/netcoreapp3.0/target/FSharpLanguageServer.dll']
    "\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
    "\       using LanguageServer;
    "\       using Pkg;
    "\       import StaticLint;
    "\       import SymbolServer;
    "\       env_path = dirname(Pkg.Types.Context().env.project_file);
    "\       debug = false;
    "\
    "\       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
    "\       server.runlinter = true;
    "\       run(server);
    "\   '],
    "\ 'python': ['/home/linuxbrew/.linuxbrew/bin/pyright-langserver'],
    "\ 'python': ['pyls', '--log-file', '/tmp/pylslog'],
    "\ 'go': ['gopls'],
    "\ 'lisp': ['~/.roswell/bin/cl-lsp']
    "\ 'cuda': ['clangd-11', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes'],
    "\ 'cpp': ['clangd-11', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes'],
    "\ 'c': ['clangd-11', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes'],

function! NvimLspMaps()
    nnoremap <buffer><silent> <f2>         <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <buffer><silent> gk         <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <buffer><silent> gR         <cmd>lua vim.lsp.buf.references()<CR>
  "nnoremap <buffer> <silent> gd       <cmd>lua require'nvim-treesitter.refactor.navigation'.goto_definition_lsp_fallback()<CR>
    nnoremap <buffer> <silent> gd       <cmd>lua vim.lsp.buf.definition()<CR>
    "nnoremap <buffer> <silent> gd       <cmd>requiredefinition()<CR>
 "<cmd>lua vim.lsp.buf.definition()<CR>
    nmap <buffer> <silent> gD  <c-w>vgd
    nnoremap <buffer><silent> gh         <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer><silent> <leader>gi         <cmd>lua vim.lsp.buf.implementation()<CR>
    inoremap <buffer><silent> <c-g>         <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <buffer><silent> <leader>ld <cmd>lua vim.diagnostic.open_float()<CR>
    nnoremap <buffer><silent> <leader>lD <cmd>lua vim.diagnostic.setqflist()<CR>
    "nnoremap <buffer><silent> <leader>lD <cmd>lua vim.diagnostic.setloclist()<CR>
    nnoremap <buffer><silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <buffer><silent> <leader>ic <cmd>lua vim.lsp.buf.incoming_calls()<CR>
    vnoremap <buffer><silent> <leader>oc <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
    nnoremap <buffer><silent> <leader>ss :lua vim.lsp.buf.workspace_symbol()<cr>
    nnoremap <buffer><silent> <leader>de :lua require'lsp-ext'.peek_definition()<cr>
    nnoremap <buffer> <silent> <2-LeftMouse> <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <silent> <c-LeftMouse> <cmd>lua require'nvim-treesitter.refactor.navigation'.goto_definition_lsp_fallback()<CR>
    nnoremap <buffer> <silent> <c-LeftMouse> <cmd>lua vim.lsp.buf.definition()<CR>

    nnoremap <buffer> <silent> [d <cmd>lua vim.diagnostic.goto_prev()<CR>
    nnoremap <buffer> <silent> ]d <cmd>lua vim.diagnostic.goto_next()<CR>
    nnoremap <buffer> <silent> äk <cmd>lua vim.diagnostic.goto_prev()<CR>
    nnoremap <buffer> <silent> äj <cmd>lua vim.diagnostic.goto_next()<CR>
    nnoremap <buffer> <silent> <leader>hd <cmd>lua vim.diagnostic.config({ virtual_lines = true, virtual_text = false })<CR>
    nnoremap <buffer> <silent> <leader>hD <cmd>lua vim.diagnostic.config({ virtual_lines = false, virtual_text = true })<CR>
    nnoremap <buffer> <silent> <leader>dz <cmd>Neotree diagnostics reveal bottom<cr>
    nnoremap <buffer> <silent> üf <cmd>Lspsaga lsp_finder<cr>

    ""nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<cr>
    ""nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
    ""nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
    nnoremap <silent> <leader>fi <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
"|| &filetype == "cpp" || &filetype == "cuda" || &filetype == "c"
    "if &filetype == "rust" 
        "autocmd BufEnter,CursorHold,InsertLeave <buffer> lua require 'vim.lsp.buf'.semantic_tokens_full()
        nnoremap <buffer> <c-a-o> :Telescope lsp_document_symbols<cr>
        nnoremap <buffer> <leader><c-o> :Telescope lsp_document_symbols<cr>
    "endif
    "if &filetype != "tex" && &filetype != "haskell"
        "inoremap <buffer><silent> (     <cmd>lua vim.lsp.buf.signature_help()<CR>(
    "endif

    "if &filetype == "rust" || &filetype == "go"
      "autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    "endif
    command! CodeLens autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    nnoremap <buffer><silent> <leader>gt    <cmd>lua vim.lsp.buf.type_definition()<CR>
    "autocmd BufEnter <buffer> :lua require'lsp-ext'.update_diagnostics()

    if &filetype == "java" 
        "nnoremap <buffer><silent> <c-s> :w<cr><cmd>lua vim.lsp.buf.formatting();require'jdtls'.organize_imports()<cr>
    elseif &filetype == "lua" 

    else 
        nnoremap <buffer><silent> <c-s> :w<cr><cmd>lua vim.lsp.buf.format({async = true})<cr>
    endif

    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endfunction


set foldlevel=99

nnoremap <silent> <leader>f0 :set foldlevel=0<CR>
nnoremap <silent> <leader>f9 :set foldlevel=99<CR>
"nnoremap <silent> z0 :set foldlevel=0<CR>
"nnoremap <silent> z9 :set foldlevel=99<CR>

""function SetLSPShortcuts()
    ""nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
    ""nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
    ""nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
    ""nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
    ""nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
    ""nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
    ""nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
    ""nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
    ""nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
    ""nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
""endfunction()

"noremap <leader>rn :call LanguageClient#textDocument_rename()<CR>



set colorcolumn=120


command! Q :q
command! Qa :qa

noremap <end> <c-w>o:Topen<cr><c-w>wi

let test#strategy = "neoterm"
let g:neoterm_autoinsert=0
let g:neoterm_autoscroll=1
let g:neoterm_fixedsize =100
let g:neoterm_default_mod='vert'
"let g:neoterm_open_in_all_tabs=0
"autocmd BufWinEnter,WinEnter term://* startinsert
augroup terminal
    autocmd TermOpen * setlocal bufhidden=hide
    "autocmd TermOpen * set syntax=cpp
    autocmd TermOpen * setlocal nospell
    autocmd TermOpen * nmap <silent> <buffer> <c-d> :bd!<cr>:q<cr>
augroup END

    ""tnoremap <C-v>a <C-\><C-n>"aPi

nnoremap <a-t> :Switch<CR>

"au VimEnter * RainbowParenthesesActivate
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"
let g:rainbow_active = 0

"""
""
""call camelcasemotion#CreateMotionMappings()
"let g:wordmotion_prefix = '-'



"command! CtrlPSameName call feedkeys(":CtrlP\<cr>".expand('%:t:r'), "t")
"nnoremap <a-o> :CtrlPSameName<cr>

"nnoremap <c-a-h> call feedkeys(":CtrlP\<cr>".expand('%:t:r') . ".h", "t")
"set path=.,**


"set noshowmode
set clipboard=unnamedplus

function! GotoPython()
    let current_line = getline('.')
    let goto_file = matchstr(current_line, '\(File "\)\@<=\(.*\)\("\)\@=')
    let goto_line = matchstr(current_line, '\(line \)\@<=[0-9]*')
    execute "tabedit +" . goto_line . " " . goto_file
endfunction

nnoremap <silent> gP :call GotoPython()<cr>


let g:slime_target = "neovim"
"let g:slime_python_ipython = 1
"let g:highlightedyank_highlight_duration = 100

nnoremap <leader>ag :Ag<cr>
"nnoremap <leader>fag :FuzzyAg<cr>
nnoremap <leader>rg :Rg<cr>
"nnoremap <leader>rg :Rg<cr>
"nnoremap <leader>rg <cmd>Telescope live_grep<cr>
let g:LanguageClient_diagnosticsList = "Location"
""let g:quickr_preview_on_cursor = 1


"autocmd FileType fsharp call ActivateCoc()

 ""inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_exit_from_visual_mode=0

let NERDTreeWinSizeMax=50
let NERDTreeRespectWildIgnore=1
"let g:tex_flavor = "latex"

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
""nnoremap <a-s-l> "zyy"zp
""nnoremap <a-s-h> "zyy"zP


"let g:NERDTreeWinPos = "left"
set updatetime=100

let g:license="GPLv3"
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual


""nnoremap <c-p> :CtrlPMixed<cr>
"let g:ctrlp_map = ''
nnoremap <c-p> :Files<CR>
"nnoremap <c-a-ä> :ProjectFiles<CR>
"nnoremap <c-a-m> :ProjectFolders<CR>

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

let g:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

" Files + devicons
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
    au! BufRead,BufNewFile .busted set filetype=lua
    au! BufRead,BufNewFile *.proto2 set filetype=proto
    au! BufRead,BufNewFile *.nim set filetype=nim
    au! BufRead,BufNewFile *.nu set filetype=nu
    au! BufRead,BufNewFile .gitignore set filetype=gitignore
    au! BufRead,BufNewFile *.hlsl,*.effect set filetype=hlsl
    au! BufRead,BufNewFile *.wgsl set filetype=wgsl
    au! BufRead,BufNewFile *.scm set filetype=query
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
    au! BufRead,BufNewFile *.vert,*.frag,*.comp set filetype=glsl
augroup END

"let g:NERDTreeFileExtensionHighlightFullName = 1
"let g:NERDTreeExactMatchHighlightFullName = 1
"let g:NERDTreePatternMatchHighlightFullName = 1
"nmap Q @q
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sh', 'cpp', 'rust', 'java', 'go', 'lua', 'vim', 'lisp']
let g:vim_markdown_math = 1

let g:deoplete#enable_at_startup = 0
"function! Multiple_cursors_before()
  "if g:deoplete#enable_at_startup
    "call deoplete#custom#option('auto_complete', v:false)
  "end
"endfunction
"function! Multiple_cursors_after()
    "if g:deoplete#enable_at_startup
      "call deoplete#custom#option('auto_complete', v:true)
    "endif
"endfunction
let g:lt_location_list_toggle_map = '<leader>ql'
let g:lt_quickfix_list_toggle_map = '<leader>qe'
""au! FileType cmake unmap <buffer> <silent> gh
""au! FileType cmake nmap <buffer> <silent> <unique> gh <Plug>CMakeCompleteHelp
nmap <leader>ch :Cheat! 


let g:netrw_browsex_viewer='xdg-open'
"let g:rust_fold = 1
"let g:cargo_makeprg_params = 'build'

""let g:oceanic_next_terminal_bold = 1
""let g:oceanic_next_terminal_italic = 1
""colorscheme OceanicNext

nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>n <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

""set completeopt=menuone,menu,longest,noinsert
set completeopt=menuone,menu,longest,noselect,noinsert
"set completeopt=menuone,noselect
"" Highlight (inofficial) json comments
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
"nnoremap <leader>te :set shell=/usr/bin/zsh<cr>:Topen<Cr>
"nnoremap <leader>to :Topen<cr>
"nnoremap <leader>tt :T<space>
""nnoremap <leader>22 :T<space>!!<enter>:T && echo ""<enter>



""luafile $HOME/.config/nvim/iron.lua
""nmap <Leader>gd :Gdiff<CR>
""
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

let maplocalleader = ','


if has('nvim')
  set wildoptions=pum
  set pumblend=20
  "set winblend=10
endif

let g:UltiSnipsEnableSnipMate=1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

autocmd BufReadPre *.pdf silent set ro
autocmd BufReadPre *.pdf silent :T okular "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78

autocmd BufReadPre *.png silent %!xdg-open "%"
autocmd BufReadPre *.eps silent %!xdg-open "%"
autocmd BufReadPre *.jpg silent %!xdg-open "%"
autocmd BufReadPre *.bmp silent %!xdg-open "%"
autocmd BufReadPre *.ipynb silent %!xdg-open "%"

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
""noremap <c-j> <c-w>w
""noremap <c-k> <c-w>W


if has('nvim')
  "let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit setlocal bufhidden=delete
  autocmd FileType gitrebase setlocal bufhidden=delete
endif

let g:email='stephan.seitz@fau.de'
let g:username='Stephan Seitz'

"let g:gitgutter_max_signs=1000

let g:rooter_patterns = ['.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
nnoremap <leader>JU :JustTargets<cr>
nnoremap <leader>ju :JustTargetsAsync<cr>


let g:auto_git_diff_disable_auto_update=1
let g:auto_git_diff_show_window_at_right=1

"function! s:setup_auto_git_diff() abort
    "nmap <buffer> <C-l> <Plug>(auto_git_diff_scroll_manual_update)
    "nmap <buffer> <C-n> <Plug>(auto_git_diff_scroll_down_half)
    "nmap <buffer> <C-p> <Plug>(auto_git_diff_scroll_up_half)
    "nmap <buffer> <enter> <Plug>(auto_git_diff_manual_update)
"endfunction
"autocmd FileType gitrebase call <SID>setup_auto_git_diff()

"nmap <silent> <c-a-j> <Plug>(GitGutterNextHunk)
"nmap <silent> <c-a-j> <Plug>(GitGutterNextHunk)
"nmap <silent> <c-a-k> <Plug>(GitGutterPrevHunk)
"nmap <silent> <leader>hs <Plug>(GitGutterStageHunk)
"nmap <silent> <leader>hu <Plug>(GitGutterUndoHunk)
"nmap ]h :call NextHunkAllBuffers()<CR>
"nmap [h :call PrevHunkAllBuffers()<CR>

nmap <silent> <c-a-j> <cmd>lua require "gitsigns".next_hunk()<CR>
nmap <silent> <c-a-k> <cmd>lua require "gitsigns".prev_hunk()<CR>

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

let g:doge_doc_standard_python='google'

autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>
autocmd FileType * setlocal bufhidden=hide

command! Emoji %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g





let g:gitgutter_max_signs=3000



""" Always draw sign column. Prevent buffer moving when adding/deleting sign.

"call deoplete#custom#option('auto_complete', v:true)
 ""let g:LanguageClient_serverCommands = {
     ""\ 'cpp': ['clangd-9', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes']
         ""\ }
 ""let $RUST_BACKTRACE = 1
 ""let g:LanguageClient_loggingLevel = 'INFO'
 ""let g:LanguageClient_virtualTextPrefix = ''
 ""let g:LanguageClient_loggingFile = expand('~/.local/share/nvim/LanguageClient.log')
 ""let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

""let g:context_enabled = 1

""autocmd VimEnter     * ContextActivate
""autocmd BufAdd       * call context#update(1, 'BufAdd')
""autocmd BufEnter     * call context#update(0, 'BufEnter')
""autocmd CursorMoved  * call context#update(0, 'CursorMoved')
""autocmd User GitGutter call context#update_padding('GitGutter')


let g:vlime_contribs = ['SWANK-QUICKLISP', 'SWANK-ASDF', 'SWANK-PACKAGE-FU',
                      \ 'SWANK-PRESENTATIONS', 'SWANK-FANCY-INSPECTOR',
                      \ 'SWANK-C-P-C', 'SWANK-ARGLISTS', 'SWANK-REPL',
                      \ 'SWANK-FUZZY', 'SWANK-TRACE-DIALOG']

""let g:LanguageClient_windowLogMessageLevel = 'Log'
""let g:LanguageClient_loggingLevel ='DEBUG'
""let g:LanguageClient_loggingFile= expand('~/log')
"let g:paredit_leader=','

"let g:iced_enable_default_key_mappings = v:true


let g:LanguageClient_useVirtualText='All'

command! CargoPlay :T cargo play %





nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(-25)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(+25)<CR>

nnoremap K :s/,/,\r/g<cr>


""let g:LanguageClient_semanticHighlightMaps['java'] = {
    ""\ '^storage.modifier.static.java:entity.name.function.java': 'JavaStaticMemberFunction',
    ""\ '^meta.definition.variable.java:meta.class.body.java:meta.class.java': 'JavaMemberVariable',
    ""\ '^entity.name.function.java': 'Function',
    ""\ '^[^:]*entity.name.function.java': 'Function',
    ""\ '^[^:]*entity.name.type.class.java': 'Type',
    ""\ }

""highlight! JavaStaticMemberFunction ctermfg=Green cterm=none guifg=Green gui=none
""highlight! JavaMemberVariable ctermfg=White cterm=italic guifg=White gui=italic
"command! YankFilename :let @+ = expand("%:p")
"packadd termdebug
""
""let g:pudb_python='/usr/bin/python3'
""
"nnoremap <leader>tq  :cgetbuffer<cr>:copen<cr>
"nnoremap <leader>tQ :setlocal errorformat=
    "\%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
    "\%C\ \ \ \ %.%#,
    "\%+Z%.%#Error\:\ %.%#,
    "\%A\ \ File\ \"%f\"\\\,\ line\ %l,
    "\%+C\ \ %.%#,
    "\%-C%p^,
    "\%Z%m,
    "\%-G%.%#<cr>:cgetbuffer<cr>:copen<cr>

"let g:completion_confirm_key = "\<C-y>"
let g:sexp_enable_insert_mode_mappings=1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']


"let g:vlime_compiler_policy={"DEBUG": 3, "SPEED": 0}


"augroup CustomVlimeInputBuffer
    "autocmd!
    "autocmd FileType vlime_input inoremap <silent> <buffer> <tab> <c-r>=vlime#plugin#VlimeKey("tab")<cr>
    "autocmd FileType vlime_input setlocal omnifunc=vlime#plugin#CompleteFunc
    "autocmd FileType vlime_input setlocal indentexpr=vlime#plugin#CalcCurIndent()
    "autocmd BufEnter vlime_input i
"augroup end

"nnoremap <c-g> :InfoWindowToggle<cr>
nnoremap <a-s-k> "ayy"aP
nnoremap <a-s-j> "ayy"ap

""" invert that dictionary to create one mapping names to codepoints
""let unicodeIndex = {}
""for codepoint in keys(g:unicode#unicode#data)
  ""let char = nr2char(codepoint)
  ""let unicodeIndex[g:unicode#unicode#data[codepoint] . ' ' . char] = char
""endfor

""" shamelessly shadow the default i_CTRL-U (clear to beginning of line) mapping because I never use it.
""inoremap <C-s-U> <C-R>=join(map(fzf#run({'source': keys(unicodeIndex), 'down': '10' }), 'unicodeIndex[v:val]'))<CR><Esc>

""lua require'git_fastfix'
""nn <silent> <leader>gf :lua OpenGitFastFixWindow()<cr>

nnoremap <silent> gf gF

nnoremap Gtf :Tnew<cr>:T dolphin %:p:h 2>&1 >> /dev/null &<cr>:Tclose<cr>
""let g:vimspector_enable_mappings = 'HUMAN'

command! CdToCurrentFile cd %:p:h
"command! SwitchWorkingDirToCurrentFile cd %:p:h



nnoremap <silent> <c-ScrollWheelUp> :lua require'my_gui'.increase_fontsize()<cr>
nnoremap <silent> <c-ScrollWheelDown> :lua require'my_gui'.decrease_fontsize()<cr>
nnoremap <silent> <c-0> :lua require'my_gui'.reset_fontsize()<cr>

"let g:lua_tree_side = 'left' " | 'left' left by default
"let g:lua_tree_size = 50 "30 by default
"let g:lua_tree_auto_open = 0 "0 by default, opens the tree when typing `vim $DIR` or `vim`
"let g:lua_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
"let g:lua_tree_follow = 1 "0 by default, this option will bind BufEnter to the LuaTreeFindFile command
"" :help LuaTreeFindFile for more info
"let g:lua_tree_show_icons = {
    "\ 'git': 1,
    "\ 'folders': 1,
    "\ 'files': 1,
    "\}
"let g:lua_tree_use_wildignore = 1
""If 0, do not show the icons for one of 'git' 'folder' and 'files'
""1 by default, notice that if 'files' is 1, it will only display
""if web-devicons is installed and on your runtimepath

"" You can edit keybindings be defining this variable
"" You don't have to define all keys.
"" NOTE: the 'edit' key will wrap/unwrap a folder and open a file
"let g:lua_tree_bindings = {
    "\ 'edit':        '<CR>',
    "\ 'edit_vsplit': '<C-v>',
    "\ 'edit_split':  '<C-x>',
    "\ 'edit_tab':    '<C-t>',
    "\ 'cd':          '.',
    "\ 'create':      'a',
    "\ 'remove':      'd',
    "\ 'rename':      'r'
    "\ }
"let g:lua_tree_ignore = [ '.git', 'node_modules', '.cache', '__pycache__' ]

"nnoremap <Leader>nf :CHADopen<cr>
"nnoremap <Leader>nt :CHADopen<cr>

"nnoremap <Leader>nf :NERDTreeFind<cr>
"nnoremap <Leader>nt :NERDTreeToggle<cr>
nnoremap <Leader>nf :Neotree filesystem reveal left<cr>
nnoremap <Leader>nt :Neotree toggle<cr>
""
"let g:diagnostic_insert_delay = 1


"function! FzfProjectSink(word)
  "exe ':e ~/projects/' .  a:word
"endfunction
"function! FzfProjectSearch()
  "let suggestions = systemlist("ls ~/projects")
  "return fzf#run({'source': suggestions, 'sink': function("FzfProjectSink"), 'window': 'call FloatingFZF()'})
"endfunction

"function! FzfSpellSink(word)
  "exe 'normal! "_ciw'.a:word
"endfunction
"function! FzfSpell()
  "let suggestions = spellsuggest(expand("<cword>"))
  "return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'window': 'call FloatingFZF()'})
"endfunction

"nnoremap <space>pr :call FzfProjectSearch()<CR>
"nnoremap z= :call FzfSpell()<CR>

command! GitPushAsync lua require'my_commands'.git_push()
command! GitPushAsyncForce lua require'my_commands'.git_push(true)
"command! PyTest lua require'my_commands'.custom_command('pytest')

"function! ProjectFilesSink(word)
  "exe ':e '. a:word
"endfunction

"function! ProjectFilesSearch()
  "let suggestions = luaeval("require'my_projects'.get_project_files()")
  "return fzf#run({'source': suggestions, 'sink': function("ProjectFilesSink"), 'window': 'call FloatingFZF()'})
"endfunction

"function! ProjectFoldersSearch()
  "let suggestions = luaeval("require'my_projects'.get_project_list()")
  "return fzf#run({'source': suggestions, 'sink': function("ProjectFilesSink"), 'window': 'call FloatingFZF()'})
"endfunction

"function! RunJavaSink(main_class)
  "exe "lua require'my_java_projects'.launch_java_main('" . a:main_class ."')"
  ""exe "T ./gradlew run -PmainClass=" . a:main_class
"endfunction


"function! PluginReadmes()
  "let files = luaeval("require'my_projects'.get_plugin_readmes()")
  "return fzf#run({'source': files, 'sink': function("ProjectFilesSink"), 'window': 'call FloatingFZF()'})
"endfunction

"function! RunJavaMain()
  "let mains = luaeval("require'my_java_projects'.get_java_main_classes()")
  "return fzf#run({'source': mains, 'sink': function("RunJavaSink"), 'window': 'call FloatingFZF()'})
"endfunction

"command! ProjectClose lua require'my_projects'.close_project()
"command! ProjectFiles call ProjectFilesSearch()
"command! ProjectFolders call ProjectFoldersSearch()
"command! RunJavaMain call RunJavaMain()
"command! PluginReadmes call PluginReadmes()


""nnoremap gm m
""nnoremap d d
"function! s:get_visual_selection()
    ""cp https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
    "let [line_start, column_start] = getpos("'<")[1:2]
    "let [line_end, column_end] = getpos("'>")[1:2]
    "let lines = getline(line_start, line_end)
    "if len(lines) == 0
        "return ''
    "endif
    "let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    "let lines[0] = lines[0][column_start - 1:]
    "call setreg('+', lines, 'l')
    "1T %paste
"endfunction
"command! -nargs=* PasteVisualSel call s:get_visual_selection()
"let g:vlime_leader = ","
let g:vlime_leader='<space>'
let g:vlime_cl_use_terminal=v:true
let g:vlime_enable_autodoc = v:true
let g:vlime_window_settings = {'sldb': {'pos': 'belowright', 'vertical': v:true}, 'inspector': {'pos': 'belowright', 'vertical': v:true}, 'preview': {'pos': 'belowright', 'size': v:null, 'vertical': v:true}}

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"vnoremap <enter> :lua require'nvim-treesitter/textobj'.scope_incremental()<cr>

"nmap <s-a-k> :lua require'nvim-treesitter/node_movement'.node_move_up()<cr>
"nmap <s-a-h> :lua require'nvim-treesitter/node_movement'.node_move_left()<cr>
"nmap <s-a-l> :lua require'nvim-treesitter/node_movement'.node_move_right()<cr>
"nmap <s-a-j> :lua require'nvim-treesitter/node_movement'.node_move_down()<cr>

""vmap <a-k> :lua require'nvim-treesitter/node_movement'.move_up()<cr>
""vmap <a-h> :lua require'nvim-treesitter/node_movement'.move_left()<cr>
""vmap <a-l> :lua require'nvim-treesitter/node_movement'.move_right()<cr>
""vmap <a-j> :lua require'nvim-treesitter/node_movement'.move_down()<cr>

""let g:lightline = { 'colorscheme': 'palenight' }
au TextYankPost * silent! lua require'vim.highlight'.on_yank({"IncSearch", 150})


let g:sexp_filetypes = 'clojure,scheme,lisp,timl,vlime_repl,fennel,query'
let g:sexp_enable_insert_mode_mappings = 0

"nmap <f2> :lua require'nvim-treesitter/playground'.play_with()<cr>

"nmap j <Plug>(accelerated_jk_gj)
"nmap k <Plug>(accelerated_jk_gk)

let g:markdown_composer_autostart=0

nnoremap <c-h> :History<cr>
nnoremap <c-t> :Tags<cr>
nnoremap <c-s-t> :Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <c-a-o> :BTags<cr>
nnoremap <leader><c-o> :BTags<cr>

if has("win32")
luafile ~/AppData/Local/nvim/lua/init.lua
else
luafile ~/.config/nvim/lua/init.lua
end


command! -buffer JdtCompile lua require('jdtls').compile()
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()

nnoremap <leader>bd :Bdelete<cr>

"let g:spelunker_check_type = 2
"nmap z= Zl
"nmap zg Zg

"autocmd BufWritePost *.go call spelunker#check_displayed_words()
"

function DapMaps()
    nnoremap <buffer> <silent> <F9> :lua require'dap'.step_over()<CR>
    nmap <f1> :lua require'dap'.goto_()<cr>
    nnoremap <buffer> <silent> <F10> :lua require'dap'.step_into()<CR>
    nnoremap <buffer> <silent> <F11> :lua require'dap'.step_out()<CR>

    nmap <buffer> <silent> <leader>bb :lua require'dap'.toggle_breakpoint()<CR>
    nmap <buffer> <silent> <leader>bB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nmap <buffer> <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log message: '))<CR>
    nmap <buffer> <silent> <leader>br :lua require'dap'.restart()<CR>
    nmap <buffer> <silent> <leader>bc :lua require'dap'.continue()<CR>
    nmap <buffer> <silent> <leader>bn :lua require'dap'.step_over()<CR>
    nmap <buffer> <silent> <leader>bi :lua require'dap'.step_into()<CR>
    nmap <buffer> <silent> <leader>bo :lua require'dap'.step_out()<CR>
    nmap <buffer> <silent> <leader>lb :lua require'dap'.list_breakpoints()<CR>
    nmap <buffer> <silent> <leader>bm :DebugRepl<cr>
    nmap <buffer> <silent> <leader>dh :lua require 'dap.ui.widgets'.hover()<cr>
    nmap <buffer> <silent> <leader>ds :lua require 'dap.ui.widgets'.centered_float(require 'dap.ui.widgets'.scopes)<cr>
    nmap <buffer> <silent> <leader>df :lua require 'dap.ui.widgets'.frames()<cr>
    nmap <buffer> <silent> <leader>TN :lua require'dap';require 'dap-python'.test_method()<cr>:lua require 'dap.repl'.open()<cr>
    nmap <buffer> <silent> <leader>bT :lua require 'dap'.run_last()<cr>:lua require 'dap.repl'.open()<cr>
    command! DebugRepl :lua require'dap'.repl.open()<cr>
    command! ExceptionBreakpoints :lua require'dap'.set_exception_breakpoints()<cr>
endfunction

"nmap <silent> <leader>sf :lua require'dap'.select_frame()<CR>
nmap <silent> <leader>sf :lua require'telescope'.extensions.dap.frames{}<CR>

nnoremap <F8> :TagbarOpenAutoClose<CR>
nmap ,w ysiw)
nmap ,<s-w> ysiW)

nnoremap <leader>pl :lua vim.treesitter.show_tree()<cr>


let g:completion_enable_snippet = 'UltiSnips'
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet', 'buffers']},
    \{'mode': '<c-f>'},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

autocmd BufEnter,BufNewFile *.wat set filetype=wat
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


"let g:fzf_preview_git_status_preview_command =
    "\ "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} | delta || " .
    "\ "[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} | delta || " .
    "\ g:fzf_preview_command

if exists('g:fvim_loaded')
    " good old 'set guifont' compatibility
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

 "set completeopt +=preview
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


"lua require('hlslens').setup()
"noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            "\<Cmd>lua require('hlslens').start()<CR>
"noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            "\<Cmd>lua require('hlslens').start()<CR>
"noremap * *<Cmd>lua require('hlslens').start()<CR>
"noremap # #<Cmd>lua require('hlslens').start()<CR>
"noremap g* g*<Cmd>lua require('hlslens').start()<CR>
"noremap g# g#<Cmd>lua require('hlslens').start()<CR>

"" use : instead of <Cmd>
"nnoremap <silent> <leader>l :nohlsearch<CR>
"

"autocmd! BufWrite,CursorHold *.rs :lua require "lsp_extensions".inlay_hints({enabled = {"TypeHint", "ParameterHint"}, highlight = "Comment", prefix = " > "})
"command! InlayHints :lua require "lsp_extensions".inlay_hints({enabled = {"TypeHint", "ChainingHint", "ParameterHint"}, highlight = "Comment", prefix = " ? "})

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
"nnoremap <leader>fy :Telescope frecency<cr>
"inoremap <c-s> <Esc>:lua require "telescope.builtin".symbols {sources = {"emoji", "kaomoji", "math", "latex"}}<cr>

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

"inoremap <silent><expr> <c-CR>      <cmd>call compe#confirm('<CR>')

"autocmd ColorScheme * call v:lua.vim.lsp.diagnostic._define_default_signs_and_highlights()
"autocmd ColorScheme * highlight TSTitle guifg=#229922 gui=bold,underline
autocmd ColorScheme * highlight NvimDapStopped guibg=#000055

autocmd ColorScheme * highlight default link TSDefinitionUsage Visual
autocmd ColorScheme * highlight link LspComment Comment
autocmd ColorScheme * highlight default link TSDefinition Search
autocmd ColorScheme * highlight default link TSCurrentScope CursorLine

nnoremap <silent> X :normal! x<cr>
noremap <silent> <leader>tb :Tagbar<cr>

command! Tokyo :packadd tokyonight.nvim | let g:tokyonight_style = "night" | colorscheme tokyonight
command! TokyoStorm :packadd tokyonight.nvim | let g:tokyonight_style = "storm" | colorscheme tokyonight
command! TokyoDay :packadd tokyonight.nvim | let g:tokyonight_style = "day" | colorscheme tokyonight
command! Nightfly :packadd vim-nightfly-guicolors | colorscheme nightfly
command! Moonfly :packadd vim-moonfly | colorscheme moonfly
command! OneDark colorscheme one

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


"function! CustomgF()
    "let line = getline('.')->matchstr(', line \zs\d\+')

    "if line
        "" if we have one, do regular gF, which won't jump
        "" to the desired line anyway because Vim can't parse
        "" tracebacks properly
        "normal! gF

        "" but we don't care because we can jump
        "" to the found line on our own
        "execute line
    "else
        "" if we don't, do regular gF
        "normal! gF
    "endif
"endfunction
"nnoremap gP <Cmd>call CustomgF()<CR>
"
set laststatus=3
let g:copilot_node_command = "/usr/bin/node"

highlight @deprecated term=strikethrough cterm=strikethrough gui=strikethrough
highlight default link @injected None 
"highlight @variable.gobalScope guibg=#773244
onoremap <silent> m :<C-U>lua require('tsht').nodes()<CR>
xnoremap <silent> m :lua require('tsht').nodes()<CR>
