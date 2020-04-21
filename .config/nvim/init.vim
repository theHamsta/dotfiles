set tags=./tags,tags
set encoding=UTF-8
set shell=/usr/bin/zsh
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

if g:use_line_numbers
  set number
  set relativenumber
endif

function! Toggle_line_numbers()
       windo set number!
       windo set relativenumber!
endfunction
command! LineNumbers call Toggle_line_numbers()


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
nmap <silent> <leader><C-k> :lprevious<cr>
nmap <silent> <leader><C-j> :lnext<cr>
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
      :T cargo build --release
    else
      :T cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
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
    Plug 'rhysd/vim-crystal'
    Plug 'mfussenegger/nvim-jdtls'
    Plug 'mfussenegger/nvim-dap'
    Plug 'haorenW1025/diagnostic-nvim'
    "Plug 'nvim-treesitter/highlight.lua'
    Plug 'nvim-treesitter/nvim-treesitter'
    "Plug 'nvim-treesitter/completion-treesitter'
    "Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    Plug 'dm1try/git_fastfix'
    Plug 'wookayin/vim-autoimport'
    "Plug 'svermeulen/vim-easyclip'
'
    Plug 'haorenW1025/diagnostic-nvim'
    Plug 'rafcamlet/nvim-luapad'
    Plug 'theHamsta/nvim_rocks', {'do': 'pip3 install --user hererocks && hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua'}
    "Plug 'Yonaba/30log', {'do': 'mkdir -p lua && cp *.lua lua'}
    "Plug 'lua-stdlib/lua-stdlib', {'do': 'cp -r lib lua'}
    "Plug 'mhinz/vim-grepper'
    "Plug 'https://gitlab.com/mcepl/vim-fzfspell.git'

    "Plug 'haorenW1025/completion-nvim'
    "Plug 'vigoux/completion-treesitter'
    "Plug 'chrisbra/unicode.vim'
    "Plug 'bergercookie/vim-deb-preview'
    "Plug 'doums/coBra'
    Plug 'tree-sitter/tree-sitter-python', { 'do': 'mkdir -p parser && cc -O3 -o parser/python.so -shared src/parser.c src/scanner.cc -I./src' }
    Plug 'Azganoth/tree-sitter-lua', { 'do': 'mkdir -p parser && cc -O3 -o parser/lua.so -shared src/parser.c src/scanner.cc -I./src' }
    Plug 'tree-sitter/tree-sitter-cpp', { 'do': 'mkdir -p parser && cc -O3 -o parser/cpp.so -shared src/parser.c src/scanner.cc -I./src' }
    Plug 'tree-sitter/tree-sitter-java', { 'do': 'mkdir -p parser && cc -O3 -o parser/java.so  -shared src/parser.c -I./src' }
    Plug 'tree-sitter/tree-sitter-javascript', { 'do': 'mkdir -p parser && cc -O3 -o parser/javascript.so  -shared src/parser.c src/scanner.c -I./src' }
    Plug 'zoxves/LightningFileExplorer'
    Plug 'theHamsta/nvim-tree.lua', {'branch': 'exa'}
    Plug 'mcchrish/info-window.nvim'
    Plug 'gluon-lang/vim-gluon'
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    "Plug 'OmniSharp/omnisharp-vim'
    Plug 'neomake/neomake' ", {'for': 'rst'}
    "Plug 'SkyLeach/pudb.vim'
    Plug 'romgrk/searchReplace.vim'
    Plug 'dbridges/vim-markdown-runner'
    Plug 'Olical/nvim-local-fennel'
    Plug 'bakpakin/fennel.vim'
    Plug 'Olical/aniseed'
    "Plug 'camspiers/lens.vim'
    Plug 'camspiers/animate.vim'
    "Plug 'AndrewRadev/splitjoin.vim'
    Plug 'wincent/vcs-jump'
    Plug 'neovim/nvim-lsp'
    Plug 'tikhomirov/vim-glsl'
    Plug 'itchyny/calendar.vim'
    Plug 'norcalli/nvim.lua'
    Plug 'tpope/vim-speeddating'
    Plug 'kchmck/vim-coffee-script'
    Plug 'arzg/vim-rust-syntax-ext'
    "Plug 'atelierbram/vim-colors_atelier-schemes'
    Plug 'Shougo/deoplete-lsp'
    "Plug 'wellle/context.vim'
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' } 
    Plug 'udalov/kotlin-vim'
    "Plug 'glacambre/firenvim'
    Plug 'rhysd/accelerated-jk' 
    Plug  'lambdalisue/suda.vim'
    Plug  'szymonmaszke/vimpyter'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'voldikss/vim-floaterm'
    Plug 'kkoomen/vim-doge'
    Plug 'ncm2/float-preview.nvim'
    Plug 'liquidz/vim-iced', {'for': 'clojure'}
    Plug 'liquidz/iced-nrepl', {'for': 'clojure'}
    "Plug 'kamykn/CCSpellCheck.vim'
    Plug 'AndrewRadev/switch.vim'
    Plug 'Chun-Yang/vim-action-ag'
    Plug 'JuliaEditorSupport/julia-vim'
    Plug 'Julian/vim-textobj-variable-segment'
    Plug 'KabbAmine/vCoolor.vim'
    "Plug 'LeafCage/yankround.vim'
    Plug 'Olical/vim-enmasse'
    Plug 'Shougo/echodoc.vim'
    "Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    Plug 'SirVer/ultisnips'
    Plug 'Valloric/ListToggle'
    Plug 'airblade/vim-gitgutter'
    Plug 'airblade/vim-rooter'
    Plug 'akiyosi/gonvim-fuzzy'
    Plug 'arp242/jumpy.vim'
    "Plug 'bfredl/nvim-ipy',  {'on':  [ 'IPython'], 'do': ':UpdateRemotePlugins'}
    Plug 'bfrg/vim-cpp-modern'
    Plug 'bkad/CamelCaseMotion'
    Plug 'bronson/vim-visual-star-search'
    "Plug 'brooth/far.vim'
    "Plug 'burke/matcher'
    Plug 'cespare/vim-toml', {'for': 'toml'}
    Plug 'chaoren/vim-wordmotion'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'dbeniamine/cheat.sh-vim', { 'on':  [ 'Cheat!'] }
    Plug 'dyng/ctrlsf.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'equalsraf/neovim-gui-shim'
    Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
    Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
    Plug 'junegunn/vim-emoji'
    Plug 'fszymanski/deoplete-emoji'
    Plug 'vlime/vlime', {'rtp': 'vim/', 'for':'lisp'}
    "Plug 'kovisoft/paredit', {'for': ['lisp', 'clojure']}
    "Plug 'kovisoft/slimv', {'for': 'lisp'}
    "Plug 'fvictorio/vim-textobj-backticks'
    Plug 'godlygeek/tabular'
    "Plug 'gregf/ultisnips-chef'
    "Plug 'heavenshell/vim-pydocstring'
    Plug 'henrynewcomer/vim-theme-papaya'
    Plug 'hotwatermorning/auto-git-diff'
    Plug 'idanarye/vim-merginal'
    Plug 'ivalkeen/nerdtree-execute' "  , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'Xuyuanp/nerdtree-git-plugin' " , { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'scrooloose/nerdtree' ", { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight' ", { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ]}
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'janko/vim-test'
    Plug 'jaxbot/semantic-highlight.vim'
    Plug 'jceb/vim-orgmode'
    Plug 'jpalardy/vim-slime'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/gv.vim'
    Plug 'junegunn/limelight.vim'
    "Plug 'justinmk/vim-gtfo'
    Plug 'justinmk/vim-sneak'
    Plug 'kana/vim-textobj-function'
    Plug 'kana/vim-textobj-user'
    Plug 'kassio/neoterm'
    Plug 'kien/rainbow_parentheses.vim'
    Plug 'lervag/vimtex', { 'for': 'tex' }
    Plug 'machakann/vim-highlightedyank'
    Plug 'machakann/vim-swap'
    Plug 'majutsushi/tagbar'
    Plug 'maralla/vim-toml-enhance', {'for': 'toml'}
    Plug 'markonm/traces.vim'
    Plug 'mbbill/undotree', { 'on':  [ 'UndotreeToggle'] }
    Plug 'meain/vim-package-info', { 'do': 'npm install' }
    Plug 'mhinz/neovim-remote'
    Plug 'mhinz/vim-startify'
    Plug 'michaeljsmith/vim-indent-object'
    "Plug 'mileszs/ack.vim'
    Plug 'moll/vim-bbye'
    "Plug 'neomake/neomake'
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    Plug 'pboettch/vim-cmake-syntax'
    Plug 'peterhoeg/vim-qml', { 'for' : 'qml' }
    Plug 'rbonvall/snipmate-snippets-bib'
    Plug 'rhysd/git-messenger.vim'
    Plug 'rhysd/rust-doc.vim'
    Plug 'rking/ag.vim'
    "Plug 'rliang/nvim-pygtk3', {'do': 'make install'}
    "Plug 'rliang/termedit.nvim'
    Plug 'roblillack/vim-bufferlist'
    "Plug 'rust-lang/rust.vim', { 'for': ['rust', 'toml'] }
    Plug 'ryanoasis/vim-devicons'
    "Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }
    Plug 'scrooloose/nerdcommenter'
    Plug 'sebdah/vim-delve', { 'for' : 'go' }
    Plug 'sgur/ctrlp-extensions.vim'
    Plug 'sgur/vim-textobj-parameter'
    Plug 'shumphrey/fugitive-gitlab.vim'
    Plug 'skywind3000/vim-preview'
    Plug 't9md/vim-choosewin'
    Plug 'tacahiroy/ctrlp-funky'
    Plug 'terryma/vim-expand-region'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'thalesmello/vim-textobj-methodcall'
    Plug 'theHamsta/vim-snippets'
    Plug 'theHamsta/vim-template'
    Plug 'theHamsta/vim-textobj-entire'
    Plug 'theHamsta/vim-rebase-mode'
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-markdown'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-rhubarb'
    "Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'lisp' }
    Plug 'guns/vim-sexp', { 'for': 'lisp' }
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-scripts/SearchComplete'
    Plug 'wellle/targets.vim'
    Plug 'whiteinge/diffconflicts'
    Plug 'TravonteD/luajob'
    "Plug 'zchee/deoplete-go', { 'do': 'make'}
    "
    "Plug 'rkulla/pydiction'
    "Plug 'xolox/vim-misc'
    "Plug 'Shougo/neosnippet.vim'
