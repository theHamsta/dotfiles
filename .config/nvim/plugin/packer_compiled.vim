" Automatically generated packer.nvim plugin loader code

if !has('nvim')
  finish
endif

lua << END
local plugins = {
  ["LanguageClient-neovim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/LanguageClient-neovim"
  },
  ["cheat.sh-vim"] = {
    commands = { "Cheat" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/cheat.sh-vim"
  },
  nerdtree = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nerdtree"
  },
  ["nerdtree-execute"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nerdtree-execute"
  },
  ["nerdtree-git-plugin"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nerdtree-git-plugin"
  },
  ["rust.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/rust.vim"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vim-go"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-go"
  },
  ["vim-markdown"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-markdown-composer"] = {
    commands = { "ComposerStart" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-markdown-composer"
  },
  ["vim-nerdtree-syntax-highlight"] = {
    commands = { "NERDTreeToggle", "NERDTreeFind" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-nerdtree-syntax-highlight"
  },
  ["vim-orgmode"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-orgmode"
  },
  ["vim-qml"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-qml"
  },
  ["vim-sexp"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-sexp"
  },
  ["vim-sexp-mappings-for-regular-people"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-sexp-mappings-for-regular-people"
  },
  ["vim-test"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-test"
  },
  ["vim-toml"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-toml"
  },
  ["vim-toml-enhance"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-toml-enhance"
  },
  vimtex = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vimtex"
  },
  vlime = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vlimevim/"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra, '<[cC][rR]>', '\r'))
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Runtimepath customization
vim.o.runtimepath = vim.o.runtimepath .. ",/home/stephan/.local/share/nvim/site/pack/packer/opt/vlime/vim/"
-- Pre-load configuration
-- Post-load configuration
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads
command! -nargs=* -range -bang -complete=file Cheat call s:load(['cheat.sh-vim'], { "cmd": "Cheat", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file NERDTreeToggle call s:load(['vim-nerdtree-syntax-highlight'], { "cmd": "NERDTreeToggle", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file ComposerStart call s:load(['vim-markdown-composer'], { "cmd": "ComposerStart", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file NERDTreeFind call s:load(['vim-nerdtree-syntax-highlight'], { "cmd": "NERDTreeFind", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file UndotreeToggle call s:load(['undotree'], { "cmd": "UndotreeToggle", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType toml ++once call s:load(['vim-toml', 'vim-toml-enhance', 'rust.vim'], { "ft": "toml" })
  au FileType vlime_repl ++once call s:load(['vim-sexp'], { "ft": "vlime_repl" })
  au FileType fennel ++once call s:load(['vim-sexp'], { "ft": "fennel" })
  au FileType python ++once call s:load(['vim-test'], { "ft": "python" })
  au FileType query ++once call s:load(['vim-sexp'], { "ft": "query" })
  au FileType tex ++once call s:load(['vimtex'], { "ft": "tex" })
  au FileType go ++once call s:load(['vim-go'], { "ft": "go" })
  au FileType fsharp ++once call s:load(['LanguageClient-neovim'], { "ft": "fsharp" })
  au FileType rust ++once call s:load(['rust.vim', 'vim-test'], { "ft": "rust" })
  au FileType org ++once call s:load(['vim-orgmode'], { "ft": "org" })
  au FileType lisp ++once call s:load(['vim-sexp', 'vim-sexp-mappings-for-regular-people', 'vlime'], { "ft": "lisp" })
  au FileType markdown ++once call s:load(['vim-markdown', 'vim-markdown-composer'], { "ft": "markdown" })
  au FileType qml ++once call s:load(['vim-qml'], { "ft": "qml" })
  au FileType NERDTreeToggle ++once call s:load(['nerdtree-execute', 'nerdtree-git-plugin', 'nerdtree'], { "ft": "NERDTreeToggle" })
  au FileType clojure ++once call s:load(['vim-sexp'], { "ft": "clojure" })
  au FileType scheme ++once call s:load(['vim-sexp'], { "ft": "scheme" })
  au FileType NERDTreeFind ++once call s:load(['nerdtree-execute', 'nerdtree-git-plugin', 'nerdtree'], { "ft": "NERDTreeFind" })
  " Event lazy-loads
augroup END
