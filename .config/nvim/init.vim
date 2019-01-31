set tags=./tags;tags
set encoding=UTF-8
:set shell=/usr/bin/zsh
if has('vim_starting')
	set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,python"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim
"let g:fzf_command_prefix = 'fzf'
j
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


map <SPACE> <leader>

set history=1000
set mouse=a

let g:use_line_numbers=1

function! Toggle_line_numbers()
	if g:use_line_numbers
		let g:use_line_numbers=0
		set number
		set relativenumber

		" Always show line numbers, but only in current window.
		"set number
		au WinEnter * :setlocal number
		au WinEnter * :setlocal relativenumber
		au WinLeave * :setlocal norelativenumber
		au WinLeave * :setlocal number
	else
		let g:use_line_numbers=1
		set nonumber
		set norelativenumber

		" Always show line numbers, but only in current window.
		"set number
		au WinEnter * :setlocal nonumber
		au WinEnter * :setlocal norelativenumber
		au WinLeave * :setlocal norelativenumber
		au WinLeave * :setlocal nonumber
	endif
endfunction
call Toggle_line_numbers()

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"let g:textobj_entire_no_default_key_mappings=1

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set nonumber
  set norelativenumber
  set scrolloff=999
  Limelight
  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
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

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
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
nnoremap <leader>te :set shell=/usr/bin/zsh<cr>:Topen<Cr>
nnoremap <leader>to :Topen<cr>
nnoremap <leader>tt 'Ti
nnoremap <leader>so G:source %<cr>
nnoremap <leader>lime :Limelight!! 0.8<cr>
nnoremap <space><space> o<Esc>
nnoremap c "_c
"nnoremap x "_x
vnoremap < <gv
vnoremap > >gv
nnoremap K :s/,/,\r/g<CR>
nnoremap Y y$
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
"command! W :execute ':silent w !sudo tee % > /dev/null'
command! Wq :wq
"nnoremap <C-S-J> :m+<CR>==
"nnoremap <C-S-K> :m-2<CR>==
"inoremap <C-S-J> <Esc>:m+<CR>==gi
"inoremap <C-S-K> <Esc>:m-2<CR>==gi
"vnoremap <C-S-J> :m'>+<CR>gv=gv
"vnoremap <C-S-K> :m-2<CR>gv=gv
"inoremap  y/<C-R>"<CR>
nnoremap <c-w>O :tab :sp<cr>

"let &path.="/usr/include,/usr/local/include,../include,/usr/local/include/opencv2"
nnoremap <Leader>cn :cn<cr>
nnoremap <Leader>cN :cN<cr>
nnoremap <Leader>sde :set spell<cr>:set spelllang=de<cr>
nnoremap <Leader>sen :set spell<cr>:set spelllang=en<cr>
"inoremap <expr> <CR> pumvisible() ? "\<C-n>" : "\<C-g>u\<CR>"

nnoremap <Leader>bp :bN<cr>
nnoremap <Leader>bn :bn<cr>
nnoremap <Leader>tp :tabprevious<cr>
nnoremap <Leader>tn :tabNext<cr>
nnoremap <Leader>tab :tabnew<cr>
nnoremap <Leader>tc :tabclose<cr>
nnoremap <Leader>nt :NERDTreeToggle<cr>
nnoremap <Leader>nf :NERDTreeFind<cr>
let g:NERDTreeShowIgnoredStatus = 1
nnoremap <Leader>oo :only<cr>
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
"nmap <silent> <C-k> :lprevious<cr>
"nmap <silent> <C-j> :lnext<cr>
nmap <silent> <C-k> [m<cr>
nmap <silent> <C-j> ]m<cr>
nmap <silent> <C-a-k> <Plug>GitGutterPrevHunk
nmap <silent> <C-a-j> <Plug>GitGutterNextHunk
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap <silent> <leader>bl :BLines<cr>
"nmap <Leader>ag :GonvimFuzzyAg

set wrap
set linebreak
set nolist  " list disables linebreak
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