"Plug 'vim-pandoc/vim-pandoc'
    "Plug 'amix/vim-zenroom2'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile', 'for': ['java', 'vim', 'yaml', 'bash','sh', 'json', 'cs']}
    "Plug 'neoclide/coc.nvim', {'do': 'yarn install', 'for': ['java', 'vim', 'yaml', 'bash','sh', 'tex', 'bib', 'json', 'cs']}
    Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': ':T make release',
            \ }
    "Plug 'puremourning/vimspector', { 'do': ':UpdateRemotePlugins'}

    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif


    "Plug 'Shougo/neosnippet-snippets'

    "Colors
    Plug 'ayu-theme/ayu-vim'
    Plug 'jaredgorski/spacecamp'
    Plug 'kjssad/quantum.vim'
    Plug 'romainl/Apprentice'
    "Plug 'altercation/vim-colors-solarized'
    Plug 'rakr/vim-one'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'mhinz/vim-janah'
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
let g:tex_conceal='abdmg'
let g:tex_flavor='latex'

let g:deoplete#enable_at_startup = 1
"call deoplete#custom#var('omni', 'input_patterns', {
            "\ 'tex': g:vimtex#re#deoplete
            "\})


"let g:deoplete#sources#clang#executable='/usr/bin/clang'

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

nnoremap <Leader>DO :diffoff!<CR>
nnoremap <Leader>dp :dp<CR>
nnoremap <Leader>do :do<CR>
nnoremap <Leader>dg :diffget<CR>
nnoremap <Leader>dt :diffthis<CR>

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

