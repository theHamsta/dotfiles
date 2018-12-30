set shell=/usr/bin/zsh
if has('vim_starting')
	set nocompatible               " Be iMproved
endif


let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,python"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim
"let g:fzf_command_prefix = 'fzf'

if !filereadable(vimplug_exists)
	if !executable("curl")
		echoerr "You have to install curl or first install vim-plug yourself!"
		execute "q!"
	endif
	echo "Installing Vim-Plug..."
	echo ""
	silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	let g:not_finish_vimplug = "yes"

	autocmd VimEnter * PlugInstall
endif

"vim-scripts/VimPdb Identify platform {
let g:MAC = has('macunix')
let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = has('win32') || has('win64')
" }

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if g:WINDOWS
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
" }

set runtimepath+=$HOME/.space-vim/core




set number
set relativenumber

" Always show line numbers, but only in current window.
set number
au WinEnter * :setlocal number
au WinEnter * :setlocal relativenumber
au WinLeave * :setlocal relativenumber!

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


"au WinLeave * :setlocal nonumber
"
"" " Automatically resize vertical splits.
"au WinEnter * :set winfixheight
"au WinEnter * :wincmd =

"nnoremap j gj
"nnoremap k gk
nnoremap <leader>make :wa<Cr>:make<Cr>
nnoremap <leader>hi :History<Cr>
nnoremap <leader>te :set shell=/usr/bin/zsh<cr>:split<cr>:term<Cr>:exe "resize " . 13<CR>
nnoremap <leader>tt 'Ti
nnoremap <leader>so :source %<Cr>
nnoremap <leader>lime :Limelight!! 0.8<cr>
nnoremap <c-a-j> yyp
nnoremap <c-a-k> yyP
nnoremap <space><space> o<Esc>
nnoremap c "_c
nnoremap x "_x
vnoremap < <gv
vnoremap > >gv
nnoremap K :s/,/,\r/g<CR>
nnoremap Y y$
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
nnoremap <C-S-J> :m+<CR>==
nnoremap <C-S-K> :m-2<CR>==
inoremap <C-S-J> <Esc>:m+<CR>==gi
inoremap <C-S-K> <Esc>:m-2<CR>==gi
vnoremap <C-S-J> :m'>+<CR>gv=gv
vnoremap <C-S-K> :m-2<CR>gv=gv
"inoremap  y/<C-R>"<CR>
"nnoremap <c-w>o :tabedit %<cr>

"let &path.="/usr/include,/usr/local/include,../include,/usr/local/include/opencv2"
nnoremap <F4> :wa<Cr>:make<cr>
nnoremap <Leader>cn :cn<cr>
nnoremap <Leader>cN :cN<cr>
nnoremap <Leader>sde :set spell<cr>:set spelllang=de<cr>
nnoremap <Leader>sen :set spell<cr>:set spelllang=en<cr>
inoremap <expr> <CR> pumvisible() ? "\<C-n>" : "\<C-g>u\<CR>"

nnoremap <Leader>bp :bN<cr>
nnoremap <Leader>bn :bn<cr>
nnoremap <Leader>tp :tabprevious<cr>
nnoremap <Leader>tn :tabNext<cr>
nnoremap <Leader>tab :tabnew<cr>
nnoremap <Leader>tc :tabclose<cr>
nnoremap <Leader>nt :NERDTreeToggle<cr>
nnoremap <Leader>nf :NERDTreeFind<cr>
nnoremap <Leader>oo :only<cr>
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> [[
nmap <silent> <C-j> ]]
nmap <silent> <C-h> :tp<cr>
nmap <silent> <C-l> :tn<cr>
nmap <Leader>ag :GonvimFuzzyAg
map <SPACE> <leader>
map <SPACE> <leader>

set wrap
set linebreak
set nolist  " list disables linebreak
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
"
"set expandtab

"inoremap <A-v> <C-R><C-R>+
inoremap <c-V> <C-R><C-R>+
nnoremap <a-v> <C-R><C-R>+
"nnoremap <A-v> "+p
"inoremap II <Esc>I
"inoremap AA <Esc>A
"inoremap OO <Esc>O
inoremap <c-h> <Esc>gea
inoremap <c-l> <Esc>ea
inoremap jk <Esc>
smap <c-n> <Esc>a<tab>
"smap <c-t> <Esc>a<s-tab>
"snoremap <c-u> <Esc>a<tab>