"nnoremap <c-r><c-r> vap:TREPLSendSelection<cr>
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
"vnoremap jk <Esc>
smap <c-n> <Esc>a<tab>
"smap <c-t> <Esc>a<s-tab>
"snoremap <c-u> <Esc>a<tab>

call plug#begin('~/.local/share/nvim/plugged')
    "Plug 'google/vim-maktaba'
    "Plug 'bazelbuild/vim-bazel'
    Plug 'jason0x43/vim-wildgitignore' 
    "Plug 'AndrewRayCode/vim-git-conflict-edit' 
    Plug 'markonm/traces.vim' 
    Plug 'jceb/vim-orgmode'
    Plug 'theHamsta/vim-template'
	Plug 'editorconfig/editorconfig-vim'
	Plug 'LeafCage/yankround.vim'
	Plug 'sgur/ctrlp-extensions.vim'
	Plug 'tacahiroy/ctrlp-funky'
	Plug 'mileszs/ack.vim'
	Plug 'justinmk/vim-gtfo'
	Plug 'neomake/neomake'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'fatih/vim-go', { 'for': 'go' }
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }
	"Plug 'jreybert/vimagit'
	Plug 'vhdirk/vim-cmake'
	Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }
	Plug 'tpope/vim-dispatch'
	Plug 'vim-scripts/SearchComplete'
	"Plug 'dbeniamine/cheat.sh-vim'
	"Plug 'libclang-vim/libclang-vim', {'do' : 'make'}
	"Plug 'libclang-vim/vim-textobj-clang'
	Plug 'sakhnik/nvim-gdb'
	Plug 'tpope/vim-abolish'
	Plug 'mhinz/neovim-remote'
	Plug 'mbbill/undotree', { 'on':  [ 'UndotreeToggle'] }
	Plug 'bronson/vim-visual-star-search'
	Plug 'ryanoasis/vim-devicons'
	Plug 'airblade/vim-gitgutter'
	Plug 'kana/vim-textobj-user'
    Plug 'theHamsta/vim-textobj-entire'
	Plug 'sgur/vim-textobj-parameter'
	"Plug 'glts/vim-textobj-comment'
	Plug 'kana/vim-textobj-function'
	Plug 'fvictorio/vim-textobj-backticks'
	Plug 'Julian/vim-textobj-variable-segment'
	Plug 'terryma/vim-expand-region'
	Plug 'terryma/vim-expand-region'
	Plug 'thalesmello/vim-textobj-methodcall'
	Plug 'tpope/vim-eunuch'
	Plug 'chaoren/vim-wordmotion'
	Plug 'tpope/vim-unimpaired' 
	"Plug 'ronakg/quickr-preview.vim'
	Plug 'kassio/neoterm'
	Plug 'airblade/vim-rooter'
	Plug 'bkad/CamelCaseMotion'
	Plug 'Olical/vim-enmasse'
	Plug 'akiyosi/gonvim-fuzzy'
	Plug 'AndrewRadev/switch.vim'
	Plug 'kien/rainbow_parentheses.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'machakann/vim-swap'
	Plug 'justinmk/vim-sneak'
	Plug 'Shougo/echodoc.vim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'jpalardy/vim-slime'
	Plug 'kovisoft/slimv'
	Plug 'machakann/vim-highlightedyank'
	Plug 'scrooloose/nerdtree', { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
	Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
	Plug 'ivalkeen/nerdtree-execute', { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
	Plug 'equalsraf/neovim-gui-shim'
	Plug 'michaeljsmith/vim-indent-object'
	Plug 'Chun-Yang/vim-action-ag'
	Plug 'easymotion/vim-easymotion'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'junegunn/goyo.vim'
	"Plug 'amix/vim-zenroom2'
	"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}, 'for': ['java']}
	Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }

	if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/deoplete.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif

	Plug 'rbonvall/snipmate-snippets-bib'
	Plug 'Shougo/vimproc.vim', {'do' : 'make'}
	Plug 'idanarye/vim-vebugger'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-repeat'
	Plug 'garbas/vim-snipmate'
	Plug 'burke/matcher'
	Plug 'scrooloose/nerdcommenter'
	Plug 'MarcWeber/vim-addon-mw-utils'
	Plug 'tomtom/tlib_vim'
	Plug 'theHamsta/vim-snippets'
	Plug 'altercation/vim-colors-solarized'
	Plug 'majutsushi/tagbar'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'rliang/nvim-pygtk3', {'do': 'make install'}
	Plug 'lervag/vimtex', { 'for': 'tex' }
    "Plug 'w0rp/ale', { 'for': 'tex' }
	"Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

	"Plug 'lionawurscht/deoplete-biblatex', { 'for': 'tex' }
	Plug 'beloglazov/vim-online-thesaurus'
	Plug 'wellle/targets.vim'
	Plug 'fszymanski/deoplete-emoji'
	"
	"Plug 'rkulla/pydiction'
	"Plug 'xolox/vim-misc'
	"Plug 'Shougo/neosnippet.vim'
	"Plug 'Shougo/neosnippet-snippets'

    "Colors
	Plug 'rakr/vim-one'
	Plug 'icymind/NeoSolarized'
    Plug 'junegunn/seoul256.vim'
	"Plug 'arzg/seoul8.vim'
call plug#end()



let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources#clang#executable='/usr/bin/clang'

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

iabbrev imageing imaging

autocmd FileType cpp iabbrev <buffer> firend friend
autocmd FileType cpp iabbrev <buffer> flaot float
autocmd FileType cpp iabbrev <buffer> _std std::
autocmd FileType cpp iabbrev <buffer> stirng string
"set autochdir
autocmd BufEnter * silent! lcd %:p:h
nnoremap gf gF
nnoremap gF <c-w>wgf
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.log,*/CMakeFiles/*,*.aux,*.lof,*.lot,*.gz,*.fls,*.fdb_latexmk,*.toc,__*__,*/pybind11/*,*[0-9]+

set lazyredraw
set ttyfast

map <space><space>l <plug>(easymotion-lineforward)
map <space><space>j <plug>(easymotion-j)
map <space><space>k <plug>(easymotion-k)
map <space><space>h <plug>(easymotion-linebackward)
let g:easymotion_smartcase = 1
let g:easymotion_smartsign = 1

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_keys='hklyuiopnm,qwertzxcvbasdgjf'

nmap <Leader>gs :Gstatus<CR>
nmap <Leader>ga :Gw<CR>
nmap <Leader>gw :Gw<CR>
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

"inoremap <expr><cr> pumvisible() ? "\<c-n>" : "\<cr>"

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
nnoremap <F3> :wa<cr>:exec 'T' expand($last_execution,1)<cr>
autocmd FileType python nnoremap <buffer> <F6> :VBGstartPDB3 %<cr>
autocmd FileType python nnoremap <buffer> <space>deb :VBGstartPDB3 %<cr>
autocmd FileType python nnoremap <buffer> <c-f5> :VBGcontinue %<cr>
autocmd FileType python nnoremap <buffer> <F7> :VBGcontinue<cr>
autocmd FileType python nnoremap <buffer> <F9> :VBGtoggleBreakpointThisLine<cr>
autocmd FileType python nnoremap <buffer> <c-a-b> :VBGtoggleBreakpointThisLine<cr>
autocmd FileType python nnoremap <buffer> <F10> :VBGstepOver<cr>
autocmd FileType python nnoremap <buffer> <F11> :VBGstepIn<cr>
autocmd FileType python nnoremap <buffer> <F12> :VBGstepOver<cr>
nnoremap <leader>tt :<c-u>exec v:count.'T'
autocmd FileType python nnoremap <buffer> <F5> :let $last_execution='python3 ' . expand('%:p',1)<cr>:wa<cr>:T python3 %<cr>
autocmd FileType cpp nnoremap <buffer> <F5> :let $last_execution='./build/' . expand('%:r',1)<cr>:wa<cr>:CMake<cr>:Neomake!<cr>:exec 'T' expand($last_execution,1)<cr>
autocmd FileType cpp nnoremap <buffer> <F3> :wa<cr>:CMake<cr>:Neomake!<cr>:exec 'T' expand($last_execution,1)<cr>
" jump to the previous function
autocmd FileType cpp nnoremap <buffer> <c-k> :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
" jump to the next function
autocmd FileType cpp nnoremap <buffer> <c-j> :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>
"autocmd FileType cpp nnoremap <buffer> <F5> :let $last_execution='
":let last_execution=@%<cr>
"
"nnoremap <F3> :T !!<cr>

autocmd FileType lua nnoremap <buffer> <F5> :exec '!lua' shellescape(@%:p, 1)<cr>:let last_execution=@%:p <cr>

autocmd FileType tex,latex nnoremap <buffer> <c-s> mzgg=G`z:w<cr>zz
autocmd FileType tex,latex call neomake#configure#automake('w')
"<cr>:e

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


"imap <C-J> <Plug>snipMateNextOrTrigger
"smap <C-J> <Plug>snipMateNextOrTrigger
imap <C-j> <Plug>snipMateTrigger
smap <C-j> <Plug>snipMateTrigger
smap <s-tab> <Plug>snipMateBack
imap <s-tab> <Plug>snipMateBack

let g:vlime_leader = ","
let g:vlime_enable_autodoc = v:true
let g:vlime_window_settings = {'sldb': {'pos': 'belowright', 'vertical': v:true}, 'inspector': {'pos': 'belowright', 'vertical': v:true}, 'preview': {'pos': 'belowright', 'size': v:null, 'vertical': v:true}}
let g:gonvim_draw_statusline = 1


    "\ 'cpp': ['clangd'],
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ 'lua': ['lua-lsp'],
    \ 'cpp': ['clangd-7'],
    \ 'lisp': ['~/.roswell/bin/cl-lsp'],
    \ 'go': ['go-langserver'],
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
nnoremap <leader>ca :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>ss :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <c-s> :call LanguageClient#textDocument_formatting()<CR>:w<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <leader>fo :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <leader>hi :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gD <c-w>v:call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>f0 :set foldlevel=0<CR> nnoremap <silent> <leader>ff :set foldlevel=99<CR>

"nmap <silent> <C-a-o> :call LanguageClient#textDocument_documentSymbol()<cr>
nmap <silent> <C-a-o> :BTags<cr>
nmap <silent> <leader>tag :Tags<cr>
nmap <silent> <c-t> :Tags<cr>

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

"nn <silent> xh :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<cr>
"nn <silent> xj :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<cr>
"nn <silent> xk :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<cr>
"nn <silent> xl :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<cr>

set foldmethod=indent
setlocal foldignore=

set foldlevel=99


command! Q :q
command! Qa :qa
"
"fu! C_init()
	  "setl formatexpr=LanguageClient#textDocument_rangeFormatting()
"endf
"au FileType c,cpp,cuda,objc :call C_init()
nnoremap <c-h> :History<Cr>
set shell=/usr/bin/zsh
noremap <Esc> <C-\><C-n>
if has('nvim')
    tnoremap jk <C-\><C-n>
    tnoremap <c-v> <C-\><C-n>pi
    tnoremap <c-`> <C-\><C-n>:cclose<cr>:lclose<cr>:Ttoggle<cr>
    tnoremap <c-s-´> <C-\><C-n>:cclose<cr>:lclose<cr>:Ttoggle<cr>
    "tnoremap <c-s-´> <C-\><C-n>:Ttoggle<cr>
    tnoremap <c-d> <C-\><C-n><c-w>c
endif
nnoremap <c-w>+ <c-w>+<c-w>+<c-w>+<c-w>+<c-w>+<c-w>+<c-w>+<c-w>+
nnoremap <c-w>- <c-w>-<c-w>-<c-w>-<c-w>-<c-w>-<c-w>-<c-w>-<c-w>-
nnoremap <c-w>< <c-w><<c-w><<c-w><<c-w><<c-w><<c-w><<c-w><<c-w><
nnoremap <c>w>> <c>w>><c>w>><c>w>><c>w>><c>w>><c>w>><c>w>><c>w>>
nnoremap <leader>tt :<c-u>exec v:count.'T'<cr>
"nnoremap <c-`> :cclose<cr>:lclose<cr>:Ttoggle<cr>
"nnoremap <c-s-´> :cclose<cr>:lclose<cr>:Ttoggle<cr>
nnoremap <c-`> :Ttoggle<cr>
nnoremap <c-s-´> :Ttoggle<cr>
let g:neoterm_default_mod='botright'
"autocmd BufWinEnter,WinEnter term://* startinsert
augroup terminal
	autocmd TermOpen * set bufhidden=hide
	autocmd TermOpen * setlocal nospell
augroup END

	"tnoremap <C-v>a <C-\><C-n>"aPi

nnoremap <a-t> :Switch<CR>

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
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
nmap gx <Plug>(neoterm-repl-send)
xmap gx <Plug>(neoterm-repl-send)
"let g:neoterm_autoinsert=1

set noshowmode
set clipboard=unnamedplus

function! GotoPython()
	let current_line = getline('.')
	let goto_file = matchstr(current_line, '\(File "\)\@<=\(.*\)\("\)\@=')
	let goto_line = matchstr(current_line, '\(line \)\@<=[0-9]*')
	execute "edit +" . goto_line . " " . goto_file
endfunction


nnoremap gP :call GotoPython()<cr>
set spell

let g:slime_target = "neovim"
let g:slime_python_ipython = 1
let g:highlightedyank_highlight_duration = 100

let g:multi_cursor_start_word_key      = '<C-n>' 
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

let g:fzf_buffers_jump = 1
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                  fzf#vim#with_preview('up:60%'),
  \                 1)

"command! -bang -nargs=* Rg
  "\ call fzf#vim#grep(
  "\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  "\    fzf#vim#with_preview('up:60%')
  "\         ,
  "\   1)

nnoremap <leader>ag :Ag<cr>
nnoremap <leader>rg :Rg<cr>
let g:LanguageClient_diagnosticsList = "Location"
let g:quickr_preview_on_cursor = 1


 function! ActivateCoc()
	 let b:deoplete_disable_auto_complete = 1
	nmap <silent> <c-k> <Plug>(coc-diagnostic-prev)
	nmap <silent> <c-j> <Plug>(coc-diagnostic-next)
	 nmap <silent> gd <Plug>(coc-definition)
	 nmap <silent> gD <c-w>v<Plug>(coc-definition)
	 nmap <silent> gt <Plug>(coc-type-definition)
	 nmap <silent> gT <c-w>v<Plug>(coc-type-definition)
	 nmap <silent> gi <Plug>(coc-implementation)
	 nmap <silent> gI <c-w>v<Plug>(coc-implementation)
	 nmap <silent> gr <Plug>(coc-references)
	 nmap <silent> gh :call CocAction('doHover')<cr>
	 nmap <silent> <c-s> :call CocAction('format')<cr>
	 vmap <leader>a  <Plug>(coc-codeaction-selected)
	 nmap <leader>a  <Plug>(coc-codeaction-selected)
 endfunction()

 augroup LSP
   autocmd!
   autocmd FileType java call ActivateCoc()
 augroup END

 "inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

 let g:LanguageClient_hasSnippetSupport = 1


 set autoread
 "au FocusLost,WinLeave * :silent! noautocmd w
 "
 imap <c-x><c-k> <plug>(fzf-complete-word)
 imap <c-x><c-f> <plug>(fzf-complete-path)
 imap <c-x><c-j> <plug>(fzf-complete-file-ag)
 imap <c-x><c-l> <plug>(fzf-complete-line)

 let g:fzf_tags_command = 'ctags -R .'
 let g:echodoc#enable_at_startup = 1
 let g:echodoc#type = 'signature'

set shortmess+=c
nnoremap <leader>yp :let @+ = expand("%:p")<cr>
let g:rooter_change_directory_for_non_project_files = ''

let g:livepreview_previewer = 'okular'

nnoremap <leader>date :r!date<cr>
nnoremap ,lv :VimtexView<cr>
nnoremap ,lc :VimtexCompile<cr>
nnoremap <leader>zen :Goyo<cr>
nnoremap <leader>buf :Buffers<cr>
nnoremap <leader>save :saveas 


let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_compiler_progname = 'nvr'
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
"colorscheme NeoSolarized
"set background=dark
"let g:neosolarized_contrast = "high"
"

" ʕ◔ϖ◔ʔ Gonvim setting
if exists('g:gonvim_running')
	set title
	set whichwrap=b,s,h,l
	set mouse=a
	set ignorecase
	set inccommand=split
	let mapleader = "\<Space>"
	nnoremap <Esc><Esc> :nohlsearch<CR>
  " ʕ◔ϖ◔ʔ Use Gonvim UI instead of vim native UII
  set laststatus=0
  set noshowmode
  set noruler
  let g:airline#extensions#bufferline#enabled = 0

  " ʕ◔ϖ◔ʔ I use `ripgrep` for :GonvimFuzzyAg
  let g:gonvim_fuzzy_ag_cmd = 'rg --column --line-number --no-heading --color never'

  " ʕ◔ϖ◔ʔ Mapping for gonvim-fuzzy
  nnoremap <leader><leader> :GonvimWorkspaceNew<CR>
  "nnoremap <leader>n :GonvimWorkspaceNext<CR>
  "nnoremap <leader>p :GonvimWorkspacePrevious<CR>
  nnoremap <leader>ff :GonvimFuzzyFiles<CR>
  nnoremap <leader>ag :GonvimFuzzyAg<CR>
  nnoremap <leader>buf :GonvimFuzzyBuffers<CR>
  nnoremap <leader>bl :GonvimFuzzyBLines<CR>
endif
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_exit_from_visual_mode=0

"let g:airline_theme='papercolor'
"set background=light
"tpope/vim-dispatchcolorscheme PaperColor
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : 'i',
    \ "Unknown"   : "?"
    \ }

let NERDTreeRespectWildIgnore=1
let g:tex_flavor = "latex"

let g:rooter_silent_chdir = 1
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <leader>yy :CtrlPYankring<cr>
nnoremap <leader>co :Commands<cr>
nnoremap ,c :Commands<cr>
nnoremap ,, :BLines<cr>

let g:neoterm_autoinsert=0
let g:neoterm_autoscroll=1
let g:neoterm_size='15'
"g:neoterm_fixedsize

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

"let g:seoul256_background = 0
"colo seoul256
"let g:seoul256_srgb = 1

"smart case for sneak
let g:sneak#use_ic_scs = 1

"let $FZF_BIBTEX_CACHEDIR = 'PATH-TO-CACHE-DIR'
let $FZF_BIBTEX_SOURCES = 'references.bib'

function! s:bibtex_cite_sink(lines)
    let r=system("bibtex-cite ". globpath('.', '*.bib', a:lines)
    execute ':normal! i' . r
endfunction

function! s:bibtex_markdown_sink(lines)
    let r=system("bibtex-markdown ", a:lines)
    execute ':normal! i' . r
endfunction

function! s:bibtex_cite_sink_insert(lines)
    let r=system("bibtex-cite ", a:lines)
    execute ':normal! i' . r[1:]
    call feedkeys('a', 'n')
endfunction

nnoremap ,cite :call fzf#run({
                        \ 'source': 'bibtex-ls ' ,
                        \ 'sink*': function('<sid>bibtex_markdown_sink'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --multi --prompt "Cite>"' })<CR>
inoremap <silent> @@ <c-g>u<c-o>:call fzf#run({
                        \ 'source': 'bibtex-ls',
                        \ 'sink*': function('<sid>bibtex_cite_sink_insert'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --multi --prompt "Cite> "'})<CR>
