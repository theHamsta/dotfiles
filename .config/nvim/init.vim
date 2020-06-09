set tags=./tags,tags
set encoding=UTF-8
if has('vim_starting')
    set nocompatible               " Be iMproved
endif

let g:paredit_leader=','
let g:rooter_patterns = ['gitmodules', '.git', '.git/']
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,python"
let g:vim_bootstrap_editor = "nvim"             " nvim or vim
"let g:fzf_command_prefix = 'fzf'
let g:sexp_insert_after_wrap = 0

let g:LanguageClient_settingsPath = expand('~').'.config/nvim/settings.json'


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

let g:xcodedark_green_comments = 1
let g:xcodedark_emph_funcs = 1
let g:xcodedark_emph_idents = 1

map <SPACE> <leader>

set history=1000
set mouse=a
set splitbelow
set splitright
set smartcase
set ignorecase
set spell
set bufhidden=hide
set signcolumn=yes
set noshowmode
set shortmess+=c
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
nnoremap <space><space> o<Esc>
nnoremap c "_c
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
"nnoremap <C-S-J> :m+<CR>==
"nnoremap <C-S-K> :m-2<CR>==
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
"inoremap <expr> <CR> pumvisible() ? "\<C-n>" : "\<C-g>u\<CR>"

nnoremap <Leader>bp :bN<cr>
nnoremap <Leader>bn :bn<cr>
nnoremap <Leader>tab :tabnew<cr>
nnoremap <Leader>tc :tabclose<cr>
  "let g:NERDTreeShowIgnoredStatus = 1
nnoremap <Leader>oo :only<cr>
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> [L
nmap <silent> <C-j> ]L
"nmap <silent> <C-k> [m<cr>
"nmap <silent> <C-j> ]m<cr>
nmap <leader>bl :BLines<cr>
"nmap <Leader>ag :GonvimFuzzyAg

set nowrap
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

augroup NvimTreesitter
augroup END
 