call plug#begin('~/.local/share/nvim/plugged')
	"Plug 'SirVer/ultisnips'
	"" deoplete config
	"let g:deoplete#enable_at_startup = 1
	"" disable autocomplete
	"let g:deoplete#disable_auto_complete = 1
	"if has("gui_running")
		"inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
	"else
		"inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
	"endif
	"" UltiSnips config
	"inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
	"let g:UltiSnipsExpandTrigger="<tab>"
	"let g:UltiSnipsJumpForwardTrigger="<tab>"
	"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
	Plug 'chaoren/vim-wordmotion'
	Plug 'kassio/neoterm'
	"Plug 'bkad/CamelCaseMotion'
	"Plug 'Olical/vim-enmasse'
	"Plug 'craigemery/vim-autotag'
	"Plug 'ivalkeen/vim-ctrlp-tjump'
	"Plug 'junegunn/seoul256.vim'
	Plug 'akiyosi/gonvim-fuzzy'
	"Plug 'sagarrakshe/toggle-bool'
	Plug 'AndrewRadev/switch.vim'
	Plug 'kien/rainbow_parentheses.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'machakann/vim-swap'
	Plug 'justinmk/vim-sneak'
	Plug 'Shougo/echodoc.vim'
	"Plug 'juanibiapina/vim-runner'
	Plug 'tpope/vim-projectionist'
	"Plug 'w0rp/ale'
	Plug 'aben20807/vim-runner'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	"Plug 'jpalardy/vim-slime'
	Plug 'kovisoft/slimv'
	"Plug 'machakann/vim-highlightedyank'
	"Plug 'scrooloose/nerdtree'
	"Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'equalsraf/neovim-gui-shim'
	Plug 'michaeljsmith/vim-indent-object'
	Plug 'rking/ag.vim'
	Plug 'Chun-Yang/vim-action-ag'
	Plug 'easymotion/vim-easymotion'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'junegunn/goyo.vim'
	Plug 'autozimu/LanguageClient-neovim', {
	    \ 'branch': 'next',
	    \ 'do': 'bash install.sh',
	    \ }

	" (Optional) Multi-entry selection UI.
	"Plug 'junegunn/fzf'
	"Plug 'junegunn/fzf.vim'
	"Plug 'Valloric/YouCompleteMe'
	
	"if has('nvim')
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	"else
		"Plug 'Shougo/deoplete.nvim'
		"Plug 'roxma/nvim-yarp'
		"Plug 'roxma/vim-hug-neovim-rpc'
	"endif

	"Plug 'Shougo/neosnippet.vim'
	"Plug 'Shougo/neosnippet-snippets'
	Plug 'rbonvall/snipmate-snippets-bib'
	"Plug 'tweekmonster/deoplete-clang2'
	Plug 'zchee/deoplete-jedi'
	Plug 'Shougo/vimproc.vim', {'do' : 'make'}
	"Plug 'idanarye/vim-vebugger'
	"Plug 'Shougo/neoinclude.vim'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-repeat'
	Plug 'garbas/vim-snipmate'
	Plug 'burke/matcher'
	"Plug 'bling/vim-bufferline'
	Plug 'scrooloose/nerdcommenter'
	Plug 'MarcWeber/vim-addon-mw-utils'
	Plug 'tomtom/tlib_vim'
	Plug 'theHamsta/vim-snippets'
	Plug 'rakr/vim-one'
	Plug 'altercation/vim-colors-solarized'
	Plug 'majutsushi/tagbar'
	Plug 'vim-airline/vim-airline'
	Plug 'rliang/nvim-pygtk3', {'do': 'make install'}
	Plug 'lervag/vimtex'
	Plug 'beloglazov/vim-online-thesaurus'
	Plug 'wellle/targets.vim'
	"Plug 'rkulla/pydiction'
	"Plug 'xolox/vim-misc'
	"Plug 'xolox/vim-easytags'

call plug#end()


let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#executable='/usr/bin/clang'

nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
nnoremap <Leader>buf :buffers<CR>
nnoremap <Leader>dox :Dox<CR>

autocmd FileType cpp iabbrev <buffer> firend friend
autocmd FileType cpp iabbrev <buffer> flaot float
autocmd FileType cpp iabbrev <buffer> _std std::
autocmd FileType cpp iabbrev <buffer> stirng string
"set autochdir
autocmd BufEnter * silent! lcd %:p:h
"nnoremap gf :vertical wincmd f<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.log,*/CMakeFiles/*

set lazyredraw
set ttyfast

