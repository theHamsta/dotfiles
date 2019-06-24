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

let g:use_line_numbers=0

function! Toggle_line_numbers()
	if g:use_line_numbers
		let g:use_line_numbers=0
		set number
		set relativenumber

		" Always show line numbers, but only in current window.
		"set number
		"au WinEnter * :setlocal number
		"au WinEnter * :setlocal relativenumber
		"au WinLeave * :setlocal norelativenumber
		"au WinLeave * :setlocal number
	else
		let g:use_line_numbers=1
		set nonumber
		set norelativenumber

		" Always show line numbers, but only in current window.
		""set number
		"au WinEnter * :setlocal nonumber
		"au WinEnter * :setlocal norelativenumber
		"au WinLeave * :setlocal norelativenumber
		"au WinLeave * :setlocal nonumber
	endif
endfunction
call Toggle_line_numbers()


function! ConfigSlurmTerm()
    let l:term_id = b:terminal_job_id
    execute SlimeConfig
    execute 
endfunction
command! GetTermJobId echo b:terminal_job_id



"au! WinEnter * SemanticHighlight

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"let g:textobj_entire_no_default_key_mappings=1

function! s:goyo_enter()
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
nnoremap <leader>so :w<cr>G:source %<cr>
nnoremap <leader>lime :Limelight!! 0.8<cr>
nnoremap <space><space> o<Esc>
nnoremap c "_c
"nnoremap x "_x
vnoremap < <gv
vnoremap > >gv
nnoremap K :s/,/,\r/g<CR>
nnoremap Y y$
nnoremap y "+y
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
  "let g:NERDTreeShowIgnoredStatus = 1
nnoremap <Leader>oo :only<cr>
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader><C-k> :lprevious<cr>
nmap <silent> <leader><C-j> :lnext<cr>
"nmap <silent> <C-k> [m<cr>
"nmap <silent> <C-j> ]m<cr>
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
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