call plug#begin('~/.local/share/nvim/plugged')
    "Plug 'beloglazov/vim-online-thesaurus'
    "Plug 'garbas/vim-snipmate'
    "Plug 'idanarye/vim-vebugger'
    "Plug 'lionawurscht/deoplete-biblatex', { 'for': 'tex' }
    "Plug 'MarcWeber/vim-addon-mw-utils'
    "Plug 'tomtom/tlib_vim'
    "Plug 'w0rp/ale', { 'for': 'tex' }
    "Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    "Plug 'wellle/context.vim'
    "Plug 'rhysd/vim-crystal'
    "Plug 'vigoux/LanguageTool.nvim'
    "Plug 'rhysd/vim-grammarous'
    "Plug 'chuling/vim-equinusocio-material'
    Plug 'mfussenegger/nvim-jdtls'
    Plug 'theHamsta/nvim-dap', { 'branch' : 'fork' }
    "Plug 'haorenW1025/diagnostic-nvim'
    "Plug 'nvim-treesitter/highlight.lua'
    "Plug 'kyazdani42/nvim-palenight.lua'
    Plug 'theHamsta/nvim-treesitter'
    "Plug 'romgrk/todoist.vim', { 'do': 'UpdateRemotePlugins' }
    "Plug 'nvim-treesitter/completion-treesitter'
    "Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    "Plug 'dm1try/git_fastfix'
    "Plug 'wookayin/vim-autoimport'
    "Plug 'svermeulen/vim-easyclip'
    Plug 'rafcamlet/nvim-luapad'
    Plug 'theHamsta/nvim_rocks', {'do': 'pip3 install --user hererocks && hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua'}
    "Plug 'haorenW1025/completion-nvim'
    "Plug 'vigoux/completion-treesitter'
    "Plug 'chrisbra/unicode.vim'
    "Plug 'bergercookie/vim-deb-preview'
    "Plug 'doums/coBra'
    "Plug 'zoxves/LightningFileExplorer'
    Plug 'theHamsta/nvim-tree.lua', {'branch': 'exa'}
    "Plug 'mcchrish/info-window.nvim'
    "Plug 'gluon-lang/vim-gluon'
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    "Plug 'OmniSharp/omnisharp-vim'
    "Plug 'neomake/neomake' ", {'for': 'rst'}
    "Plug 'SkyLeach/pudb.vim'
    "Plug 'romgrk/searchReplace.vim'
    "Plug 'dbridges/vim-markdown-runner'
    "Plug 'arzg/vim-colors-xcode'
    "Plug 'Olical/nvim-local-fennel'
    "Plug 'bakpakin/fennel.vim'
    "Plug 'Olical/aniseed'
    ""Plug 'camspiers/lens.vim'
    "Plug 'camspiers/animate.vim'
    "Plug 'AndrewRadev/splitjoin.vim'
    "Plug 'wincent/vcs-jump'
    Plug 'neovim/nvim-lsp'
    Plug 'tikhomirov/vim-glsl'
    "Plug 'itchyny/calendar.vim'
    Plug 'norcalli/nvim.lua'
    Plug 'tpope/vim-speeddating'
    "Plug 'kchmck/vim-coffee-script'
    "Plug 'arzg/vim-rust-syntax-ext'
    "Plug 'atelierbram/vim-colors_atelier-schemes'
    Plug 'Shougo/deoplete-lsp'
    "Plug 'wellle/context.vim'
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
    Plug 'udalov/kotlin-vim'
    "Plug 'glacambre/firenvim'
    "Plug 'rhysd/accelerated-jk'
    "Plug  'lambdalisue/suda.vim'
    Plug  'szymonmaszke/vimpyter'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'voldikss/vim-floaterm'
    Plug 'kkoomen/vim-doge'
    "Plug 'ncm2/float-preview.nvim'
    "Plug 'liquidz/vim-iced', {'for': 'clojure'}
    "Plug 'liquidz/iced-nrepl', {'for': 'clojure'}
    "Plug 'kamykn/CCSpellCheck.vim'
    Plug 'AndrewRadev/switch.vim'
    "Plug 'Chun-Yang/vim-action-ag'
    "Plug 'JuliaEditorSupport/julia-vim'
    Plug 'Julian/vim-textobj-variable-segment'
    "Plug 'KabbAmine/vCoolor.vim'
    "Plug 'LeafCage/yankround.vim'
    "Plug 'Olical/vim-enmasse'
    Plug 'Shougo/echodoc.vim'
    "Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    Plug 'SirVer/ultisnips'
    Plug 'Valloric/ListToggle'
    Plug 'airblade/vim-gitgutter'
    Plug 'airblade/vim-rooter'
    "Plug 'akiyosi/gonvim-fuzzy'
    "Plug 'arp242/jumpy.vim'
    "Plug 'bfredl/nvim-ipy',  {'on':  [ 'IPython'], 'do': ':UpdateRemotePlugins'}
    "Plug 'bfrg/vim-cpp-modern'
    "Plug 'bkad/CamelCaseMotion'
    Plug 'bronson/vim-visual-star-search'
    "Plug 'brooth/far.vim'
    "Plug 'burke/matcher'
    Plug 'cespare/vim-toml', {'for': 'toml'}
    "Plug 'chaoren/vim-wordmotion'
    "Plug 'ctrlpvim/ctrlp.vim'
    Plug 'dbeniamine/cheat.sh-vim', { 'on':  [ 'Cheat!'] }
    Plug 'dyng/ctrlsf.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer'),  'on': ':ComposerStart' }
    Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
    Plug 'junegunn/vim-emoji'
    Plug 'fszymanski/deoplete-emoji'
    Plug 'theHamsta/vlime', {'branch': 'prompt', 'rtp': 'vim/', 'for':'lisp'}
    "Plug 'kovisoft/paredit', {'for': ['lisp', 'clojure']}
    "Plug 'kovisoft/slimv', {'for': 'lisp'}
    "Plug 'fvictorio/vim-textobj-backticks'
    "Plug 'godlygeek/tabular'
    "Plug 'gregf/ultisnips-chef'
    "Plug 'heavenshell/vim-pydocstring'
    Plug 'hotwatermorning/auto-git-diff'
    Plug 'idanarye/vim-merginal'
    Plug 'ivalkeen/nerdtree-execute'   , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'Xuyuanp/nerdtree-git-plugin'  , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'scrooloose/nerdtree' , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight' , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    "Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'janko/vim-test'
    Plug 'jaxbot/semantic-highlight.vim'
    Plug 'jceb/vim-orgmode'
    "Plug 'jpalardy/vim-slime'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/gv.vim'
    Plug 'junegunn/limelight.vim'
    "Plug 'justinmk/vim-gtfo'
    "Plug 'justinmk/vim-sneak'
    "Plug 'kana/vim-textobj-function'
    Plug 'kana/vim-textobj-user'
    Plug 'kassio/neoterm'
    Plug 'kien/rainbow_parentheses.vim'
    Plug 'lervag/vimtex', { 'for': 'tex' }
    Plug 'machakann/vim-swap'
    Plug 'majutsushi/tagbar'
    Plug 'maralla/vim-toml-enhance', {'for': 'toml'}
    Plug 'markonm/traces.vim'
    Plug 'mbbill/undotree', { 'on':  [ 'UndotreeToggle'] }
    "Plug 'meain/vim-package-info', { 'do': 'npm install' }
    "Plug 'mhinz/neovim-remote'
    Plug 'mhinz/vim-startify'
    Plug 'michaeljsmith/vim-indent-object'
    "Plug 'mileszs/ack.vim'
    Plug 'moll/vim-bbye'
    "Plug 'neomake/neomake',{'for': 'rst'}
    "Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    "Plug 'pboettch/vim-cmake-syntax'
    Plug 'peterhoeg/vim-qml', { 'for' : 'qml' }
    Plug 'rbonvall/snipmate-snippets-bib'
    "Plug 'rhysd/git-messenger.vim'
    "Plug 'rhysd/rust-doc.vim'
    Plug 'rking/ag.vim'
    "Plug 'rliang/nvim-pygtk3', {'do': 'make install'}
    "Plug 'rliang/termedit.nvim'
    "Plug 'roblillack/vim-bufferlist'
    Plug 'rust-lang/rust.vim', { 'for': ['rust', 'toml'] }
    Plug 'ryanoasis/vim-devicons'
    "Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }
    Plug 'scrooloose/nerdcommenter'
    "Plug 'sebdah/vim-delve', { 'for' : 'go' }
    "Plug 'sgur/ctrlp-extensions.vim'
    Plug 'sgur/vim-textobj-parameter'
    "Plug 'shumphrey/fugitive-gitlab.vim'
    "Plug 'skywind3000/vim-preview'
    "Plug 't9md/vim-choosewin'
    "Plug 'tacahiroy/ctrlp-funky'
    "Plug 'terryma/vim-expand-region'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'thalesmello/vim-textobj-methodcall'
    Plug 'theHamsta/vim-snippets'
    Plug 'theHamsta/vim-template'
    Plug 'theHamsta/vim-textobj-entire'
    Plug 'theHamsta/vim-rebase-mode'
    "Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-markdown'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-rhubarb'
    ""Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'lisp' }
    Plug 'guns/vim-sexp', { 'for': ['lisp', 'clojure', 'scheme', 'vlime_repl'] }
    "Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    "Plug 'vim-scripts/SearchComplete'
    "Plug 'wellle/targets.vim'
    Plug 'whiteinge/diffconflicts'
    Plug 'TravonteD/luajob'
    ""Plug 'zchee/deoplete-go', { 'do': 'make'}
    ""
    ""Plug 'rkulla/pydiction'
    ""Plug 'xolox/vim-misc'
    ""Plug 'Shougo/neosnippet.vim'