map <leader>ll <plug>(easymotion-lineforward)
map <leader>jj <plug>(easymotion-j)
map <leader>kk <plug>(easymotion-k)
map <leader>hh <plug>(easymotion-linebackward)
let g:easymotion_smartcase = 1
let g:easymotion_smartsign = 1

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_keys='hklyuiopnm,qwertzxcvbasdgjf'

nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gr :Gread<CR>
nmap <Leader>gp :!git push<CR>
vnoremap // y/<C-R>"<CR>

let g:wordmotion_prefix = '<Leader>'

if exists(":Tabularize")
    nmap <Leader>t& :Tabularize /&<CR>
    vmap <Leader>t& :Tabularize /&<CR>
    nmap <Leader>t= :Tabularize /=<CR>
    nmap <Leader>t<Bar> :Tabularize /<CR>
    vmap <Leader>t<Bar> :Tabularize /<CR>
    nmap <Leader>t= :Tabularize /=<CR>
    vmap <Leader>t= :Tabularize /=<CR>
    nmap <Leader>t: :Tabularize /:\zs<CR>
    vmap <Leader>t: :Tabularize /:\zs<CR>
endif

inoremap <expr><cr> pumvisible() ? "\<c-n>" : "\<cr>"

autocmd BufEnter *.m    compiler mlint 

" Set the background theme to dark
set background =dark

" Call the theme one
colorscheme one

" Don't forget set the airline theme as well.
let g:airline_theme = 'one'

" This line enables the true color support.
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Note, the above line is ignored in Neovim 0.1.5 above, use this line instead.
set termguicolors

if (has("nvim"))
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
set termguicolors
endif


nnoremap <leader>gr :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><cr>

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects    .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

if executable('matcher')
    let g:ctrlp_match_func = { 'match': 'GoodMatch' }

    function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

      " Create a cache file if not yet exists
      let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
      if !( filereadable(cachefile) && a:items == readfile(cachefile) )
        call writefile(a:items, cachefile)
      endif
      if !filereadable(cachefile)
        return []
      endif

      " a:mmode is currently ignored. In the future, we should probably do
      " something about that. the matcher behaves like "full-line".
      let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
      if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
        let cmd = cmd.'--no-dotfiles '
      endif
      let cmd = cmd.a:str

      return split(system(cmd), "\n")

    endfunction
end

nmap <F8> :TagbarOpenAutoClose<CR>
set hidden

set splitbelow
set splitright
set ignorecase
set smartcase

let g:vebugger_leader =','
"let g:ycm_server_python_interpreter='/usr/bin/python3'

"let g:deoplete#sources#jedi#extra_path =['', '/usr/lib/python2.7', '/usr/lib/python2.7/plat-x86_64-linux-gnu', '/usr/lib/python27/lib-tk', '/usr/lib/python2.7/lib-old', '/usr/lib/python2.7/lib-dynload', '/home/stepha/.local/lib/python2.7/site-packages', '/usr/local/lib/python2.7/dist-packages', '/usr/li/python2.7/dist-packages', '/usr/lib/python2.7/dist-packages/PILcompat', '/usr/lib/pytho2.7/dist-packages/gtk-2.0', '/usr/lib/python2.7/dist-packages/wx-3.0-gtk2']
"autocmd FileType python nnoremap <buffer> <F6> :VBGstartPDB %<cr>
"autocmd FileType python nnoremap <buffer> <F7> :VBGcontinue<cr>
"autocmd FileType python nnoremap <buffer> <F8> :VBGtoggleBreakpointThisLine<cr>
"autocmd FileType python nnoremap <buffer> <F10> :VBGstepOver<cr>
"autocmd FileType python nnoremap <buffer> <F11> :VBGstepIn<cr>
"autocmd FileType python nnoremap <buffer> <F12> :VBGstepOver<cr>
autocmd FileType python nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>:let last_execution=@% <cr>
autocmd FileType python nnoremap <buffer> <F3> :!python3 shellescape( last_execution, 1)<cr>

autocmd FileType lua nnoremap <buffer> <F5> :exec '!lua' shellescape(@%:p, 1)<cr>:let last_execution=@%:p <cr>
autocmd FileType lua nnoremap <buffer> <F3> :exec '!lua' shellescape( last_execution, 1)<cr>

let g:ag_working_path_mode="r"
let g:deoplete#sources#jedi#python_path='/usr/bin/python3'


let g:ale_fixers = {'python': ['pylint']}