call plug#begin('~/.local/share/nvim/plugged')
    "
    "Plug 'google/vim-maktaba'
    "Plug 'bazelbuild/vim-bazel'
    "Plug 'jason0x43/vim-wildgitignore' 
    "Plug 'jaxbot/github-issues.vim'
    Plug 'adolenc/cl-neovim'
    "Plug 'baskerville/bubblegum'
    Plug 'tpope/vim-rhubarb'
    Plug 'SirVer/ultisnips'
    "Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'mcchrish/nnn.vim'
    Plug 'pboettch/vim-cmake-syntax'
    Plug 'mhinz/vim-startify'
    "Plug 'tpope/vim-endwise'
    "Plug 'lambdalisue/vim-gista'
    "Plug 'lambdalisue/gina.vim'
    "Plug 'hotwatermorning/auto-git-diff'
    "Plug 'rhysd/committia.vim'
    Plug 'junegunn/gv.vim'
    Plug 'idanarye/vim-merginal'
    Plug 'moll/vim-bbye'
    Plug 'roblillack/vim-bufferlist'
    Plug 'mhinz/vim-janah'
    "Plug 'cyansprite/Extract'
    "Plug 'wbthomason/buildit.nvim'
    "Plug 'Shougo/neosnippet.vim'
    "Plug 'heavenshell/vim-pydocstring'
    "Plug 'Vigemus/iron.nvim'
    "Plug 'rhysd/reply.vim'
    Plug 'henrynewcomer/vim-theme-papaya'
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-sleuth'
    Plug 'meain/vim-package-info', { 'do': 'npm install' }
    "Plug 'mattboehm/vim-accordion'
    Plug 't9md/vim-choosewin'
    "Plug 'HiPhish/ncm2-vlime' ", {'for' : ['lisp']}
    "Plug 'ncm2/ncm2', {'for' : ['lisp']}
    "Plug 'ncm2/ncm2-bufword', {'for' : ['lisp']}
    "Plug 'ncm2/ncm2-path', {'for' : ['lisp']}
    "Plug 'ncm2/ncm2-ultisnips'
        "Plug 'roxma/nvim-yarp'
    "Plug 'Vigemus/iron.nvim'
    "Plug 'ncm2/ncm2', { 'for' : ['lisp']}
    Plug 'rliang/termedit.nvim'
    Plug 'whiteinge/diffconflicts'
    Plug 'peterhoeg/vim-qml', { 'for' : 'qml' }
    Plug 'bfrg/vim-cpp-modern'
    ""Plug 'mgedmin/python-imports.vim'
    Plug 'skywind3000/vim-preview'
    Plug 'rhysd/rust-doc.vim'
    Plug 'janko/vim-test'
    Plug 'dyng/ctrlsf.vim'
    ""Plug 'Raimondi/delimitMate'
    "Plug 'mhartington/oceanic-next'
    Plug 'Valloric/ListToggle'
    "Plug 'SammysHP/vim-heurindent'
    Plug 'dbeniamine/cheat.sh-vim', { 'on':  [ 'Cheat!'] }
    Plug 'cespare/vim-toml', {'for': 'toml'}
    Plug 'maralla/vim-toml-enhance', {'for': 'toml'}
    Plug 'tpope/vim-markdown'
    "Plug 'pboettch/vim-highlight-cursor-words'
    Plug 'jaxbot/semantic-highlight.vim'
    Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    "Plug 'Valloric/vim-operator-highlight'
    "Plug 'hiphish/jinja.vim'
    "Plug 'thaerkh/vim-workspace'
    Plug 'brooth/far.vim'
    "Plug 'xolox/vim-misc'
    "Plug 'xolox/vim-easytags'
    Plug 'rking/ag.vim'
    "Plug 'vim-pandoc/vim-pandoc'
    "Plug 'vim-pandoc/vim-pandoc-syntax'
    "Plug 'puremourning/vimspector'
    Plug 'romainl/Apprentice'
    "Plug 'vim-scripts/cmake.vim-syntax'
    "Plug 'Vigemus/iron.nvim'
    "Plug 'tpope/vim-obsession'
    "Plug 'dhruvasagar/vim-prosession'
    "Plug 'jalcine/cmake.vim'
    "Plug 'xolox/vim-session'
    "Plug 'AndrewRayCode/vim-git-conflict-edit' 
    Plug 'markonm/traces.vim' 
    Plug 'jceb/vim-orgmode'
    Plug 'theHamsta/vim-template'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'LeafCage/yankround.vim'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'sgur/ctrlp-extensions.vim'
    Plug 'tacahiroy/ctrlp-funky'
    Plug 'mileszs/ack.vim'
    Plug 'justinmk/vim-gtfo'
    Plug 'neomake/neomake'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    "Plug 'jreybert/vimagit'
    "Plug 'vhdirk/vim-cmake'
    Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }
    Plug 'tpope/vim-dispatch'
    Plug 'vim-scripts/SearchComplete'
    "Plug 'dbeniamine/cheat.sh-vim'
    "Plug 'libclang-vim/libclang-vim', {'do' : 'make'}
    "Plug 'libclang-vim/vim-textobj-clang'
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
    Plug 'thalesmello/vim-textobj-methodcall'
    Plug 'w0rp/ale', { 'for' : [ 'cmake' ] }
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
    Plug 'machakann/vim-highlightedyank'
    Plug 'scrooloose/nerdtree' , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'Xuyuanp/nerdtree-git-plugin' , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'ivalkeen/nerdtree-execute' , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight' , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'equalsraf/neovim-gui-shim'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'Chun-Yang/vim-action-ag'
    Plug 'easymotion/vim-easymotion'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'junegunn/goyo.vim'
    Plug 'l04m33/vlime', {'rtp': 'vim/'}
    "Plug 'amix/vim-zenroom2'
    "Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}, 'for': ['java']}
    Plug 'neoclide/coc.nvim', {'do': 'yarn install', 'for': ['java', 'vim', 'yaml', 'bash','sh']}
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
    "Plug 'idanarye/vim-vebugger'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    "Plug 'garbas/vim-snipmate'
    Plug 'burke/matcher'
    Plug 'scrooloose/nerdcommenter'
    "Plug 'MarcWeber/vim-addon-mw-utils'
    "Plug 'tomtom/tlib_vim'
    Plug 'theHamsta/vim-snippets'
    "Plug 'altercation/vim-colors-solarized'
    Plug 'majutsushi/tagbar'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'rliang/nvim-pygtk3', {'do': 'make install'}
    Plug 'lervag/vimtex', { 'for': 'tex' }
    "Plug 'w0rp/ale', { 'for': 'tex' }
    "Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

    "Plug 'lionawurscht/deoplete-biblatex', { 'for': 'tex' }
    "Plug 'beloglazov/vim-online-thesaurus'
    Plug 'wellle/targets.vim'
    Plug 'fszymanski/deoplete-emoji'
    "Plug 'zchee/deoplete-go', { 'do': 'make'}
    "
    "Plug 'rkulla/pydiction'
    "Plug 'xolox/vim-misc'
    "Plug 'Shougo/neosnippet.vim'
    "Plug 'Shougo/neosnippet-snippets'

    "Colors
    Plug 'rakr/vim-one'
	"Plug 'icymind/NeoSolarized'
    "Plug 'junegunn/seoul256.vim'
	"Plug 'arzg/seoul8.vim'
    "
    "
    "Plug 'vhakulinen/gnvim-lsp'
    "Plug 'prabirshrestha/vim-lsp'
    ""Plug 'Answeror/cmakecomplete'
    "Plug 'prabirshrestha/async.vim'
    "Plug 'prabirshrestha/vim-lsp'