""Plug 'vim-pandoc/vim-pandoc'
    ""Plug 'amix/vim-zenroom2'
    "Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile', 'for': ['bash','sh', 'cs', 'cmake', 'javascript', 'tsx']}
    ""Plug 'neoclide/coc.nvim', {'do': 'yarn install', 'for': ['java', 'vim', 'yaml', 'bash','sh', 'tex', 'bib', 'json', 'cs']}
    Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': ':T make release',
            \ }
    "Plug 'puremourning/vimspector', { 'do': 'python3 install_gadget.py --all'}

    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif


    "Plug 'Shougo/neosnippet-snippets'

    "Colors
    "Plug 'ayu-theme/ayu-vim'
    "Plug 'jaredgorski/spacecamp'
    "Plug 'kjssad/quantum.vim'
    "Plug 'romainl/Apprentice'
    ""Plug 'altercation/vim-colors-solarized'
    Plug 'rakr/vim-one'
    "Plug 'NLKNguyen/papercolor-theme'
    "Plug 'mhinz/vim-janah'
    "Plug 'https://gitlab.com/thealik/vim-harmony'
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
        "Plug 'roxma/nvim-yarp'
    "
    ""Plug 'Raimondi/delimitMate'
    ""Plug 'mgedmin/python-imports.vim'
    "Plug 'AndrewRayCode/vim-git-conflict-edit'
    "Plug 'HiPhish/ncm2-vlime' ", {'for' : ['lisp']}
    "Plug 'SammysHP/vim-heurindent'
    "Plug 'Shougo/neosnippet.vim'
    "Plug 'Valloric/vim-operator-highlight'
    "Plug 'Vigemus/iron.nvim'
    "Plug 'Vigemus/iron.nvim'
    "Plug 'Vigemus/iron.nvim'
    "Plug 'adolenc/cl-neovim'
    "Plug 'baskerville/bubblegum'
    "Plug 'bazelbuild/vim-bazel'
    "Plug 'cyansprite/Extract'
    "Plug 'dbeniamine/cheat.sh-vim'
    "Plug 'dhruvasagar/vim-prosession'
    "Plug 'glts/vim-textobj-comment'
    "Plug 'google/vim-maktaba'
    "Plug 'gu-fan/riv.vim'
    "Plug 'hiphish/jinja.vim'
    "Plug 'hotwatermorning/auto-git-diff'
    "Plug 'jalcine/cmake.vim'
    "Plug 'jason0x43/vim-wildgitignore'
    "Plug 'jaxbot/github-issues.vim'
    "Plug 'jodosha/vim-godebug'
    "Plug 'jreybert/vimagit'
    "Plug 'lambdalisue/gina.vim'
    "Plug 'lambdalisue/vim-gista'
    "Plug 'liuchengxu/vista.vim'
    "Plug 'mattboehm/vim-accordion'
    "Plug 'mcchrish/nnn.vim'
    "Plug 'mhartington/oceanic-next'
    "Plug 'ncm2/ncm2', { 'for' : ['lisp']}
    "Plug 'ncm2/ncm2', {'for' : ['lisp']}
    "Plug 'ncm2/ncm2-bufword', {'for' : ['lisp']}
    "Plug 'ncm2/ncm2-path', {'for' : ['lisp']}
    "Plug 'ncm2/ncm2-ultisnips'
    "Plug 'pboettch/vim-highlight-cursor-words'
    "Plug 'puremourning/vimspector'
    "Plug 'rhysd/committia.vim'
    "Plug 'rhysd/reply.vim'
    "Plug 'ronakg/quickr-preview.vim'
    "Plug 'thaerkh/vim-workspace'
    "Plug 'tpope/vim-dispatch'
    "Plug 'tpope/vim-endwise'
    "Plug 'tpope/vim-obsession'
    "Plug 'vhdirk/vim-cmake'
    "Plug 'vim-pandoc/vim-pandoc-syntax'
    "Plug 'vim-scripts/cmake.vim-syntax'
    "Plug 'w0rp/ale', { 'for' : [ 'cmake' ] }
    "Plug 'wbthomason/buildit.nvim'
    "Plug 'xolox/vim-easytags'
    "Plug 'xolox/vim-misc'
    "Plug 'xolox/vim-session'
    "Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    "Plug 'zchee/nvim-go', { 'do': 'make'}
