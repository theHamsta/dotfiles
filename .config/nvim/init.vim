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


set number
set relativenumber

"nnoremap j gj
"nnoremap k gk
nnoremap <leader>make :wa<Cr>:make<Cr>
nnoremap <leader>so :w<Cr>:so %<Cr>
nnoremap <c-a-j> yyp
nnoremap <a-t> :ToggleBool<CR>
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
"inoremap  y/<C-R>"<CR>
nnoremap <c-w>q :tabedit %<cr>

let &path.="/usr/include,/usr/local/include,../include,/usr/local/include/opencv2"
nnoremap <F4> :wa<Cr>:make<cr>
nnoremap <Leader>cn :cn<cr>
nnoremap <Leader>cN :cN<cr>
nnoremap <Leader>sde :set spell<cr>:set spelllang=de<cr>
nnoremap <Leader>sen :set spell<cr>:set spelllang=en<cr>

nnoremap <Leader>bp :bN<cr>
nnoremap <Leader>bn :bn<cr>
nnoremap <Leader>tp :tabprevious<cr>
nnoremap <Leader>tn :tabNext<cr>
nnoremap <Leader>tab :tabnew<cr>
nnoremap <Leader>tc :tabclose<cr>
"nnoremap <Leader>nt :NERDTreeToggle<cr>
"nnoremap <Leader>nf :NERDTreeFind<cr>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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
	"Plug 'rkulla/pydiction'
	Plug 'junegunn/rainbow_parentheses.vim'
	Plug 'equalsraf/neovim-gui-shim'
	Plug 'joshuarubin/go-explorer'
	Plug 'artur-shaik/vim-javacomplete2'
	Plug 'joshdick/onedark.vim'
	Plug 'kovisoft/paredit'
	Plug 'sagarrakshe/toggle-bool'
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'dzhou121/gonvim-fuzzy' 
	Plug 'aben20807/vim-runner'
	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	"Plug 'bhurlow/vim-parinfer'
	"Plug 'w0rp/ale'
	Plug 'autozimu/LanguageClient-neovim', {
	    \ 'branch': 'next',
	    \ 'do': 'bash install.sh',
	    \ }
	Plug 'rking/ag.vim'
	Plug 'Chun-Yang/vim-action-ag'
	Plug 'easymotion/vim-easymotion'
	Plug 'justinmk/vim-sneak'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'l04m33/vlime', {'rtp': 'vim/'}
	"Plug 'Valloric/YouCompleteMe'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	"Plug 'tweekmonster/deoplete-clang2'
	Plug 'zchee/deoplete-jedi'
	Plug 'Shougo/vimproc.vim', {'do' : 'make'}
	Plug 'idanarye/vim-vebugger'
	"Plug 'Shougo/neoinclude.vim'
	Plug 'tpope/vim-surround'
	Plug 'michaeljsmith/vim-indent-object'
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
	"Plug 'metakirby5/codi.vim'
	"Plug 'dbeniamine/cheat.sh-vim'
	Plug 'majutsushi/tagbar'
	Plug 'vim-airline/vim-airline'
	Plug 'rliang/nvim-pygtk3', {'do': 'make install'}
	Plug 'lervag/vimtex'
	Plug 'beloglazov/vim-online-thesaurus'
	Plug 'wellle/targets.vim'
	Plug 'tpope/vim-abolish'
	Plug 'vim-scripts/DoxygenToolkit.vim'

call plug#end()

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-3.8/lib/libclang-3.8.so.1'
let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-3.8/lib/clang/3.8.1/include'
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
set autochdir
"nnoremap gf :vertical wincmd f<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.log,*/CMakeFiles/*

set lazyredraw
set ttyfast

map <leader>l <plug>(easymotion-lineforward)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
map <leader>h <plug>(easymotion-linebackward)
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
autocmd FileType python nnoremap <buffer> <F6> :VBGstartPDB %<cr>
autocmd FileType python nnoremap <buffer> <F7> :VBGcontinue<cr>
autocmd FileType python nnoremap <buffer> <F8> :VBGtoggleBreakpointThisLine<cr>
autocmd FileType python nnoremap <buffer> <F9> :exec '!python3' shellescape(@%:p, 1)<cr>:let last_execution=@%:p <cr>
autocmd FileType python nnoremap <buffer> <F3> :exec '!python3' shellescape( last_execution, 1)<cr>
autocmd FileType python nnoremap <buffer> <F10> :VBGstepOver<cr>
autocmd FileType python nnoremap <buffer> <F11> :VBGstepIn<cr>
autocmd FileType python nnoremap <buffer> <F12> :VBGstepOver<cr>

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


let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'lua': ['lua-lsp'],
    \ }

nnoremap <leader>la :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <leader>ty :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>sy :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <leader>wo :call LanguageClient#workspaceSymbol()<CR>
nnoremap <silent> <leader>re :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <leader>fo :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <leader>hi :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>co :call LanguageClient#textDocument_codeAction()<CR>

noremap <leader>rn :call LanguageClient#textDocument_rename()<CR>

" Rename - rc => rename camelCase
noremap <leader>rc :call LanguageClient#textDocument_rename( \ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>

" Rename - rs => rename snake_case
noremap <leader>rs :call LanguageClient#textDocument_rename( \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>

" Rename - ru =>
noremap <leader>ru :call LanguageClient#textDocument_rename( \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>

set foldmethod=indent
setlocal foldignore=