"let g:ale_python_flake8_executable = 'python3'
"let g:ale_python_flake8_args = '-m flake8'

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

"call abolish#Abolish({despa,sepe}rast{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}

"imap <C-J> <Plug>snipMateNextOrTrigger
"smap <C-J> <Plug>snipMateNextOrTrigger

let g:vlime_leader = ","
let g:vlime_enable_autodoc = v:true
let g:vlime_window_settings = {'sldb': {'pos': 'belowright', 'vertical': v:true}, 'inspector': {'pos': 'belowright', 'vertical': v:true}, 'preview': {'pos': 'belowright', 'size': v:null, 'vertical': v:true}}
let g:gonvim_draw_statusline = 0


    "\ 'cpp': ['clangd'],
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ 'lua': ['lua-lsp'],
    \ 'cpp': ['clangd-7'],
    \ 'lisp': ['~/.roswell/bin/cl-lsp'],
    \ }
	"\ 'cpp': ['/home/stephan/projects/cquery/build/release/bin/cquery','--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}, "completion": {"filterAndSort": false}}'],
"if executable('ccls')
	   "au User lsp_setup call lsp#register_server({
			 "\ 'name': 'ccls',
			 "\ 'cmd': {server_info->['ccls']},
			 "\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
			 "\ 'initialization_options': { 'cacheDirectory': '/tmp/ccls/cache' },
			 "\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
			 "\ })
   "endif

nnoremap <leader>la :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <leader>ty :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> gt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>ss :call LanguageClient#textDocument_documentSymbol()<CR>
"nnoremap <silent> <c-s-o> :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <c-s> :call LanguageClient#textDocument_formatting()<CR>:w<CR>
nnoremap <silent> <leader>ref :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <leader>fo :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <leader>hi :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>co :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <silent> <leader>f0 :set foldlevel=0<CR>
nnoremap <silent> <leader>ff :set foldlevel=99<CR>

"function SetLSPShortcuts()
	"nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
	"nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
	"nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
	"nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
	"nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
	"nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
	"nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
	"nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
	"nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
	"nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
"endfunction()

"augroup LSP
"autocmd!
"autocmd FileType cpp,c,python,go,rust call SetLSPShortcuts()
"augroup END

noremap <leader>rn :call LanguageClient#textDocument_rename()<CR>

" Rename - rc => rename camelCase
noremap <leader>rc :call LanguageClient#textDocument_rename( \ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>

" Rename - rs => rename snake_case
noremap <leader>rs :call LanguageClient#textDocument_rename( \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>

" Rename - ru =>
noremap <leader>ru :call LanguageClient#textDocument_rename( \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>

nn <silent> xh :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<cr>
nn <silent> xj :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<cr>
nn <silent> xk :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<cr>
nn <silent> xl :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<cr>

set foldmethod=indent
setlocal foldignore=

set foldlevel=99

let g:slime_target = "neovim"
let g:slime_python_ipython = 1

command! Q :q
command! Qa :qa



"fu! C_init()
	  "setl formatexpr=LanguageClient#textDocument_rangeFormatting()
"endf
"au FileType c,cpp,cuda,objc :call C_init()
nnoremap <c-h> :History<Cr>
set shell=/usr/bin/zsh
noremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap <c-d> <C-\><C-n><c-w>c

nnoremap <a-t> :Switch<CR>

let g:projectionist_heuristics = {
	\    '*.h': {
      \      'alternate': [
      \         '{}.c',
      \         '{}.cpp',
      \      ]},
		\    '*.hpp': {
      \      'alternate': [
      \         '{}.c',
      \         '{}.cpp',
      \      ],
      \ } }

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"
"
"call camelcasemotion#CreateMotionMappings('-')
let g:wordmotion_prefix = '-'



command! CtrlPSameName call feedkeys(":CtrlP\<cr>".expand('%:t:r'), "t")
nnoremap <a-o> :CtrlPSameName<cr>
set path=.,**
"horizontal split below
let g:slimv_repl_split=2


nnoremap <leader>E <Plug>(neoterm-repl-send)
nnoremap <leader>ee :TREPLSendFile<cr>
nnoremap <leader>el :TREPLSendLine<cr>
nnoremap ,repl :belowright Tnew<cr><c-w>j :exe "resize " . 13<CR>
vnoremap <leader>ee :TREPLSendSelection<cr>
let g:neoterm_repl_python="python3"
"let g:neoterm_autoinsert=1