call plug#end()

set conceallevel=0
let g:tex_conceal='abdmg'
let g:tex_flavor='latex'

let g:deoplete#enable_at_startup = 1
call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex': g:vimtex#re#deoplete
            \})


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
nnoremap <Leader>buf :Buffers<CR>
nnoremap <a-p> :Buffers<CR>
nnoremap <Leader>dox :Dox<CR>

nnoremap <Leader>do :do<CR>
nnoremap <Leader>dp :dp<CR>

iabbrev imageing imaging

autocmd FileType cpp iabbrev <buffer> firend friend
autocmd FileType cpp iabbrev <buffer> flaot float
autocmd FileType cpp iabbrev <buffer> _std std::
autocmd FileType cpp iabbrev <buffer> stirng string
autocmd FileType class :set filetype java<cr>
"set autochdir
"autocmd BufEnter * silent! lcd %:p:h
nnoremap gf gF
nnoremap gF <c-w>gF
nnoremap gP :call GotoPython()<cr>

set wildignore+=_minted-*,*/tmp/*,*.so,*.swp,*.zip,*.log,*/CMakeFiles/*,*.aux,*.lof,*.lot,*.gz,*.fls,*.fdb_latexmk,*.toc,__*__,*/pybind11/*,*[0-9]+,*.class,*.bak?,*.bak??,*.md5,*.snm,*.bbl,*.nav,*.out,*.run.xml,*.bcf,*.blg,*.auxlock,*.sty,*.dvi,*.glo,*.glg,*.ist

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
nmap <c-a-b> :Gblame<CR>
nmap <Leader>res:Git reset<CR>
nmap <Leader>me :MerginalToggle<CR>
nmap <Leader>gw :Gw<CR>
nmap <Leader>gc :Gcommit -v<CR>
nmap <Leader>am :Gcommit -v --amend<CR>
nmap <Leader>gv :GV<CR>
nmap <Leader>gu :Git reset -- %<CR>
nmap <Leader>gd <c-w>O:Gdiff<CR>
nmap <Leader>gl :0Glog<CR>
nmap <Leader>gr :Gread<CR>
nmap <Leader>gp :!git push<CR>
nmap <Leader>pu :!git pull<CR>
vnoremap // y/<C-R>"<CR>

let g:wordmotion_prefix = ','

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


" Set the background theme to dark
set background =dark

" Call the theme one
colorscheme one
"colorscheme papaya
let g:papaya_gui_color='blue'
"colorscheme apprentice

" Don't forget set the airline theme as well.
let g:airline_theme = 'one'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

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


nnoremap <leader>G :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><cr>

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

"let g:deoplete#sources#jedi#extra_path =['', '/usr/lib/python2.7', '/usr/lib/python2.7/plat-x86_64-linux-gnu', '/usr/lib/python27/lib-tk', '/usr/lib/python2.7/lib-old', '/usr/lib/python2.7/lib-dynload', '/home/stepha/.local/lib/python2.7/site-packages', '/usr/local/lib/python2.7/dist-packages', '/usr/li/python2.7/dist-packages', '/usr/lib/python2.7/dist-packages/PILcompat', '/usr/lib/pytho2.7/dist-packages/gtk-2.0', '/usr/lib/python2.7/dist-packages/wx-3.0-gtk2']
nnoremap <F3> :Tkill<cr>:wa<cr>:exec 'T' expand($last_execution,1)<cr>
nnoremap <s-F3> :Tkill<cr>:wa<cr>:exec expand($last_execution,1)<cr>
"autocmd FileType python nnoremap <buffer> <F6> :VBGstartPDB3 %<cr>
"autocmd FileType python nnoremap <buffer> <space>deb :VBGstartPDB3 %<cr>
"autocmd FileType python nnoremap <buffer> <c-f5> :VBGcontinue %<cr>
"autocmd FileType python nnoremap <buffer> <F7> :VBGcontinue<cr>
"autocmd FileType python nnoremap <buffer> <F9> :VBGtoggleBreakpointThisLine<cr>
"autocmd FileType python nnoremap <buffer> <c-a-b> :VBGtoggleBreakpointThisLine<cr>
"autocmd FileType python nnoremap <buffer> <F10> :VBGstepOver<cr>
"autocmd FileType python nnoremap <buffer> <F11> :VBGstepIn<cr>
"autocmd FileType python nnoremap <buffer> <F12> :VBGstepOver<cr>
"nnoremap <leader>tt :<c-u>exec v:count . 'T '
"
autocmd FileType python nnoremap <buffer> <F5> :let $last_execution='python3 ' . expand('%:p',1)<cr>:wa<cr>:T python3 %<cr>
autocmd FileType python nnoremap <buffer> <s-F5> :let $last_execution='python3 ' . expand('%:p',1)<cr>:wa<cr>:execute ':GdbStartPDB python3 -m pdb ' . expand('%:p',1)<cr>
autocmd FileType python nnoremap <buffer> <F7> :let $last_execution='python3 -m pdb -c continue ' . expand('%:p',1)<cr>:wa<cr>:T python3 -m pdb -c continue %<cr>
autocmd FileType python nnoremap <buffer> <F4> :let $last_execution='ipython3 ' . expand('%:p',1)<cr>:wa<cr>:T ipython3 %<cr>

"autocmd FileType python nmap <silent> <C-.> <Plug>(pydocstring)
"autocmd FileType cpp nnoremap <buffer> <F5> :let $last_execution='./build/' . $target<cr>:wa<cr>:CMake<cr>:Neomake!<cr>:exec 'T' expand($last_execution,1)<cr>
autocmd FileType cpp nnoremap <buffer> <F5> :let $last_execution='build.py --run'<cr>:Tkill<cr>:wa<cr>:T build.py --run<cr>
autocmd FileType cmake nnoremap <buffer> <F5> :let $last_execution='build.py --run'<cr>:Tkill<cr>:wa<cr>:T build.py --run<cr>
autocmd FileType rust nnoremap <buffer> <F5> :let $last_execution='cargo run'<cr>:Tkill<cr>:wa<cr>:T cargo run<cr>
" jump to the previous function
autocmd FileType cpp nnoremap <buffer> [f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
" jump to the next function
autocmd FileType cpp nnoremap <buffer> ]f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>
"autocmd FileType cpp nnoremap <buffer> <F5> :let $last_execution='
":let last_execution=@%<cr>
"

autocmd FileType cmake SemanticHighlight
autocmd FileType lua nnoremap <buffer> <F5> :exec '!lua' shellescape(@%:p, 1)<cr>:let last_execution=@%:p <cr>

autocmd FileType tex,latex nnoremap <buffer> <c-s> :w<cr>:silent !latexindent % -w<cr>:e<cr>
autocmd FileType tex,latex call neomake#configure#automake('w')
autocmd FileType tex,latex nnoremap <buffer> <c-a-o> :call vimtex#fzf#run()<cr>
autocmd FileType markdown nnoremap <buffer> <cr> :ComposerStart<cr>:ComposerOpen<cr>
autocmd FileType markdown nnoremap <buffer> <leader>ll :ComposerStart<cr>
autocmd FileType markdown nnoremap <buffer> <leader>lv :ComposerOpen<cr>
"autocmd FileType markdown <buffer> set conceallevel=1

"<cr>:e

let g:ag_working_path_mode="r"
"let g:deoplete#sources#jedi#python_path='/usr/bin/python3'


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
"imap <C-j> <Plug>snipMateTrigger
"smap <C-j> <Plug>snipMateTrigger
"smap <s-tab> <Plug>snipMateBack
"imap <s-tab> <Plug>snipMateBack

let g:vlime_leader = ","
let g:vlime_cl_use_terminal=v:true
let g:vlime_enable_autodoc = v:true
let g:vlime_window_settings = {'sldb': {'pos': 'belowright', 'vertical': v:true}, 'inspector': {'pos': 'belowright', 'vertical': v:true}, 'preview': {'pos': 'belowright', 'size': v:null, 'vertical': v:true}}

autocmd FileType lisp nmap <buffer> gh <localleader>do<cr>
"let g:vlime_cl_impl = "sbcl_swank"
    
if has('nvim') && !executable("ncat")
      echoerr "Vlime needs ncat!!!"
endif




let g:gonvim_draw_statusline = 1
    "\ 'cpp': ['clangd'],
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'lua': ['lua-lsp'],
    \ 'cpp': ['clangd-8'],
    \ 'cuda': ['clangd-8'],
    \ 'c': ['clangd-8'],
    \ 'go': ['bingo', '--diagnostics-style=instant'],
    \ 'python': ['pyls'],
    \ 'dockerfile': ['docker-langserver', '--stdio'],
    \ 'tex': ['java', '-jar', '~/.local/bin/texlab.jar'],
    \ 'bib': ['java', '-jar', '~/.local/bin/texlab.jar'],
    \ 'd': ['dls']
    \ }
    "\ 'sh': ['bash-language-server', 'start'],
    "\ 'tex': ['digestif']
    "\ 'vim': ['~/.yarn/bin/vim-language-server', '--stdio'],
    "\ 'lisp': ['~/.roswell/bin/cl-lsp'],
    "\ 'tex': ['java', '-jar',  '~/.local/bin/texlab.jar'],
    "\ 'bib': ['java', '-jar',  '~/.local/bin/texlab.jar'],
    "\ 'go': ['go-langserver'],
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
   "
"let g:LanguageClient_windowLogMessageLevel=2

function! LC_maps()
   if has_key(g:LanguageClient_serverCommands, &filetype)
        call deoplete#custom#option('auto_complete', v:true)
     
         if &filetype != "python" && &filetype != "tex" && &filetype != "bib" && &filetype != "go"
             autocmd CursorHold <buffer> silent call LanguageClient#textDocument_documentHighlight()
         endif

        nnoremap <buffer> <leader>la :call LanguageClient_contextMenu()<CR>
        nnoremap <buffer> <leader>le :call LanguageClient#explainErrorAtPoint()<CR>
        nnoremap <buffer> <leader>ca :call LanguageClient#textDocument_codeAction()<CR>
        nnoremap <buffer> <silent> gh :call LanguageClient#textDocument_hover()<CR>
        nnoremap <buffer> <silent> <leader>ss :call LanguageClient#textDocument_documentSymbol()<CR>
        nnoremap <buffer> <silent> <c-a-s> :call LanguageClient#textDocument_documentSymbol()<CR>
        if &filetype != "tex"
            nnoremap <buffer> <silent> <c-s> :call LanguageClient#textDocument_formatting()<CR>:w<CR>
        endif
        nnoremap <buffer> <silent> gr :call LanguageClient#textDocument_references()<CR>
        nnoremap <buffer> <silent> <leader>fo :call LanguageClient#textDocument_formatting()<CR>
        nnoremap <buffer> <silent> <leader>hi :call LanguageClient#textDocument_documentHighlight()<CR>
        nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
        nnoremap <buffer> <silent> gD <c-w>v:call LanguageClient#textDocument_definition()<CR>
        nnoremap <buffer> <silent> gt :call LanguageClient#textDocument_typeDefinition()<CR>
        nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
        try
          CocDisable
        catch

        endtry
   endif
endfunction

nmap <silent> <leader><C-k> :lprevious<cr>
nmap <silent> <leader><C-j> :lnext<cr>

autocmd FileType * call LC_maps()


nnoremap <silent> <buffer> <leader>f0 :set foldlevel=0<CR>
nnoremap <silent> <buffer> <leader>ff :set foldlevel=99<CR>
nnoremap <silent> <buffer> z0 :set foldlevel=0<CR>
nnoremap <silent> <buffer> z9 :set foldlevel=99<CR>

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
    tnoremap <c-`> <C-\><C-n>:cclose<cr>:lclose<cr>:pc<cr>:Ttoggle<cr>
    tnoremap <c-´> <C-\><C-n>:cclose<cr>:lclose<cr>:pc<cr>:Ttoggle<cr>
    "tnoremap <c-s-´> <C-\><C-n>:Ttoggle<cr>
    tnoremap <c-d> <C-\><C-n>:bd!<cr>
    tnoremap <silent> <end> <C-\><C-n><cr>:vertical Ttoggle<cr>
    nnoremap <silent> <c-`> :botright Ttoggle<cr>
    nnoremap <silent> <end> <c-w>o:vertical Ttoggle<cr>
    nnoremap <silent> <leader>py <c-w>o:vertical Ttoggle<cr>:T ipython<cr>
    nnoremap <silent> <leader>sym <c-w>o:vertical Ttoggle<cr>:T isympy<cr>
    nnoremap <c-´> :botright Ttoggle<cr>
    "nnoremap <leader>tt :<c-u>exec v:count.'T'<cr>
    nnoremap <silent> <PageDown> :cclose<cr>:lclose<cr>:pc<cr>:botright Ttoggle<cr>
    tnoremap <silent> <PageDown> <C-\><C-n><cr>:Ttoggle<cr>

endif
"nnoremap <c-`> :cclose<cr>:lclose<cr>:Ttoggle<cr>
"nnoremap <c-s-´> :cclose<cr>:lclose<cr>:Ttoggle<cr>

let g:neoterm_default_mod='rightb'
let g:neoterm_open_in_all_tabs=0
"autocmd BufWinEnter,WinEnter term://* startinsert
augroup terminal
    autocmd TermOpen * set bufhidden=hide
    "autocmd TermOpen * set syntax=cpp
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
"call camelcasemotion#CreateMotionMappings()
let g:wordmotion_prefix = '-'



command! CtrlPSameName call feedkeys(":CtrlP\<cr>".expand('%:t:r'), "t")
nnoremap <a-o> :CtrlPSameName<cr>

nnoremap <c-a-h> call feedkeys(":CtrlP\<cr>".expand('%:t:r') . ".h", "t")
set path=.,**
"horizontal split below
let g:slimv_repl_split=2


nnoremap <leader>E <Plug>(neoterm-repl-send)
nnoremap <leader>ee :TREPLSendFile<cr>
nnoremap <leader>el :TREPLSendLine<cr>
"nnoremap <c-c><c-c> :TREPLSendLine<cr>
"vnoremap <c-c><c-c> :TREPLSendSelection<cr>
nnoremap ,repl :belowright Tnew<cr><c-w>j :exe "resize " . 13<CR>
vnoremap <leader>ee :TREPLSendSelection<cr>
let g:neoterm_repl_python="ipython3"
nmap gq <Plug>(neoterm-repl-send)
"nmap <c-c> <Plug>(neoterm-repl-send)
xmap gq <Plug>(neoterm-repl-send)

set noshowmode
set clipboard=unnamedplus

function! GotoPython()
    let current_line = getline('.')
    let goto_file = matchstr(current_line, '\(File "\)\@<=\(.*\)\("\)\@=')
    let goto_line = matchstr(current_line, '\(line \)\@<=[0-9]*')
    execute "tabedit +" . goto_line . " " . goto_file
endfunction


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
command! -bang -nargs=* FuzzyAg
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
nnoremap <leader>fag :FuzzyAg<cr>
nnoremap <leader>rg :Rg<cr>
let g:LanguageClient_diagnosticsList = "Location"
"let g:quickr_preview_on_cursor = 1


 function! ActivateCoc()
     call deoplete#custom#option('auto_complete', v:false)
     autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
     if &filetype != "python" && &filetype != "tex" && &filetype != "bib" && &filetype != "go"
         autocmd  CursorHold <buffer> silent call CocActionAsync('highlight')
     endif
     "autocmd <buffer> CursorHold * silent call CocActionAsync('highlight')
     nmap <silent> <buffer>  <c-k> <Plug>(coc-diagnostic-prev)
     nmap <silent> <buffer>  <c-j> <Plug>(coc-diagnostic-next)
     nmap <silent> <buffer>  gd <Plug>(coc-definition)
     nmap <silent> <buffer>  ga :CocAction<cr>
     vmap <silent> <buffer>  ga :CocAction<cr>
     nmap <silent> <buffer>  gD <c-w>v<Plug>(coc-definition)
     nmap <silent> <buffer>  gt <Plug>(coc-type-definition)
     nmap <silent> <buffer>  gT <c-w>v<Plug>(coc-type-definition)
     nmap <silent> <buffer>  gi <Plug>(coc-implementation)
     nmap <silent> <buffer>  gI <c-w>v<Plug>(coc-implementation)
     nmap <silent> <buffer>  gr <Plug>(coc-references)
     nmap <silent> <buffer>  gh :call CocAction('doHover')<cr>
     nmap <silent> <buffer>  <c-s> :call CocAction('format')<cr>
     vmap <buffer> <leader>a   <Plug>(coc-codeaction-selected)
     nmap <buffer> <leader>a <Plug>(coc-codeaction-selected)
 endfunction()

autocmd FileType java call ActivateCoc()
autocmd FileType yaml call ActivateCoc()
autocmd FileType vim call ActivateCoc()
autocmd FileType bash,sh call ActivateCoc()
"autocmd FileType python call ActivateCoc()

 "inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

 let g:LanguageClient_hasSnippetSupport = 0


 set autoread
 "au FocusLost,WinLeave * :silent! noautocmd w
 "
 imap <c-x><c-k> <plug>(fzf-complete-word)
 imap <c-x><c-f> <plug>(fzf-complete-path)
 imap <c-x><c-j> <plug>(fzf-complete-file-ag)
 imap <c-x><c-l> <plug>(fzf-complete-line)

 let g:fzf_tags_command = 'ctags -R .'
 let g:echodoc#enable_at_startup = 1
 let g:echodoc#type = 'virtual'
 "let g:echodoc#type = 'floating'

set shortmess+=c
nnoremap <leader>yp :let @+ = expand("%:p")<cr>
let g:rooter_change_directory_for_non_project_files = ''

"let g:livepreview_previewer = 'okular'

nnoremap <leader>date :r!date<cr>
autocmd FileType tex nnoremap <buffer> ,lv :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>
autocmd FileType tex nnoremap <buffer> <cr> :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>
"autocmd FileType tex nnomap <buffer>  <cr> <leader>lv
nnoremap ,lc :VimtexCompile<cr>
nnoremap <leader>zen :Goyo<cr>
nnoremap <leader>buf :Buffers<cr>
nnoremap <leader>save :saveas 

"let g:vimtex_view_method ='zathura'
"let g:vimtex_view_general_viewer = 'zathura'
"let g:vimtex_view_general_options = '--synctex-forward @line:@col:@pdf'

"--synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . 
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
let NERDTreeWinSizeMax=50
let NERDTreeRespectWildIgnore=1
let g:tex_flavor = "latex"

let g:rooter_silent_chdir = 1
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <c-a-n> :CtrlPFunky<Cr>
nnoremap <leader>yy :CtrlPYankring<cr>
nnoremap <leader>co :Commands<cr>
nnoremap ,c :Commands<cr>
nnoremap ,, :BLines<cr>

let g:neoterm_autoinsert=0
let g:neoterm_autoscroll=1
let  g:neoterm_fixedsize =100

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
nnoremap ,gitg :!gitg&<cr>
nnoremap ,gui :!cmake-gui build<cr>

"let g:seoul256_background = 0
"colo seoul256
"let g:seoul256_srgb = 1

"smart case for sneak
let g:sneak#use_ic_scs = 1

"let $FZF_BIBTEX_CACHEDIR = 'PATH-TO-CACHE-DIR'
let $FZF_BIBTEX_SOURCES = 'references.bib'

function! s:bibtex_cite_sink(lines)
    let r=system("bibtex-cite ". globpath('.', '*.bib'), a:lines)
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
"inoremap <silent> @@ <c-g>u<c-o>:call fzf#run({
                        "\ 'source': 'bibtex-ls',
                        "\ 'sink*': function('<sid>bibtex_cite_sink_insert'),
                        "\ 'up': '40%',
                        "\ 'options': '--ansi --multi --prompt "Cite> "'})<CR>

"inoremap <silent> @yy <c-g>u<c-o>:CtrlPYankring<CR>
let g:cmake_export_compile_commands =1
let g:cmake_ycm_symlinks=1
let g:ctrlp_funky_syntax_highlight = 1

"nnoremap <c-a-p> :cd ~/projects<cr>:CtrlPMixed<cr>
nnoremap <c-a-p> :cd ~/projects<cr>:Files<cr>
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

command! -bang -nargs=? -complete=dir Files :call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <c-f> :Files<cr>
nnoremap <a-l> "zyy"zp 
nnoremap <a-h> "zyy"zP 

let g:ctrlp_switch_buffer=0


"nnoremap <F6> :call vimspector#Continue()<CR>
"nnoremap <a-b> :call vimspector#ToggleBreakpoint()<cr>
"nnoremap <F10>   :call vimspector#StepOver()<cr>
"nnoremap <F11>  :call vimspector#StepInto()<cr>
"nnoremap <s-F11>    :call vimspector#StepOut()<cr>
nnoremap <leader>id :GitGutterLineHighlightsToggle<cr>


let g:NERDTreeWinPos = "left"
set updatetime=100

let g:license="GPLv3"
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual

"nmap <leader>r <Plug>(iron-send-motion)
nmap ,code :!code-insiders -r %<cr>

"nnoremap <c-p> :CtrlPMixed<cr>
let g:ctrlp_map = ''
nnoremap <c-p> :Files .<CR>

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
    au! BufRead,BufNewFile *.cpp.tmpl set filetype=cpp
    au! BufRead,BufNewFile *.pdf_tex set filetype=tex
    au! BufRead,BufNewFile *.tikz set filetype=tex
augroup END
au! BufRead,BufNewFile *.asd set filetype=lisp

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
nmap Q @q
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'cpp', 'rust', 'java', 'go']

function! Multiple_cursors_before()
  call deoplete#custom#option('auto_complete', v:false)
endfunction
function! Multiple_cursors_after()
  call deoplete#custom#option('auto_complete', v:true)
endfunction

let g:lt_location_list_toggle_map = '<leader>qe'
let g:lt_quickfix_list_toggle_map = '<leader>ql'
"au! FileType cmake unmap <buffer> <silent> gh
"au! FileType cmake nmap <buffer> <silent> <unique> gh <Plug>CMakeCompleteHelp
nmap <leader>ch :Cheat! 


let g:netrw_browsex_viewer='xdg-open'
let g:rust_fold = 1
let g:cargo_makeprg_params = 'build'

"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"colorscheme OceanicNext

nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>n <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
set completeopt=menuone,menu,longest,preview

" Highlight (inofficial) json comments
 autocmd FileType json syntax match Comment +\/\/.\+$+

highlight LangHighlightText guibg=Black guifg=White
highlight LangHighlightWrite guibg=Black guifg=Yellow
highlight LangHighlightRead guibg=Black guifg=Red
highlight information  guifg=#737373
let g:LanguageClient_documentHighlightDisplay = {
            \      1: {
            \          "name": "Text",
            \          "texthl": "LangHighlightText",
            \      },
            \      2: {
            \          "name": "Read",
            \          "texthl": "LangHighlightRead",
            \      },
            \      3: {
            \          "name": "Write",
            \          "texthl": "LangHighlightWrite",
            \      }}
let g:LanguageClient_diagnosticsDisplay= {
            \       1: {
            \           "name": "Error",
            \           "texthl": "ALEError",
            \           "signText": "✖",
            \           "signTexthl": "ALEErrorSign",
            \           "virtualTexthl": "Error",
            \       },
            \       2: {
            \           "name": "Warning",
            \           "texthl": "ALEWarning",
            \           "signText": "⚠",
            \           "signTexthl": "ALEWarningSign",
            \           "virtualTexthl": "Todo",
            \       },
            \       3: {
            \           "name": "Information",
            \           "texthl": "ALEInfo",
            \           "signText": "➤",
            \           "signTexthl": "ALEInfoSign",
            \           "virtualTexthl": "Todo",
            \       },
            \       4: {
            \           "name": "Hint",
            \           "texthl": "ALEInfo",
        \           "signText": "➤",
            \           "signTexthl": "ALEInfoSign",
            \           "virtualTexthl": "Todo",
            \       },
            \   }
            \
nnoremap <leader>op :!xdg-open % &<cr>
nnoremap gX :!xdg-open % &<cr>
set signcolumn=yes
"let g:neosnippet#enable_complete_done = 1

nmap <silent> <leader>tn :wa<cr>:TestNearest<CR>
nmap <silent> <leader>tf :wa<cr>:TestFile<CR>
nmap <silent> <leader>ts :wa<cr>:TestSuite<CR>
nmap <silent> <leader>tl :wa<cr>:TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
nnoremap <leader>te :set shell=/usr/bin/zsh<cr>:Topen<Cr>
nnoremap <leader>to :Topen<cr>
nnoremap <leader>tt :T<space>
nnoremap <leader>22 :T<space>!!<enter>:T && echo ""<enter>
let test#strategy = "neoterm"


"luafile $HOME/.config/nvim/iron.lua
"nmap <Leader>gd :Gdiff<CR>
"
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

nnoremap <localleader>fzf :call vimtex#fzf#run()<cr>
if has('pumblend')
  set wildoptions=pum
  set pumblend=20
endif
let g:UltiSnipsEnableSnipMate=1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

autocmd BufReadPre *.pdf silent set ro
autocmd BufReadPre *.pdf silent %!xdg-open "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78

autocmd BufReadPre *.png silent %!xdg-open "%"
autocmd BufReadPre *.eps silent %!xdg-open "%"
autocmd BufReadPre *.jpg silent %!xdg-open "%"
autocmd BufReadPre *.bmp silent %!xdg-open "%"

nmap  <leader>ww  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 20
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

 let opts = {
        \ 'relative': 'editor',
        \ 'row': 10,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction
au FileType fzf set nonu nornu
"noremap <c-j> <c-w>w
"noremap <c-k> <c-w>W

let g:gitgutter_sign_added = '▋'
let g:gitgutter_sign_modified = '▐'
"let g:gitgutter_sign_removed = '▋'
"let g:gitgutter_sign_removed_first_line = '▋'
let g:gitgutter_sign_modified_removed = '▐_'
"inoremap <silent> __ __<c-r>=UltiSnips#Anon('_{$1}$0', '__', '', 'i')<cr>
nnoremap <leader>bd :Bdelete<cr>
nmap <silent> <leader>li :call BufferList()<CR>

let g:markdown_composer_autostart = 0
"hi BlackBg guibg=black
"au TermOpen * :set winhighlight=Normal:BlackBg
"au FileType fzf set winhighlight=Normal:Normal

"!git rev-list --all | xargs git grep 
"
"au BufHidden term://* :set winhighlight=Normal:Normal

let g:gista#client#default_username='theHamsta'
let g:wordmotion_mappings = {
\ 'w' : '<M-w>',
\ 'b' : '<M-b>',
\ 'e' : '<M-e>',
\ 'ge' : 'g<M-e>',
\ 'aw' : 'a<M-w>',
\ 'iw' : 'i<M-w>',
\ '<C-R><C-W>' : '<C-R><M-w>'
\ }

"autocmd ColorScheme janah highlight Normal ctermbg=235
"colorscheme janah

let g:startify_padding_left = 50
let g:neoterm_term_per_tab =1
set cursorline

 "Disable default mappings
 let g:nnn#set_default_mappings = 0

 " Then set your own
 nnoremap <silent> <leader>NN :NnnPicker<CR>


 " Or override
 " Start nnn in the current file's directory

 
function! NNN()
   NnnPicker '%:p:h'
   "tunmap jk
   "nnoremap q :tre
endfunction

nnoremap <leader>nn :call NNN()<cr>

nnoremap <leader>ps :PreviewSignature<cr>
nnoremap <leader>pt :PreviewTag<cr>
nnoremap <leader>pf :PreviewFile<cr>
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit set bufhidden=delete
endif