call plug#end()

set conceallevel=2
""let g:tex_conceal='abdmg'
let g:tex_flavor='latex'


nnoremap <Leader>DO :diffoff!<CR>
nnoremap <Leader>dp :dp<CR>
nnoremap <Leader>do :do<CR>
nnoremap <Leader>dg :diffget<CR>
nnoremap <Leader>dt :diffthis<CR>

set wildignore+=tags,_minted-*,*.egg-info,tmp,*.so,*.swp,*.zip,*.log,*/CMakeFiles/*,*.aux,*.lof,*.lot,*.gz,*.fls,*.fdb_latexmk,*.toc,__*__,*/pybind11/*,*[0-9]+,*.class,*.bak?,*.bak??,*.md5,*.snm,*.bbl,*.nav,*.out,*.run.xml,*.bcf,*.blg,*.auxlock,*.dvi,*.glo,*.glg,*.ist

set lazyredraw
set ttyfast
set smartcase

"map <space><space>l <plug>(easymotion-lineforward)
"map <space><space>j <plug>(easymotion-j)
"map <space><space>k <plug>(easymotion-k)
"map <space><space>h <plug>(easymotion-linebackward)
"let g:easymotion_smartcase = 1
"let g:easymotion_smartsign = 1

nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gS :Gministatus<CR>
nmap <Leader>ga :Gw<CR>
nmap <c-a-b> :Gblame<CR>
nmap <Leader>res:Git reset<CR>
nmap <Leader>me :MerginalToggle<CR>
nmap <Leader>gw :Gw<CR>
nmap <Leader>gc :Gcommit -v<CR>
nmap <Leader>am :Gcommit -v --amend<CR>
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
nmap <Leader>gt :call TimeMachine()<CR>
nmap <Leader>gr :Gread<CR>
nmap <Leader>gp :GitPushAsync<CR>
nmap <Leader>gP :GitPushAsyncForce<CR>
nmap <Leader>gl :Git pull<CR>
vnoremap // y/<C-R>"<CR>



"inoremap <expr><cr> pumvisible() ? "\<c-n>" : "\<cr>"
set termguicolors     " enable true colors support
colorscheme one

nnoremap <F3> <c-w>o:Tkill<cr>:Topen<cr>:wa<cr>:exec 'T ' . g:last_execution<cr>
"nnoremap <s-F3> :Tkill<cr>:wa<cr>:exec expand(g:last_execution,1)<cr>
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
autocmd FileType tex,latex,vim setlocal foldmethod=indent
"autocmd FileType tex,latex :let  maplocalleader="<space>"
autocmd FileType rust,toml nmap <buffer> <F5> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let g:last_execution='cargo run'<cr>:Tkill<cr>:wa<cr>:T cargo run<cr>:Topen<cr>
autocmd FileType rust,toml nmap <buffer> <F7> :exec 'T cd' FindRootDirectory()<cr><c-w>o:Tkill<cr>:wa<cr>:T cargo run
autocmd FileType rust,toml nmap <buffer> <F4> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let g:last_execution='cargo build'<cr>:Tkill<cr>:Topen<cr>:wa<cr>:T cargo build<cr>:Topen<cr>
autocmd FileType rust,toml nmap <buffer> <F6> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let g:last_execution='cargo test -- --nocapture'<cr>:Tkill<cr>:Topen<cr>:wa<cr>:T cargo test -- --nocapture<cr>
autocmd FileType rust nmap <silent> <leader>tn :wa<cr>:RustTest<cr>
autocmd FileType rust nmap <silent> <leader>tN <c-w>o:wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestNearest -- --nocapture<CR>


"autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

nmap <c-a-p> :cd ~/projects<cr>:Files<cr>
nmap <a-p> :cd ~/projects<cr>:Buffers<cr>
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

autocmd FileType lua nnoremap <buffer> <c-s> ma:w<cr>:%!luafmt --stdin<cr>'azz
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


""let g:slimv_leader='<space>'
"let g:slimv_leader=','
"let g:slimv_repl_simple_eval=1

    ""\ 'clojure': ['clojure-lsp'],
    ""\ 'rust': ['rls'],
    "\ 'rust': ['rust-analyzer'],
let g:LanguageClient_serverCommands = {
    \   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
    \       using LanguageServer;
    \       using Pkg;
    \       import StaticLint;
    \       import SymbolServer;
    \       env_path = dirname(Pkg.Types.Context().env.project_file);
    \       debug = false;
    \
    \       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
    \       server.runlinter = true;
    \       run(server);
    \   '],
    \ 'haskell': ['hie-wrapper', '--lsp'],
    \ 'kotlin': ['kotlin-language-server', '.'],
    \ 'dockerfile': ['docker-langserver', '--stdio'],
    \ 'd': ['dls'],
    \ 'crystal': ['/home/stephan/projects/scry/scry/bin/scry'],
    \ 'gluon': ['gluon_language-server'],
    \ 'go': ['gopls'],
    \ }
    "\ 'lisp': ['~/.roswell/bin/cl-lsp']
    "\ 'python': ['pyls'],
    "\ 'cuda': ['clangd-11', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes'],
    "\ 'cpp': ['clangd-11', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes'],
    "\ 'c': ['clangd-11', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes'],

function! LC_maps()
   if has_key(g:LanguageClient_serverCommands, &filetype)
        call deoplete#custom#option('auto_complete', v:true)
         "if &filetype != "python" && &filetype != "tex" && &filetype != "bib"&& &filetype != "go"&& &filetype != "lua"&& &filetype != "lisp"
             "autocmd CursorHold <buffer> silent call LanguageClient#textDocument_documentHighlight()
         "endif
 "&& &filetype != "go"
      "&& &filetype != "cpp"
        nnoremap <buffer> <leader>la :call LanguageClient_contextMenu()<CR>
        nnoremap <buffer> <leader>ee :call LanguageClient#explainErrorAtPoint()<CR>
        nnoremap <buffer> <leader>ca :call LanguageClient#textDocument_codeAction()<CR>
        nnoremap <buffer> <leader>cr :call LanguageClient#textDocument_codeLens()<CR>
        nnoremap <buffer> <silent> gh :call LanguageClient#textDocument_hover()<CR>
        nnoremap <buffer> <silent> <leader>ss :call LanguageClient#textDocument_documentSymbol()<CR>
        nnoremap <buffer> <silent> <c-a-s> :call LanguageClient#textDocument_documentSymbol()<CR>
        if &filetype != "tex"
            nnoremap <buffer> <silent> <c-s> :call LanguageClient#textDocument_formatting()<CR>:w<CR>
        endif
        nnoremap <buffer> <silent> gr :call LanguageClient#textDocument_references()<CR>
        nnoremap <buffer> <silent> gi :call LanguageClient#textDocument_implementation()<CR>
        nnoremap <buffer> <silent> <leader>fo :call LanguageClient#textDocument_formatting()<CR>
        nnoremap <buffer> <silent> <leader>hi :call LanguageClient#textDocument_documentHighlight()<CR>
        nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
        nnoremap <buffer> <silent> gD <c-w>v:call LanguageClient#textDocument_definition()<CR>
        nnoremap <buffer> <silent> gt :call LanguageClient#textDocument_typeDefinition()<CR>
        nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
        nnoremap <buffer> <silent> <2-LeftMouse> :call LanguageClient#textDocument_hover()<CR>
        nnoremap <buffer> <silent> <c-2-LeftMouse> :call LanguageClient#textDocument_definition()<CR>
        try
          CocDisable
        catch

        endtry
   endif
endfunction

function! NvimLspMaps()
  nnoremap <buffer><silent> <f2>         <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <buffer><silent> gk         <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <buffer><silent> gr         <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <buffer> <silent> gd        <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <buffer><silent> gh         <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <buffer><silent> gi         <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <buffer><silent> gS         <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <buffer><silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
  vnoremap <buffer><silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap <buffer><silent> <leader>ss :lua vim.lsp.buf.workspace_symbols()<cr>
  nnoremap <buffer><silent> <leader>de :lua require'lsp-ext'.peek_definition()<cr>


  if &filetype != "tex" 
    inoremap <buffer><silent> (     <cmd>lua vim.lsp.buf.signature_help()<CR>(
  endif

  nnoremap <buffer><silent> gt    <cmd>lua vim.lsp.buf.type_definition()<CR>

  if &filetype == "java" 
    nnoremap <buffer><silent> <c-s> :w<cr><cmd>lua vim.lsp.buf.formatting();require'jdtls'.organize_imports()<cr>
  elseif &filetype == "lua" 

  else 
    nnoremap <buffer><silent> <c-s> :w<cr><cmd>lua vim.lsp.buf.formatting()<cr>
  endif
  setlocal omnifunc=v:lua.vim.lsp.omnifunc
endfunction

autocmd FileType * call LC_maps()
"autocmd FileType lua,tex,bib,java,vim,bash,sh,rust 

set foldlevel=99

nnoremap <silent> <leader>f0 :set foldlevel=0<CR>
nnoremap <silent> <leader>ff :set foldlevel=99<CR>
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

let g:neoterm_default_mod='vert'
"let g:neoterm_open_in_all_tabs=0
"autocmd BufWinEnter,WinEnter term://* startinsert
augroup terminal
    autocmd TermOpen * setlocal bufhidden=hide
    "autocmd TermOpen * set syntax=cpp
    autocmd TermOpen * setlocal nospell
    autocmd TermOpen * nmap <silent> <buffer> <c-d> :bd!<cr>
augroup END

    ""tnoremap <C-v>a <C-\><C-n>"aPi

nnoremap <a-t> :Switch<CR>

""au VimEnter * RainbowParenthesesActivate
""au Syntax * RainbowParenthesesLoadRound
""au Syntax * RainbowParenthesesLoadSquare
""au Syntax * RainbowParenthesesLoadBraces
""
""
""call camelcasemotion#CreateMotionMappings()
"let g:wordmotion_prefix = '-'



"command! CtrlPSameName call feedkeys(":CtrlP\<cr>".expand('%:t:r'), "t")
"nnoremap <a-o> :CtrlPSameName<cr>

"nnoremap <c-a-h> call feedkeys(":CtrlP\<cr>".expand('%:t:r') . ".h", "t")
"set path=.,**


"nnoremap <leader>E <Plug>(neoterm-repl-send)
"nnoremap <leader>ee :TREPLSendFile<cr>
"nnoremap <leader>el :TREPLSendLine<cr>
""nnoremap <c-c><c-c> :TREPLSendLine<cr>
""vnoremap <c-c><c-c> :TREPLSendSelection<cr>
"nnoremap ,repl :belowright Tnew<cr><c-w>j :exe "resize " . 13<CR>
"vnoremap <leader>ee :TREPLSendSelection<cr>
"let g:neoterm_repl_python="ipython3"
"nmap gq <Plug>(neoterm-repl-send)
""nmap <c-c> <Plug>(neoterm-repl-send)
"xmap gq <Plug>(neoterm-repl-send)

"set noshowmode
set clipboard=unnamedplus

"function! GotoPython()
    "let current_line = getline('.')
    "let goto_file = matchstr(current_line, '\(File "\)\@<=\(.*\)\("\)\@=')
    "let goto_line = matchstr(current_line, '\(line \)\@<=[0-9]*')
    "execute "tabedit +" . goto_line . " " . goto_file
"endfunction



"let g:slime_target = "neovim"
"let g:slime_python_ipython = 1
"let g:highlightedyank_highlight_duration = 100

"let g:multi_cursor_start_word_key      = '<C-n>'
"let g:multi_cursor_select_all_word_key = '<A-n>'
"let g:multi_cursor_start_key           = 'g<C-n>'
"let g:multi_cursor_select_all_key      = 'g<A-n>'
"let g:multi_cursor_next_key            = '<C-n>'
"let g:multi_cursor_prev_key            = '<C-p>'
"let g:multi_cursor_skip_key            = '<C-x>'
"let g:multi_cursor_quit_key            = '<Esc>'

"let g:fzf_buffers_jump = 1
"command! -bang -nargs=* FuzzyAg
  "\ call fzf#vim#ag(<q-args>,
  "\                  fzf#vim#with_preview('up:60%'),
  "\                 1)

""command! -bang -nargs=* Rg
  ""\ call fzf#vim#grep(
  ""\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  ""\    fzf#vim#with_preview('up:60%')
  ""\         ,
  ""\   1)

nnoremap <leader>ag :Ag<cr>
"nnoremap <leader>fag :FuzzyAg<cr>
nnoremap <leader>rg :Rg<cr>
let g:LanguageClient_diagnosticsList = "Location"
""let g:quickr_preview_on_cursor = 1


 function! ActivateCoc()
     call deoplete#custom#option('auto_complete', v:false)
     set completeopt +=preview
     autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
     if &filetype != "python" && &filetype != "tex" && &filetype != "bib" && &filetype != "go" && &filetype != "kotlin"&& &filetype != "kt"&& &filetype != "rust"
         autocmd  CursorHold <buffer> silent call CocActionAsync('highlight')
     endif
     "autocmd <buffer> CursorHold * silent call CocActionAsync('highlight')
     command! OI -nargs=0 :call CocAction('runCommand', 'editor.action.organizeImport')
     nmap <silent> <buffer>  <c-k> <Plug>(coc-diagnostic-prev)
     "nmap <silent> <buffer>  <leader>nt :CocCommand explorer<cr>
     "nmap <silent> <buffer>  <leader>nf :CocCommand explorer --reveal %<cr>
     nmap <silent> <buffer>  <c-j> <Plug>(coc-diagnostic-next)
     nmap <silent> <buffer>  gd <Plug>(coc-definition)
     nmap <silent> <buffer>  <leader>la :CocAction<cr>
     nmap <silent> <buffer>  <leader>ca <Plug>(coc-codeaction-selected)<cr>
     nmap <silent> <buffer> <f2> <Plug>(coc-rename)
     nmap <silent> <buffer>  gD <c-w>v<Plug>(coc-definition)
     nmap <silent> <buffer>  gt <Plug>(coc-type-definition)
     nmap <silent> <buffer>  gT <c-w>v<Plug>(coc-type-definition)
     nmap <silent> <buffer>  gi <Plug>(coc-implementation)
     nmap <silent> <buffer>  gI <c-w>v<Plug>(coc-implementation)
     nmap <silent> <buffer>  gr <Plug>(coc-references)
     nmap <silent> <buffer>  gh :call CocAction('doHover')<cr>
     nmap <buffer> <leader>qf  <Plug>(coc-fix-current)
     if &filetype != "tex" && &filetype != "bib"
     nmap <silent> <buffer>  <leader>le <Plug>(coc-codelens-action)
     nmap <silent> <buffer>  <c-s> :call CocAction('format')<cr>
   endif
     vmap <buffer> <leader>ca   <Plug>(coc-codeaction-selected)
     nmap <buffer> <leader>ca <Plug>(coc-codeaction-selected)
     "nmap <buffer> <leader>hp :CocCommand git.chunkpreview<cr>
xmap <silent> <buffer> if <Plug>(coc-funcobj-i)
xmap <silent> <buffer> af <Plug>(coc-funcobj-a)
omap <silent> <buffer> if <Plug>(coc-funcobj-i)
omap  <silent> <buffer> af <Plug>(coc-funcobj-a)
 endfunction()

autocmd FileType cmake,cs,javascript,tsx call ActivateCoc()

 ""inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_exit_from_visual_mode=0

let NERDTreeWinSizeMax=50
let NERDTreeRespectWildIgnore=1
"let g:tex_flavor = "latex"

let g:rooter_silent_chdir = 1

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
    au! BufRead,BufNewFile *.cpp.tmpl set filetype=cpp
    au! BufRead,BufNewFile *.pdf_tex set filetype=tex
    au! BufRead,BufNewFile justfile set filetype=make
    au! BufRead,BufNewFile *.tikz set filetype=tex
augroup END
au! BufRead,BufNewFile *.asd,.spacemacs set filetype=lisp

"let g:NERDTreeFileExtensionHighlightFullName = 1
"let g:NERDTreeExactMatchHighlightFullName = 1
"let g:NERDTreePatternMatchHighlightFullName = 1
"nmap Q @q
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sh', 'cpp', 'rust', 'java', 'go', 'lua', 'vim']
let g:vim_markdown_math = 1

function! Multiple_cursors_before()
  call deoplete#custom#option('auto_complete', v:false)
endfunction
function! Multiple_cursors_after()
 if &filetype != "java" && &filetype != "javascript"
  call deoplete#custom#option('auto_complete', v:true)
endif
endfunction
let g:lt_location_list_toggle_map = '<leader>ql'
let g:lt_quickfix_list_toggle_map = '<leader>qe'
""au! FileType cmake unmap <buffer> <silent> gh
""au! FileType cmake nmap <buffer> <silent> <unique> gh <Plug>CMakeCompleteHelp
nmap <leader>ch :Cheat!


"let g:netrw_browsex_viewer='xdg-open'
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
set completeopt=menuone,menu,longest,noselect

"" Highlight (inofficial) json comments
 autocmd FileType json syntax match Comment +\/\/.\+$+

highlight LangHighlightText guibg=Black guifg=White
highlight LangHighlightWrite guibg=Black guifg=Yellow
highlight LangHighlightRead guibg=Black guifg=Red
highlight LangHighlightRead guibg=Black guifg=Red
highlight information  gui=underline
highlight CocCodeLens  guifg=#FFA722
" or undercurl
highlight LspWarning   gui=underline
highlight LspError  guifg=#FF0000 gui=underline
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
            \           "texthl": "LspError",
            \           "signText": "❌",
            \           "signTexthl": "ALEErrorSign",
            \           "virtualTexthl": "Error",
            \       },
            \       2: {
            \           "name": "Warning",
            \           "texthl": "LspWarning",
            \           "signText": "⚠️",
            \           "signTexthl": "ALEWarningSign",
            \           "virtualTexthl": "Todo",
            \       },
            \       3: {
            \           "name": "Information",
            \           "texthl": "information",
            \           "signText": "🔎",
            \           "signTexthl": "ALEInfoSign",
            \           "virtualTexthl": "Todo",
            \       },
            \       4: {
            \           "name": "Hint",
            \           "texthl": "ALEInfo",
        \           "signText": "💡",
            \           "signTexthl": "ALEInfoSign",
            \           "virtualTexthl": "Todo",
            \       },
            \   }
            \

sign define LspDiagnosticsErrorSign text=❌ texthl=LspDiagnosticsError linehl= numhl=
sign define LspDiagnosticsWarningSign text=⚠️ texthl=LspDiagnosticsWarning linehl= numhl=
sign define LspDiagnosticsInformationSign text=🔎 texthl=LspDiagnosticsInformation linehl= numhl=
sign define LspDiagnosticsHintSign text=💡 texthl=LspDiagnosticsHint linehl= numhl=

"set signcolumn=yes

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

let test#strategy = "neoterm"


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

"let g:UltiSnipsEnableSnipMate=1
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

autocmd BufReadPre *.pdf silent set ro
autocmd BufReadPre *.pdf silent :T okular "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78

autocmd BufReadPre *.png silent %!xdg-open "%"
autocmd BufReadPre *.eps silent %!xdg-open "%"
autocmd BufReadPre *.jpg silent %!xdg-open "%"
autocmd BufReadPre *.bmp silent %!xdg-open "%"

"nmap  <leader>cw  <Plug>(choosewin)
"let g:choosewin_overlay_enable = 1
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
au FileType fzf setlocal nonu nornu signcolumn="no"
""noremap <c-j> <c-w>w
""noremap <c-k> <c-w>W

let g:gitgutter_sign_added = '▋'
let g:gitgutter_sign_modified = '▐'
"let g:gitgutter_sign_removed = '▋'
"let g:gitgutter_sign_removed_first_line = '▋'
let g:gitgutter_sign_modified_removed = '▐_'

if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit setlocal bufhidden=delete
  autocmd FileType gitrebase setlocal bufhidden=delete
endif

let g:email='stephan.seitz@fau.de'
let g:username='Stephan Seitz'

"let g:gitgutter_max_signs=1000

let g:rooter_patterns = ['.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
nnoremap <leader>ju :JustTargets<cr>
nnoremap <leader>JU :JustTargetsAsync<cr>


let g:auto_git_diff_disable_auto_update=1
let g:auto_git_diff_show_window_at_right=1

"function! s:setup_auto_git_diff() abort
    "nmap <buffer> <C-l> <Plug>(auto_git_diff_scroll_manual_update)
    "nmap <buffer> <C-n> <Plug>(auto_git_diff_scroll_down_half)
    "nmap <buffer> <C-p> <Plug>(auto_git_diff_scroll_up_half)
    "nmap <buffer> <enter> <Plug>(auto_git_diff_manual_update)
"endfunction
"autocmd FileType gitrebase call <SID>setup_auto_git_diff()

nmap <silent> <c-a-j> <Plug>(GitGutterNextHunk)
nmap <silent> <c-a-j> <Plug>(GitGutterNextHunk)
nmap <silent> <c-a-k> <Plug>(GitGutterPrevHunk)
nmap <silent> <leader>hs <Plug>(GitGutterStageHunk)
nmap <silent> <leader>hu <Plug>(GitGutterUndoHunk)
"nmap ]h :call NextHunkAllBuffers()<CR>
"nmap [h :call PrevHunkAllBuffers()<CR>

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

"autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
"autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
"autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>
autocmd FileType * setlocal bufhidden=hide

command! Emoji %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g





let g:gitgutter_max_signs=3000



""" Always draw sign column. Prevent buffer moving when adding/deleting sign.

"call deoplete#custom#option('auto_complete', v:true)
let g:deoplete#enable_at_startup = 1
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





"nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
"nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
"nnoremap <silent> <Left>  :call animate#window_delta_width(-25)<CR>
"nnoremap <silent> <Right> :call animate#window_delta_width(+25)<CR>

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


let g:vlime_compiler_policy={"DEBUG": 3, "SPEED": 0}


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

""nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
""
""function! JavaStartDebugCallback(err, port)
  ""execute "cexpr! 'Java debug started on port: " . a:port . "'"
  ""call vimspector#LaunchWithSettings({ "configuration": "Java Attach", "AdapterPort": a:port })
""endfunction

""function JavaStartDebug()
  ""call CocActionAsync('runCommand', 'vscode.java.startDebugSession', function('JavaStartDebugCallback'))
""endfunction

""nmap <F1> :call JavaStartDebug()<CR>
"let g:gtfo#terminals = { 'unix': 'konsole' }

nnoremap gtf :Tnew<cr>:T dolphin %:p:h 2>&1 >> /dev/null &<cr>:Tclose<cr>
""let g:vimspector_enable_mappings = 'HUMAN'

""autocmd! BufEnter vimspector.Console nnoremap <buffer> n :call vimspector#StepOver()<cr>
"""function VimspectorLaunch()
""nnoremap <s-f9> :call vimspector#ToggleBreakpoint()<cr>
""nnoremap <s-f8> :call vimspector#StepOver()<cr>
""nnoremap <f9> :call vimspector#StepInto()<cr>
""nnoremap <f10> :call vimspector#StepOut()<cr>
""nnoremap <s-f10> :call vimspector#Restart()<cr>
""nnoremap  <f11> :call vimspector#Continue()<cr>
""nnoremap <s-f11> :call vimspector#Stop()<cr>
""endfunction

"command! WorkingDirToCurrentFile cd %:p:h
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

nnoremap <Leader>nt :LuaTreeToggle<CR>
nnoremap <Leader>nf :LuaTreeFindFile<cr>:LuaTreeShow<CR>
nnoremap <Leader>nT :NERDTreeToggle<cr>
nnoremap <Leader>nF :NERDTreeFind<cr>
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
au TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 150)

"highlight NvimTreesitterCurrentNode guibg=#444400

let g:sexp_filetypes = 'clojure,scheme,lisp,timl,vlime_repl'

nmap <f1> :lua require'dap'.goto_()<cr>
"nmap <f2> :lua require'nvim-treesitter/playground'.play_with()<cr>

"nmap j <Plug>(accelerated_jk_gj)
"nmap k <Plug>(accelerated_jk_gk)

let g:markdown_composer_autostart=0

nnoremap <c-h> :History<cr>
nnoremap <c-t> :Tags<cr>
nnoremap <c-a-o> :BTags<cr>
luafile ~/.config/nvim/init.lua

fun! IgnoreCamelCaseSpell()
  syn match CamelCase /\<[A-Z][a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  syn cluster Spell add=CamelCase
endfun
autocmd BufEnter,BufReadPost,BufWritePost,BufNewFile * :call IgnoreCamelCaseSpell()

command! -buffer JdtCompile lua require('jdtls').compile()
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()

nnoremap <leader>bd :Bdelete<cr>