set wildignore+=tags,_minted-*,*.egg-info,tmp,*.so,*.swp,*.zip,*.log,*/CMakeFiles/*,*.aux,*.lof,*.lot,*.gz,*.fls,*.fdb_latexmk,*.toc,__*__,*/pybind11/*,*[0-9]+,*.class,*.bak?,*.bak??,*.md5,*.snm,*.bbl,*.nav,*.out,*.run.xml,*.bcf,*.blg,*.auxlock,*.dvi,*.glo,*.glg,*.ist

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

let g:current_idx = 0
function! GetOtherVersionAtSameLine(fugitive_object)
    let current_line = line('.')
    execute 'Gvsplit +' . current_line . ' ' . a:fugitive_object . ':%'
    echo 'Gvsplit +' . current_line . ' ' . a:fugitive_object . ':%'
endfunction

function! GoPreviousCommit()
    let current_line = line('.')
    cnext
    execute "normal " . current_line . "gg"
    normal zz
endfunction
function! GoNextCommit()
    let current_line = line('.')
    cprevious
    execute "normal " . current_line . "gg"
    normal zz
endfunction
function! TimeMachine()
    let current_line = line('.')
    0Glog
    execute "normal " . current_line . "gg"
    normal zz
endfunction

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
set termguicolors     " enable true colors support
colorscheme one
"colorscheme papaya
let g:papaya_gui_color='blue'
"colorscheme apprentice
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu

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
nnoremap <F3> <c-w>o:Tkill<cr>:Topen<cr>:wa<cr>:exec 'T' expand($last_execution,1)<cr>
nnoremap <s-F3> :Tkill<cr>:wa<cr>:exec expand($last_execution,1)<cr>
"
"autocmd FileType cpp nnoremap <buffer> <F5> :let $last_execution='./build/' . $target<cr>:wa<cr>:CMake<cr>:Neomake!<cr>:exec 'T' expand($last_execution,1)<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <s-F6> <c-w>o:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just clean<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <F7> <c-w>o:Topen<cr>:Tclear<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just release-run<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <s-F7> <c-w>o:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just release<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm nnoremap <buffer> <F6> <c-w>o:Topen<cr>:Tclear<cr>:exec 'T cd' FindRootDirectory()<cr>:Tkill<cr>:wa<cr>:T just build<cr>
autocmd FileType just,cpp,cmake,cuda,c,make,prm,latex,tex nnoremap <buffer> <F5> <c-w>o:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:let $last_execution='just run'<cr>:Tkill<cr>:wa<cr>:T just run<cr>
autocmd FileType java nnoremap <buffer> <F6> :Topen<cr>:let $last_execution='pyconrad_run ' . expand('%:r',1)<cr>:Tkill<cr>:wa<cr>:T pyconrad_run %:r<cr>
autocmd FileType java nnoremap <buffer> <F4> :Topen<cr>:let $last_execution='pyconrad_run --gui ' . expand('%:r',1)<cr>:Tkill<cr>:wa<cr>:T pyconrad_run --gui %:r<cr>
autocmd FileType java,kotlin,groovy nnoremap <buffer> <F5> :Topen<cr>:let $last_execution='./gradlew run'<cr>:Tkill<cr>:wa<cr>:T ./gradlew run<cr>
autocmd FileType tex,latex nnoremap <buffer> <F3> val<plug>(vimtex-compile-selected)
autocmd FileType tex,latex nnoremap <buffer> <F4> :VimtexCompileSS<cr>
"autocmd FileType tex,latex :let  maplocalleader="<space>"
autocmd FileType rust,toml nmap <buffer> <F5> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let $last_execution='cargo run'<cr>:Tkill<cr>:wa<cr>:T cargo run<cr>:Topen<cr>
autocmd FileType rust,toml nmap <buffer> <F7> :exec 'T cd' FindRootDirectory()<cr><c-w>o:Tkill<cr>:wa<cr>:T cargo run 
autocmd FileType rust,toml nmap <buffer> <F4> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let $last_execution='cargo build'<cr>:Tkill<cr>:Topen<cr>:wa<cr>:T cargo build<cr>:Topen<cr>
autocmd FileType rust,toml nmap <buffer> <F6> :exec 'T cd' FindRootDirectory()<cr><c-w>o:let $last_execution='cargo test -- --nocapture'<cr>:Tkill<cr>:Topen<cr>:wa<cr>:T cargo test -- --nocapture<cr>
autocmd FileType rust nmap <silent> <leader>tn :wa<cr>:RustTest<cr>
autocmd FileType rust nmap <silent> <leader>tN <c-w>o:wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestNearest -- --nocapture<CR>


autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

autocmd BufRead *.prm :setfiletype prm
" jump to the previous function
autocmd FileType cpp nnoremap <buffer> [f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
" jump to the next function
autocmd FileType cpp nnoremap <buffer> ]f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>
"autocmd FileType cpp nnoremap <buffer> <F5> :let $last_execution='
":let last_execution=@%<cr>
"
autocmd FileType go nmap <buffer> <c-a-p> :cd $GOPATH/src<cr>:Files<cr>
autocmd FileType lisp nmap <buffer> <c-a-p> :cd ~/quicklisp/local-projects<cr>:Files<cr>
autocmd FileType lisp nmap <buffer> :let maplocalleader = ','
autocmd FileType lisp nmap <buffer> <leader>w :wa<cr>
autocmd FileType lisp nmap <silent> <buffer> <tab> <c-x><c-o>
"autocmd FileType lisp nmap call deoplete#custom#option('auto_complete', v:false)


autocmd FileType lisp nmap <buffer> <s-enter> <space>of
autocmd FileType lisp nmap <silent> call vlime#plugin#InteractionMode(v:true)
autocmd FileType clojure nmap <buffer> <enter> <Plug>(iced_eval_outer_top_list)
"

autocmd FileType cmake SemanticHighlight
autocmd FileType lua nnoremap <buffer> <F5> :exec '!lua' shellescape(@%:p, 1)<cr>:let last_execution=@%:p <cr>

autocmd FileType tex,latex nnoremap <buffer> <c-s> :w<cr>:silent !latexindent % -w<cr>:e<cr>
"autocmd FileType tex,latex call neomake#configure#automake('w')
autocmd FileType rst call neomake#configure#automake('w')
autocmd FileType tex,latex nnoremap <buffer> <c-a-o> :call vimtex#fzf#run()<cr>
autocmd FileType markdown nnoremap <buffer> <cr> :ComposerStart<cr>:ComposerOpen<cr>
autocmd FileType markdown nnoremap <buffer> <leader>ll :ComposerStart<cr>
autocmd FileType markdown nnoremap <buffer> <leader>lv :ComposerOpen<cr>
"autocmd FileType markdown <buffer> set conceallevel=1

autocmd FileType bib command! Format normal :w<cr>:silent !latexindent % -w<cr>:e<cr>
"<cr>:e

let g:ag_working_path_mode="r"


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
let g:vlime_leader='<space>'
let g:vlime_cl_use_terminal=v:true
let g:vlime_enable_autodoc = v:true
let g:vlime_window_settings = {'sldb': {'pos': 'belowright', 'vertical': v:true}, 'inspector': {'pos': 'belowright', 'vertical': v:true}, 'preview': {'pos': 'belowright', 'size': v:null, 'vertical': v:true}}

"let g:slimv_leader='<space>'
let g:slimv_leader=','
let g:slimv_repl_simple_eval=1

"autocmd FileType lisp nmap <buffer> <enter> :call SlimvEvalExp()<cr>
"autocmd FileType lisp nmap <buffer> <s-enter> :call SlimvEvalBuffer()<cr>
"autocmd FileType vlime_input i
"autocmd FileType vlime_input  inoremap <buffer> <enter> )<esc><enter>

"autocmd FileType lisp nmap <silent> <buffer> <enter>  :call vlime#plugin#SendToREPL(vlime#ui#CurExprOrAtom())<cr>
"autocmd FileType lisp nmap <silent> <buffer> <enter> ,d<cr>
"autocmd FileType lisp nmap <silent> <buffer> <leader>xx  :call vlime#plugin#SendToREPL('()')<left><left><left>
"autocmd FileType lisp imap <buffer> ( (<c-x><c-o>
"autocmd FileType lisp  set <local> completeopt=menu,noinsert
"let g:vlime_cl_impl = "sbcl_swank"

    "\ 'clojure': ['clojure-lsp'],
    "\ 'rust': ['rls'],
let g:LanguageClient_serverCommands = {
    \ 'rust': ['ra_lsp_server'],
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
    \ 'python': ['pyls'],
    \ 'cuda': ['clangd-11', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes'],
    \ 'kotlin': ['kotlin-language-server', '.'],
    \ 'go': ['gopls'],
    \ 'dockerfile': ['docker-langserver', '--stdio'],
    \ 'd': ['dls'],
    \ 'crystal': ['/home/stephan/projects/scry/scry/bin/scry'],
    \ 'tex': ['texlab'],
    \ 'bib': ['texlab'],
    \ 'gluon': ['gluon_language-server']
    \ }
    "\ 'lua': ['lua-lsp'],
    "\ 'cpp': ['clangd-11', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes'],
    "\ 'c': ['clangd-11', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes'],
    "\ 'javascript': ['javascript-typescript-stdio'],
    "\ 'javascript.jsx': ['javascript-typescript-stdio'],
    "\ 'lisp': ['sbcl', '--script', '/home/stephan/quicklisp/local-projects/cl-lsp/start-that-shit.lisp']
    "\ 'lisp': ['/home/stephan/projects/cl-language-server/target/debug/cl-language-server'],
    "\ 'lisp': ['cl-language-server']
"
    "\ 'cpp': ['clangd-9', '-clang-tidy'],
    "\ 'tex': ['texlab'],
    "\ 'bib': ['texlab'],
    "\ 'tex': ['java', '-jar', '~/.local/bin/texlab.jar'],
    "\ 'bib': ['java', '-jar', '~/.local/bin/texlab.jar'],
    "\ 'cpp': ['clangd-9', '-clang-tidy'],
    "\ 'go': ['bingo', '--diagnostics-style=instant'],
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
         if &filetype != "python" && &filetype != "tex" && &filetype != "bib"&& &filetype != "go"&& &filetype != "lua"&& &filetype != "lisp"
             autocmd CursorHold <buffer> silent call LanguageClient#textDocument_documentHighlight()
         endif
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

  nnoremap <buffer><silent> gk    <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <buffer><silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <buffer><silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <buffer><silent> gS <cmd>lua vim.lsp.buf.signature_help()<CR>
  inoremap <buffer><silent> ( <cmd>lua vim.lsp.buf.signature_help()<CR>(
  nnoremap <buffer><silent> gt   <cmd>lua vim.lsp.buf.type_definition()<CR>
   setlocal omnifunc=v:lua.vim.lsp.omnifunc
endfunction

nmap <silent> <C-k> :lprevious<cr>
nmap <silent> <C-j> :lnext<cr>

autocmd FileType * call LC_maps()
autocmd FileType lua call NvimLspMaps()



nnoremap <silent> <leader>f0 :set foldlevel=0<CR>
nnoremap <silent> <leader>ff :set foldlevel=99<CR>
nnoremap <silent> z0 :set foldlevel=0<CR>
nnoremap <silent> z9 :set foldlevel=99<CR>

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
set colorcolumn=120


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
    nnoremap <silent> <leader>py <c-w>o:vertical Topen<cr>:T ipython<cr>
    nnoremap <silent> <leader>sym <c-w>o:vertical Topen<cr>:T isympy -I<cr>
    nnoremap <c-´> :botright Ttoggle<cr>
    "nnoremap <leader>tt :<c-u>exec v:count.'T'<cr>
    "nnoremap <silent> <PageDown> :cclose<cr>:lclose<cr>:pc<cr>:botright Ttoggle<cr>
    "tnoremap <silent> <PageDown> <C-\><C-n><cr>:Ttoggle<cr>

endif

let g:jumpy_map = [']]', '[[']

let g:jumpy_after = 'zz'
nmap <PageDown> ]]
nmap <PageUp> [[
vnoremap <PageDown> ]]
vnoremap <PageUp> [[

"nnoremap <c-`> :cclose<cr>:lclose<cr>:Ttoggle<cr>
"nnoremap <c-s-´> :cclose<cr>:lclose<cr>:Ttoggle<cr>

let g:neoterm_default_mod='vert'
let g:neoterm_open_in_all_tabs=0
"autocmd BufWinEnter,WinEnter term://* startinsert
augroup terminal
    autocmd TermOpen * set bufhidden=hide
    "autocmd TermOpen * set syntax=cpp
    autocmd TermOpen * setlocal nospell
augroup END

    "tnoremap <C-v>a <C-\><C-n>"aPi

nnoremap <a-t> :Switch<CR>

au VimEnter * RainbowParenthesesActivate
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
     nmap <silent> <buffer>  <leader>ca <Plug>(coc-codeaction-selected)
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

autocmd FileType java,json,yaml,vim,bash,sh,cs call ActivateCoc()

 "inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

 let g:LanguageClient_hasSnippetSupport = 0


 set autoread
au CursorHold * checktime  
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
"let g:rooter_change_directory_for_non_project_files = ''

"let g:livepreview_previewer = 'okular'

nnoremap <leader>date :r!date<cr>
autocmd FileType tex nnoremap <buffer> ,lv :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>
autocmd FileType tex nnoremap <buffer> <cr> :let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'<cr>:VimtexView<cr>:let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex --noraise'<cr>
"autocmd FileType tex nnomap <buffer>  <cr> <leader>lv
autocmd FileType tex nnoremap <buffer> <c-cr> normal ":T okular " .  %:p:h . "/output.pdf --unique &<cr><c-w>o"
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
  "nnoremap <leader>bl :GonvimFuzzyBLines<CR>
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
nmap ,CO :execute '!code-insiders -r ' getcwd()<cr>:!code-insiders -r %<cr>


"nnoremap <c-p> :CtrlPMixed<cr>
let g:ctrlp_map = ''
nnoremap <c-p> :ProjectFiles<CR>
nnoremap <c-a-m> :ProjectFolders<CR>

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

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
nmap Q @q
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'cpp', 'rust', 'java', 'go', 'lua']

function! Multiple_cursors_before()
  call deoplete#custom#option('auto_complete', v:false)
endfunction
function! Multiple_cursors_after()
 if &filetype != "java"
  call deoplete#custom#option('auto_complete', v:true)
endif
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

"set completeopt=menuone,menu,longest,noinsert
set completeopt=menuone,menu,longest

" Highlight (inofficial) json comments
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
            \           "signText": "✖",
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

"nmap <silent> <leader>tn :wa<cr>:Topen<cr>:TestNearest<CR>
"nmap <silent> <leader>tf :wa<cr>:Topen<cr>:TestFile<CR>
nmap <silent> <leader>ts :wa<cr>:Topen<cr>:exec 'T cd' FindRootDirectory()<cr>:TestSuite<CR>
nmap <silent> <leader>tl <c-w>o:wa<cr>:Tkill<cr>:Topen<cr>:TestLast<CR>
nmap <silent> <leader>tL :wa<cr>:Tkill<cr>:Topen<cr>:TestLast<CR>
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
autocmd BufReadPre *.pdf silent %!xdg-open "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78

autocmd BufReadPre *.png silent %!xdg-open "%"
autocmd BufReadPre *.eps silent %!xdg-open "%"
autocmd BufReadPre *.jpg silent %!xdg-open "%"
autocmd BufReadPre *.bmp silent %!xdg-open "%"

nmap  <leader>cw  <Plug>(choosewin)
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

let g:startify_padding_left = 20
let g:neoterm_term_per_tab =1
set cursorline

 "Disable default mappings
 let g:nnn#set_default_mappings = 0
 let g:nvim_ipy_perform_mappings = 0

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
  autocmd FileType gitrebase set bufhidden=delete
  endif

let g:email='stephan.seitz@fau.de'
let g:username='Stephan Seitz'

call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*',
  \ 'python': '[^. *\t(]\.\w*',
  \      'lisp': '[(\s]\w*'})

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
"let g:go_auto_sameids = 1
"
let g:riv_web_browser='firefox'
let g:gitgutter_max_signs=1000
let g:fugitive_gitlab_domains = ['https://i10git.cs.fau.de/']

let g:rooter_patterns = ['.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
nnoremap <leader>ju :Topen<cr>:T just<space>


let g:auto_git_diff_disable_auto_update=1
let g:auto_git_diff_show_window_at_right=1

function! s:setup_auto_git_diff() abort
    nmap <buffer> <C-l> <Plug>(auto_git_diff_scroll_manual_update)
    nmap <buffer> <C-n> <Plug>(auto_git_diff_scroll_down_half)
    nmap <buffer> <C-p> <Plug>(auto_git_diff_scroll_up_half)
    nmap <buffer> <enter> <Plug>(auto_git_diff_manual_update)
endfunction
autocmd FileType gitrebase call <SID>setup_auto_git_diff()

let g:gitgutter_preview_win_floating = 1
let g:LanguageClient_diagnosticsMaxSeverity = "Information"

"GitGutterLineNrHighlightsEnable
function! NextHunkAllBuffers()
  let line = line('.')
  GitGutterNextHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bnext
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! 1G
      GitGutterNextHunk
      return
    endif
  endwhile
endfunction

function! PrevHunkAllBuffers()
  let line = line('.')
  GitGutterPrevHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bprevious
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! G
      GitGutterPrevHunk
      return
    endif
  endwhile
endfunction

nmap <silent> <c-a-j> <Plug>(GitGutterNextHunk)
nmap <silent> <c-a-k> <Plug>(GitGutterPrevHunk)
nmap ]h :call NextHunkAllBuffers()<CR>
nmap [h :call PrevHunkAllBuffers()<CR>

let g:LanguageClient_hoverPreview='always'
let g:go_highlight_function_calls = 1
let g:go_highlight_format_strings = 1
let g:go_fmt_command = "goimports"

fun! IgnoreCamelCaseSpell()
  syn match CamelCase /\<[A-Z][a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  syn cluster Spell add=CamelCase
endfun
autocmd BufReadPost,BufWritePost,BufNewFile * :call IgnoreCamelCaseSpell()

fun! RemoveTrailingWhitespaces()
    %s/\s\+$//e
endfun
command! RemoveTrailingWhitespaces call RemoveTrailingWhitespaces()
nnoremap <silent> <PageDown> :FloatermToggle<cr>
nnoremap <silent> <leader>fl :FloatermToggle<cr>
tnoremap <silent> <PageDown> <C-\><C-n>:FloatermToggle<cr>
tnoremap <silent> <leader>fl <C-\><C-n>:FloatermToggle<cr>

if exists('g:GuiLoaded')
  let g:float_preview#docked = 1
endif

let g:doge_doc_standard_python='google'
nmap <silent> <C-.> :DogeGenerate<cr>

let g:LanguageClient_settingsPath='~/.config/nvim/settings.json'

call textobj#user#plugin('latex', {
\   'environment': {
\     '*pattern*': ['\\begin{frame}.*\n\s*', '\n^.*\end{frame}'],
\     'select-a': 'al',
\     'select-i': 'il',
\   }
\ })                                                                    
                                                                        
autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR> 
autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR> 
                                                                        
command! Emoji %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

command! SBCL normal :T sbcl --load ~/.local/share/nvim/plugged/vlime/lisp/start-vlime.lisp<cr>

"lua require'colorizer'.setup()

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : 'markdown2ctags',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
    \ }

"nmap j <Plug>(accelerated_jk_gj)
"nmap k <Plug>(accelerated_jk_gk)
"
call deoplete#custom#source('emoji', 'filetypes', ['rst', 'gitcommit', 'markdown', 'python', 'txt'])

let g:nvimgdb_config_override = {
      \ 'key_next': '<F10>',
      \ 'key_step': '<F9>',
      \ 'key_finish': '<c-F8>',
      \ 'key_continue': '<F5>',
      \ 'key_until': '<c-F5>',
      \ 'key_breakpoint': '<c-a-b>',
      \ 'key_frameup':    '<PageUp>',
      \ 'key_framedown':  '<PageDown>',
      \ }
let g:gitgutter_max_signs=3000
"

"call plug#begin('~/.local/share/nvim/plugged2')

"Plug 'autozimu/LanguageClient-neovim', {
    "\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }
"if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
  "Plug 'Shougo/deoplete.nvim'
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
"endif

"call plug#end()


"augroup filetype_rust
      "autocmd!
      "autocmd BufReadPost *.cpp setlocal filetype=cpp
"augroup END

"autocmd FileType * call deoplete#custom#option('auto_complete', v:true)


"" Always draw sign column. Prevent buffer moving when adding/deleting sign.
 "set signcolumn=yes

"let g:deoplete#enable_at_startup = 1
 "let g:LanguageClient_serverCommands = {
     "\ 'cpp': ['clangd-9', '--clang-tidy', '--header-insertion=iwyu', '--background-index', '--suggest-missing-includes']
         "\ }
 "let $RUST_BACKTRACE = 1
 "let g:LanguageClient_loggingLevel = 'INFO'
 "let g:LanguageClient_virtualTextPrefix = ''
 "let g:LanguageClient_loggingFile = expand('~/.local/share/nvim/LanguageClient.log')
 "let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')
 
"let g:context_enabled = 1

"autocmd VimEnter     * ContextActivate
"autocmd BufAdd       * call context#update(1, 'BufAdd')
"autocmd BufEnter     * call context#update(0, 'BufEnter')
"autocmd CursorMoved  * call context#update(0, 'CursorMoved')
"autocmd User GitGutter call context#update_padding('GitGutter')

luafile ~/.config/nvim/init.lua

let g:vlime_contribs = ['SWANK-QUICKLISP', 'SWANK-ASDF', 'SWANK-PACKAGE-FU',
                      \ 'SWANK-PRESENTATIONS', 'SWANK-FANCY-INSPECTOR',
                      \ 'SWANK-C-P-C', 'SWANK-ARGLISTS', 'SWANK-REPL',
                      \ 'SWANK-FUZZY', 'SWANK-TRACE-DIALOG']

"let g:LanguageClient_windowLogMessageLevel = 'Log'
"let g:LanguageClient_loggingLevel ='DEBUG'
"let g:LanguageClient_loggingFile= expand('~/log')
let g:paredit_leader=','

let g:iced_enable_default_key_mappings = v:true


let g:LanguageClient_useVirtualText='All'

command! CargoPlay :T cargo play %
let g:context_presenter = 'nvim-float'
nnoremap <leader>gj :VcsJump diff<cr>


function! LayoutTerm(size, orientation) abort
  let timeout = 16.0
  let animation_total = 150.0
  let timer = {
    \ 'size': a:size,
    \ 'step': 1,
    \ 'steps': animation_total / timeout
  \}

  if a:orientation == 'horizontal'
    resize 1
    function! timer.f(timer)
      execute 'resize ' . string(&lines * self.size * (self.step / self.steps))
      let self.step += 1
    endfunction
  else
    vertical resize 1
    function! timer.f(timer)
      execute 'vertical resize ' . string(&columns * self.size * (self.step / self.steps))
      let self.step += 1
    endfunction
  endif
  call timer_start(float2nr(timeout), timer.f, {'repeat': float2nr(timer.steps)})
endfunction

" Open autoclosing terminal, with optional size and orientation
function! OpenTerm(cmd, ...) abort
  let orientation = get(a:, 2, 'horizontal')
  if orientation == 'horizontal'
    new | wincmd J
  else
    vnew | wincmd L
  endif
  call LayoutTerm(get(a:, 1, 0.9), orientation)
  call termopen(a:cmd, {'on_exit': {j,c,e -> execute('if c == 0 | close | tnoremap jk <C-\><C-n> | endif')}})
  tunmap jk
  normal i
endfunction

"nmap ,k :SplitjoinSplit<cr>
"nmap ,j :SplitjoinJoin<cr>


nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(-25)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(+25)<CR>

nnoremap <silent> <leader>lz :call OpenTerm('lazygit')<cr>
nnoremap K :s/,/,\r/g<cr>


"hi! CppEnumConstant ctermfg=Magenta guifg=#AD7FA8 cterm=none gui=none
"hi! CppNamespace ctermfg=Yellow guifg=#BBBB00 cterm=none gui=none
"hi! CppMemberVariable ctermfg=White guifg=White

"let g:LanguageClient_semanticHighlightMaps['java'] = {
    "\ '^storage.modifier.static.java:entity.name.function.java': 'JavaStaticMemberFunction',
    "\ '^meta.definition.variable.java:meta.class.body.java:meta.class.java': 'JavaMemberVariable',
    "\ '^entity.name.function.java': 'Function',
    "\ '^[^:]*entity.name.function.java': 'Function',
    "\ '^[^:]*entity.name.type.class.java': 'Type',
    "\ }

"highlight! JavaStaticMemberFunction ctermfg=Green cterm=none guifg=Green gui=none
"highlight! JavaMemberVariable ctermfg=White cterm=italic guifg=White gui=italic
command! YankFilename :let @+ = expand("%:p")
packadd termdebug
"let g:pudb_python='/usr/bin/python3'
"
nnoremap <leader>tq  :cgetbuffer<cr>:copen<cr>
nnoremap <leader>tQ :setlocal errorformat=
    \%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
	\%C\ \ \ \ %.%#,
	\%+Z%.%#Error\:\ %.%#,
	\%A\ \ File\ \"%f\"\\\,\ line\ %l,
	\%+C\ \ %.%#,
	\%-C%p^,
	\%Z%m,
	\%-G%.%#<cr>:cgetbuffer<cr>:copen<cr>

let g:completion_confirm_key = "\<C-y>"
let g:sexp_enable_insert_mode_mappings=1


let g:vlime_compiler_policy={"DEBUG": 3, "SPEED": 0}


augroup CustomVlimeInputBuffer
    autocmd!
    autocmd FileType vlime_input inoremap <silent> <buffer> <tab> <c-r>=vlime#plugin#VlimeKey("tab")<cr>
    autocmd FileType vlime_input setlocal omnifunc=vlime#plugin#CompleteFunc
    autocmd FileType vlime_input setlocal indentexpr=vlime#plugin#CalcCurIndent()
    autocmd BufEnter vlime_input i
augroup end

nnoremap <c-g> :InfoWindowToggle<cr>
nnoremap <a-s-k> "ayy"aP
nnoremap <a-s-j> "ayy"ap

"" invert that dictionary to create one mapping names to codepoints
"let unicodeIndex = {}
"for codepoint in keys(g:unicode#unicode#data)
  "let char = nr2char(codepoint)
  "let unicodeIndex[g:unicode#unicode#data[codepoint] . ' ' . char] = char
"endfor

"" shamelessly shadow the default i_CTRL-U (clear to beginning of line) mapping because I never use it.
"inoremap <C-s-U> <C-R>=join(map(fzf#run({'source': keys(unicodeIndex), 'down': '10' }), 'unicodeIndex[v:val]'))<CR><Esc>

lua require'git_fastfix'
nn <silent> <leader>gf :lua OpenGitFastFixWindow()<cr>

"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
"
"function! JavaStartDebugCallback(err, port)
  "execute "cexpr! 'Java debug started on port: " . a:port . "'"
  "call vimspector#LaunchWithSettings({ "configuration": "Java Attach", "AdapterPort": a:port })
"endfunction

"function JavaStartDebug()
  "call CocActionAsync('runCommand', 'vscode.java.startDebugSession', function('JavaStartDebugCallback'))
"endfunction

"nmap <F1> :call JavaStartDebug()<CR>
let g:gtfo#terminals = { 'unix': 'konsole' }

nnoremap gtf :Tnew<cr>:T dolphin %:p:h 2>&1 >> /dev/null &<cr>:Tclose<cr>
"let g:vimspector_enable_mappings = 'HUMAN'

"autocmd! BufEnter vimspector.Console nnoremap <buffer> n :call vimspector#StepOver()<cr>
""function VimspectorLaunch()
"nnoremap <s-f9> :call vimspector#ToggleBreakpoint()<cr>
"nnoremap <s-f8> :call vimspector#StepOver()<cr>
"nnoremap <f9> :call vimspector#StepInto()<cr>
"nnoremap <f10> :call vimspector#StepOut()<cr>
"nnoremap <s-f10> :call vimspector#Restart()<cr>
"nnoremap  <f11> :call vimspector#Continue()<cr>
"nnoremap <s-f11> :call vimspector#Stop()<cr>
"endfunction

command! WorkingDirToCurrentFile cd %:p:h
command! CdToCurrentFile cd %:p:h
command! CdToCurrentFile cd %:p:h
command! SwitchWorkingDirToCurrentFile cd %:p:h

"" Configure the completion chains
"let g:completion_chain_complete_list = {
			"\'default' : {
			"\	'default' : [
			"\		{'complete_items' : ['lsp', 'snippet']},
			"\		{'mode' : 'file'}
			"\	],
			"\	'comment' : [],
			"\	'string' : []
			"\	},
			"\'vim' : [
			"\	{'complete_items': ['snippet']},
			"\	{'mode' : 'cmd'}
			"\	],
			"\'c' : [
			"\	{'complete_items': ['ts']}
			"\	],
			"\'python' : [
			"\	{'complete_items': ['ts']}
			"\	],
			"\'lua' : [
			"\	{'complete_items': ['ts']}
			"\	],
			"\}
"autocmd BufEnter * lua require'completion'.on_attach()

"" Highlight the node at point, its usages and definition when cursor holds
"let g:complete_ts_highlight_at_point = 1

nnoremap <silent> <c-ScrollWheelUp> :lua require'my_gui'.increase_fontsize()<cr>
nnoremap <silent> <c-ScrollWheelDown> :lua require'my_gui'.decrease_fontsize()<cr>
nnoremap <silent> <c-0> :lua require'my_gui'.reset_fontsize()<cr>

let g:lua_tree_side = 'left' " | 'left' left by default
let g:lua_tree_size = 50 "30 by default
let g:lua_tree_auto_open = 0 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:lua_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:lua_tree_follow = 1 "0 by default, this option will bind BufEnter to the LuaTreeFindFile command
" :help LuaTreeFindFile for more info
let g:lua_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \}
let g:lua_tree_use_wildignore = 1
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if web-devicons is installed and on your runtimepath

" You can edit keybindings be defining this variable
" You don't have to define all keys.
" NOTE: the 'edit' key will wrap/unwrap a folder and open a file
let g:lua_tree_bindings = {
    \ 'edit':        '<CR>',
    \ 'edit_vsplit': '<C-v>',
    \ 'edit_split':  '<C-x>',
    \ 'edit_tab':    '<C-t>',
    \ 'cd':          '.',
    \ 'create':      'a',
    \ 'remove':      'd',
    \ 'rename':      'r'
    \ }
let g:lua_tree_ignore = [ '.git', 'node_modules', '.cache', '__pycache__' ]

nnoremap <Leader>nt :LuaTreeToggle<CR>
nnoremap <Leader>nf :LuaTreeFindFile<cr>:LuaTreeShow<CR>
nnoremap <Leader>nT :NERDTreeToggle<cr>
nnoremap <Leader>nF :NERDTreeFind<cr>
"
let g:diagnostic_insert_delay = 1


function! FzfProjectSink(word)
  exe ':e ~/projects/' .  a:word
endfunction
function! FzfProjectSearch()
  let suggestions = systemlist("ls ~/projects")
  return fzf#run({'source': suggestions, 'sink': function("FzfProjectSink"), 'window': 'call FloatingFZF()'})
endfunction

function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'window': 'call FloatingFZF()'})
endfunction

nnoremap <space>pr :call FzfProjectSearch()<CR>
nnoremap z= :call FzfSpell()<CR>

command! GitPushAsync lua require'my_commands'.git_push()
command! GitPushAsyncForce lua require'my_commands'.git_push(true)
command! PyTest lua require'my_commands'.custom_command('pytest')

function! ProjectFilesSink(word)
  exe ':e '. a:word
endfunction
function! ProjectFilesSearch()
  let suggestions = luaeval("require'my_projects'.get_project_files()")
  return fzf#run({'source': suggestions, 'sink': function("ProjectFilesSink"), 'window': 'call FloatingFZF()'})
endfunction

function! ProjectFoldersSearch()
  let suggestions = luaeval("require'my_projects'.get_project_list()")
  return fzf#run({'source': suggestions, 'sink': function("ProjectFilesSink"), 'window': 'call FloatingFZF()'})
endfunction

command! ProjectClose lua require'my_projects'.close_project()
command! ProjectFiles call ProjectFilesSearch()
command! ProjectFolders call ProjectFoldersSearch()


"nnoremap gm m
"nnoremap d d
function! s:get_visual_selection()
    "cp https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    call setreg('+', lines, 'l')
    1T %paste
endfunction
command! -nargs=* PasteVisualSel call s:get_visual_selection()
