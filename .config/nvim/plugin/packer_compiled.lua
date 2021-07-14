-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Ionide-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/Ionide-vim"
  },
  ["LanguageClient-neovim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/LanguageClient-neovim"
  },
  ListToggle = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/ListToggle"
  },
  ["TrueZen.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/TrueZen.nvim"
  },
  ["ag.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/ag.vim"
  },
  ["animate.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/animate.vim"
  },
  ["auto-git-diff"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/auto-git-diff"
  },
  ["auto-pairs"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/auto-pairs"
  },
  ["base16-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/base16-vim"
  },
  ["cheat.sh-vim"] = {
    commands = { "Cheat" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/cheat.sh-vim"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
  },
  ["crazy-node-movement"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/crazy-node-movement"
  },
  ["ctrlsf.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/ctrlsf.vim"
  },
  darcula = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/darcula"
  },
  ["daycula-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/daycula-vim"
  },
  diffconflicts = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/diffconflicts"
  },
  ["earthly.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/earthly.vim"
  },
  ["emmet.snippets"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/emmet.snippets"
  },
  fzf = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\2-\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\18my_statusline\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  git_fastfix = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/git_fastfix"
  },
  ["gitlinker.nvim"] = {
    config = { "\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14gitlinker\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/gitlinker.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\2‘\14\0\0\4\0!\00026\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\14\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\2=\2\15\0015\2\16\0=\2\17\0015\2\18\0=\2\19\1B\0\2\1X\0\26Ä6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\26\0005\2\21\0005\3\20\0=\3\5\0025\3\22\0=\3\a\0025\3\23\0=\3\t\0025\3\24\0=\3\v\0025\3\25\0=\3\r\2=\2\15\0015\2\27\0005\3\28\0=\3\29\0025\3\30\0=\3\31\2=\2\17\0015\2 \0=\2\19\1B\0\2\1K\0\1\0\1\0\1\rinterval\3Ë\a\tn [c\1\2\1\0@&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'\texpr\2\tn ]c\1\2\1\0@&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'\texpr\2\1\0\t\vbuffer\2\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\17n <leader>hb0<cmd>lua require\"gitsigns\".blame_line()<CR>\to ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\tx ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hr5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\fnoremap\2\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hu0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\1\0\2\18sign_priority\3\6\nnumhl\1\1\0\2\ttext\6~\ahl\20GitGutterChange\1\0\2\ttext\b‚Äæ\ahl\20GitGutterDelete\1\0\2\ttext\6_\ahl\20GitGutterDelete\1\0\2\ttext\6~\ahl\20GitGutterChange\1\0\0\1\0\2\ttext\6+\ahl\17GitGutterAdd\16watch_index\1\0\1\rinterval\3Ë\a\fkeymaps\1\0\v\vbuffer\2\17n <leader>hb0<cmd>lua require\"gitsigns\".blame_line()<CR>\to ah2:<C-U>lua require\"gitsigns\".select_hunk()<CR>\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\14n <c-a-j>/<cmd>lua require\"gitsigns\".next_hunk()<CR>\tx ah2:<C-U>lua require\"gitsigns\".select_hunk()<CR>\17n <leader>hr5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\fnoremap\2\14n <c-a-h>/<cmd>lua require\"gitsigns\".prev_hunk()<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hu0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\nsigns\1\0\2\18sign_priority\3\6\nnumhl\1\17changedelete\1\0\3\ttext\t‚ñê_\nnumhl\21GitSignsChangeNr\ahl\20GitGutterChange\14topdelete\1\0\3\ttext\b‚Äæ\nnumhl\21GitSignsDeleteNr\ahl\20GitGutterDelete\vdelete\1\0\3\ttext\6_\nnumhl\21GitSignsDeleteNr\ahl\20GitGutterDelete\vchange\1\0\3\ttext\b‚ñê\nnumhl\21GitSignsChangeNr\ahl\20GitGutterChange\badd\1\0\0\1\0\3\ttext\b‚ñã\nnumhl\18GitSignsAddNr\ahl\17GitGutterAdd\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["gv.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/gv.vim"
  },
  ["indent-guides.nvim"] = {
    config = { "\27LJ\2\2?\0\0\2\0\3\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\1K\0\1\0\nsetup\18indent_guides\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/indent-guides.nvim"
  },
  ["kosmikoa.nvim"] = {
    config = { "\27LJ\2\0026\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rkosmikoa\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/kosmikoa.nvim"
  },
  ["kuroi.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/kuroi.vim"
  },
  ["lsp-status.nvim"] = {
    config = { "\27LJ\2\2D\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\1\2\0B\1\1\1K\0\1\0\22register_progress\15lsp-status\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/lsp-status.nvim"
  },
  ["lsp-trouble.nvim"] = {
    commands = { "LspTrouble" },
    config = { "\27LJ\2\0029\0\0\2\0\3\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/lsp-trouble.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  luajob = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/luajob"
  },
  ["luvjob.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/luvjob.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  neorg = {
    config = { "\27LJ\2\2¢\2\0\0\6\0\17\0\0236\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\15\0005\2\3\0004\3\0\0=\3\4\0025\3\6\0005\4\5\0=\4\a\3=\3\b\0024\3\0\0=\3\t\0025\3\r\0005\4\v\0005\5\n\0=\5\f\4=\4\a\3=\3\14\2=\2\16\1B\0\2\1K\0\1\0\tload\1\0\0\21core.norg.dirman\1\0\0\15workspaces\1\0\0\1\0\1\17my_workspace\f~/neorg\24core.norg.concealer\18core.keybinds\vconfig\1\0\0\1\0\2\17neorg_leader\14<Leader>o\21default_keybinds\2\18core.defaults\1\0\0\nsetup\nneorg\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/neorg"
  },
  neoterm = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/neoterm"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  nerdtree = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nerdtree-execute"] = {
    commands = { "NERDTreeToggle", "NERDTreeFind" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nerdtree-execute"
  },
  ["nerdtree-git-plugin"] = {
    commands = { "NERDTreeToggle", "NERDTreeFind" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nerdtree-git-plugin"
  },
  ["nnn.vim"] = {
    commands = { "NnnPicker" },
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nnn.vim"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\2£\1\0\0\3\0\b\0\v6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0=\2\5\0015\2\6\0=\2\a\1B\0\2\1K\0\1\0\tscss\1\0\3\bcss\2\vrgb_fn\2\vcss_fn\2\bcss\1\0\3\bcss\2\vrgb_fn\2\vcss_fn\2\1\6\0\0\bvim\thtml\rmarkdown\btex\tsass\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\2≤\2\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0=\2\5\1B\0\2\1K\0\1\0\vsource\1\0\v\18snippets_nvim\1\14ultisnips\1\rnvim_lsp\2\ttags\2\nvsnip\1\tpath\2\nemoji\1\rnvim_lua\2\nspell\2\vbuffer\2\tcalc\1\1\0\t\17autocomplete\2\19source_timeout\3»\1\fenabled\2\ndebug\1\14preselect\fdisable\21incomplete_delay\3è\3\25allow_prefix_unmatch\1\15min_length\3\2\18throttle_time\3d\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\2≤\2\0\0\4\0\15\0\0196\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\0015\2\t\0005\3\b\0=\3\n\2=\2\v\0015\2\r\0005\3\f\0=\3\n\2=\2\14\1B\0\2\1K\0\1\0\ttray\1\0\2\vheight\3\n\rposition\vbottom\1\2\0\0\trepl\fsidebar\relements\1\0\2\rposition\nright\nwidth\3(\1\4\0\0\vscopes\vstacks\fwatches\rmappings\1\0\3\topen\6o\vremove\6d\vexpand\t<CR>\nicons\1\0\0\1\0\3\rcircular\b‚Ü∫\14collapsed\b‚Øà\rexpanded\b‚ØÜ\nsetup\ndapui\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-hlslens"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nvim-hlslens"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-jdtls"
  },
  ["nvim-lightbulb"] = {
    config = { "\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspfuzzy"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nvim-lspfuzzy"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-luapad"
  },
  ["nvim-moonmaker"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-moonmaker"
  },
  ["nvim-reload"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nvim-reload"
  },
  ["nvim-scrollview"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nvim-scrollview"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\2ﬁ\4\0\0\5\0\b\0\0186\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0B\0\2\2\15\0\0\0X\1\tÄ'\0\4\0006\1\0\0'\2\5\0B\1\2\0029\1\6\1'\2\3\0'\3\a\0\18\4\0\0B\1\4\1K\0\1\0\nfolds\14set_query\25vim.treesitter.queryª\3  [\n    (function_definition)\n    (class_definition)\n\n    (while_statement)\n    (for_statement)\n    (if_statement)\n    (with_statement)\n    (try_statement)\n\n    (import_from_statement)\n    (parameters)\n    (argument_list)\n\n    (parenthesized_expression)\n    (generator_expression)\n    (list_comprehension)\n    (set_comprehension)\n    (dictionary_comprehension)\n\n    (tuple)\n    (list)\n    (set)\n    (dictionary)\n\n    (string)\n  ] @fold\n  \vpython\15has_parser\28nvim-treesitter.parsers\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-commonlisp"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-treesitter-commonlisp"
  },
  ["nvim-treesitter-pairs"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-treesitter-pairs"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag"
  },
  ["nvim-ts-hint-textobject"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-ts-hint-textobject"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvimpager = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvimpager"
  },
  ["octo.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["pears.nvim"] = {
    config = { "\27LJ\2\2£\1\0\1\6\1\6\0\27-\1\0\0009\1\0\1\18\2\0\0+\3\0\0)\4\1\0B\1\4\3\15\0\2\0X\3\17Ä\6\2\1\0X\3\15Ä6\3\2\0009\3\3\3\18\4\2\0'\5\4\0B\3\3\2\14\0\3\0X\4\tÄ6\3\2\0009\3\3\3\18\4\2\0'\5\5\0B\3\3\2X\4\3Ä+\3\1\0X\4\1Ä+\3\2\0L\3\2\0\1¿\v[)%]}]\a%s\nmatch\vstring\5\26get_surrounding_chars \1\0\1\6\1\a\0$-\1\0\0009\1\0\1\18\2\0\0+\3\0\0)\4\1\0B\1\4\3\15\0\2\0X\3\16Ä\6\2\1\0X\3\14Ä6\3\2\0009\3\3\3\18\4\2\0'\5\4\0B\3\3\2\14\0\3\0X\4\aÄ6\3\2\0009\3\3\3\18\4\2\0'\5\5\0B\3\3\2\15\0\3\0X\4\vÄ\15\0\1\0X\3\bÄ\18\4\1\0009\3\3\1'\5\6\0B\3\3\2\19\3\3\0X\4\3Ä+\3\1\0X\4\1Ä+\3\2\0L\3\2\0\1¿\a%w\v[)%]}]\a%s\nmatch\vstring\5\26get_surrounding_charsF\0\1\2\0\3\1\v6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\2ÄK\0\1\0X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\15pumvisible\afn\bvim\2·\2\1\1\5\2\20\00009\1\0\0003\2\1\0B\1\2\0019\1\2\0'\2\3\0B\1\2\0019\1\2\0'\2\4\0B\1\2\0019\1\5\0'\2\6\0005\3\a\0-\4\0\0=\4\b\3B\1\3\0019\1\5\0'\2\t\0005\3\n\0-\4\0\0=\4\b\0035\4\v\0=\4\f\3B\1\3\0019\1\5\0'\2\r\0005\3\14\0-\4\0\0=\4\b\3B\1\3\0019\1\5\0'\2\15\0005\3\16\0-\4\1\0=\4\b\3B\1\3\0019\1\5\0'\2\17\0005\3\18\0-\4\1\0=\4\b\3B\1\3\0019\1\5\0'\2\r\0005\3\19\0-\4\0\0=\4\b\3B\1\3\1K\0\1\0\2¿\3¿\1\0\1\nclose\6]\1\0\1\nclose\6'\6'\1\0\1\nclose\6\"\6\"\1\0\1\nclose\6]\6[\14filetypes\1\2\0\0\nlatex\1\0\1\nclose\6$\6$\18should_expand\1\0\1\nclose\6}\6{\tpair\thtml\17tag_matching\vpreset\0\ron_enter^\1\0\6\0\a\0\r6\0\0\0'\1\1\0B\0\2\0026\1\0\0'\2\2\0B\1\2\0023\2\3\0003\3\4\0009\4\5\0003\5\6\0B\4\2\0012\0\0ÄK\0\1\0\0\nsetup\0\0\16pears.utils\npears\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/pears.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\2Q\0\0\3\0\4\0\b5\0\0\0006\1\1\0'\2\2\0B\1\2\0029\1\3\1\18\2\0\0B\1\2\1K\0\1\0\nsetup\15rust-tools\frequire\1\0\1\17autoSetHints\2\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/rust.vim"
  },
  ["snippets.nvim"] = {
    config = { "\27LJ\2\2m\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0Ninoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>\bcmd\bvim\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  spaceduck = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/spaceduck"
  },
  ["srcery-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/srcery-vim"
  },
  ["switch.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/switch.vim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    config = { "\27LJ\2\2A\0\0\2\0\3\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\1K\0\1\0\nsetup\20symbols-outline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim"
  },
  tagbar = {
    commands = { "TagbarToggle", "TagbarOpenAutoClose" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/tagbar"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    config = { "\27LJ\2\2¿\1\0\0\4\0\t\0\0176\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\6\0005\2\4\0005\3\3\0=\3\5\2=\2\a\1B\0\2\0016\0\0\0'\1\1\0B\0\2\0029\0\b\0'\1\5\0B\0\2\1K\0\1\0\19load_extension\15extensions\1\0\0\15fzy_native\1\0\0\1\0\2\28override_generic_sorter\1\25override_file_sorter\2\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["toast.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/toast.vim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["tokyonight-vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/tokyonight-vim"
  },
  ["tokyonight.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/tokyonight.nvim"
  },
  ["traces.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/traces.vim"
  },
  ["twilight.nvim"] = {
    config = { "\27LJ\2\2:\0\0\2\0\3\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\1K\0\1\0\nsetup\rtwilight\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/twilight.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vim-afterglow"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-afterglow"
  },
  ["vim-airline"] = {
    after = { "vim-airline-themes" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-airline"
  },
  ["vim-airline-themes"] = {
    load_after = {
      ["vim-airline"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-airline-themes"
  },
  ["vim-bbye"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-bbye"
  },
  ["vim-cmake-syntax"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-cmake-syntax"
  },
  ["vim-code-dark"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-code-dark"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-doge"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-doge"
  },
  ["vim-endwise"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-endwise"
  },
  ["vim-equinusocio-material"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-equinusocio-material"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-floaterm"] = {
    commands = { "FloatermToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-go"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-go"
  },
  ["vim-gtfo"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-gtfo"
  },
  ["vim-lore"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-lore"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-markdown-composer"] = {
    commands = { "ComposerStart" },
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-markdown-composer"
  },
  ["vim-merginal"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-merginal"
  },
  ["vim-moonfly-colors"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-moonfly-colors"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors"
  },
  ["vim-nerdtree-syntax-highlight"] = {
    commands = { "NERDTreeToggle", "NERDTreeFind" },
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-nerdtree-syntax-highlight"
  },
  ["vim-nightfly-guicolors"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-nightfly-guicolors"
  },
  ["vim-ocaml"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-ocaml"
  },
  ["vim-one"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-one"
  },
  ["vim-orgmode"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-orgmode"
  },
  ["vim-package-info"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-package-info"
  },
  ["vim-preview"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-preview"
  },
  ["vim-qml"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-qml"
  },
  ["vim-rebase-mode"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-rebase-mode"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-sexp"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-sexp"
  },
  ["vim-sexp-mappings-for-regular-people"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-sexp-mappings-for-regular-people"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-slime"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-slime"
  },
  ["vim-sneak"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-sneak"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-speeddating"
  },
  ["vim-spirv"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-spirv"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-template"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-template"
  },
  ["vim-test"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-test"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-textobj-entire"
  },
  ["vim-textobj-parameter"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-textobj-parameter"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-textobj-variable-segment"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-textobj-variable-segment"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-visual-star-search"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-visual-star-search"
  },
  vimtex = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vimtex"
  },
  ["virtual-types.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/virtual-types.nvim"
  },
  vlime = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vlime/vim/"
  },
  ["zephyr-nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/zephyr-nvim"
  },
  ["zig.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/zig.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Runtimepath customization
time([[Runtimepath customization]], true)
vim.o.runtimepath = vim.o.runtimepath .. ",/home/stephan/.local/share/nvim/site/pack/packer/opt/vlime/vim/"
time([[Runtimepath customization]], false)
-- Config for: nvim-dap-ui
time([[Config for nvim-dap-ui]], true)
try_loadstring("\27LJ\2\2≤\2\0\0\4\0\15\0\0196\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\0015\2\t\0005\3\b\0=\3\n\2=\2\v\0015\2\r\0005\3\f\0=\3\n\2=\2\14\1B\0\2\1K\0\1\0\ttray\1\0\2\vheight\3\n\rposition\vbottom\1\2\0\0\trepl\fsidebar\relements\1\0\2\rposition\nright\nwidth\3(\1\4\0\0\vscopes\vstacks\fwatches\rmappings\1\0\3\topen\6o\vremove\6d\vexpand\t<CR>\nicons\1\0\0\1\0\3\rcircular\b‚Ü∫\14collapsed\b‚Øà\rexpanded\b‚ØÜ\nsetup\ndapui\frequire\0", "config", "nvim-dap-ui")
time([[Config for nvim-dap-ui]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\2£\1\0\0\3\0\b\0\v6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0=\2\5\0015\2\6\0=\2\a\1B\0\2\1K\0\1\0\tscss\1\0\3\bcss\2\vrgb_fn\2\vcss_fn\2\bcss\1\0\3\bcss\2\vrgb_fn\2\vcss_fn\2\1\6\0\0\bvim\thtml\rmarkdown\btex\tsass\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: gitlinker.nvim
time([[Config for gitlinker.nvim]], true)
try_loadstring("\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14gitlinker\frequire\0", "config", "gitlinker.nvim")
time([[Config for gitlinker.nvim]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
try_loadstring("\27LJ\2\2≤\2\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0=\2\5\1B\0\2\1K\0\1\0\vsource\1\0\v\18snippets_nvim\1\14ultisnips\1\rnvim_lsp\2\ttags\2\nvsnip\1\tpath\2\nemoji\1\rnvim_lua\2\nspell\2\vbuffer\2\tcalc\1\1\0\t\17autocomplete\2\19source_timeout\3»\1\fenabled\2\ndebug\1\14preselect\fdisable\21incomplete_delay\3è\3\25allow_prefix_unmatch\1\15min_length\3\2\18throttle_time\3d\nsetup\ncompe\frequire\0", "config", "nvim-compe")
time([[Config for nvim-compe]], false)
-- Config for: snippets.nvim
time([[Config for snippets.nvim]], true)
try_loadstring("\27LJ\2\2m\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0Ninoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>\bcmd\bvim\0", "config", "snippets.nvim")
time([[Config for snippets.nvim]], false)
-- Config for: twilight.nvim
time([[Config for twilight.nvim]], true)
try_loadstring("\27LJ\2\2:\0\0\2\0\3\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\1K\0\1\0\nsetup\rtwilight\frequire\0", "config", "twilight.nvim")
time([[Config for twilight.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\2ﬁ\4\0\0\5\0\b\0\0186\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0B\0\2\2\15\0\0\0X\1\tÄ'\0\4\0006\1\0\0'\2\5\0B\1\2\0029\1\6\1'\2\3\0'\3\a\0\18\4\0\0B\1\4\1K\0\1\0\nfolds\14set_query\25vim.treesitter.queryª\3  [\n    (function_definition)\n    (class_definition)\n\n    (while_statement)\n    (for_statement)\n    (if_statement)\n    (with_statement)\n    (try_statement)\n\n    (import_from_statement)\n    (parameters)\n    (argument_list)\n\n    (parenthesized_expression)\n    (generator_expression)\n    (list_comprehension)\n    (set_comprehension)\n    (dictionary_comprehension)\n\n    (tuple)\n    (list)\n    (set)\n    (dictionary)\n\n    (string)\n  ] @fold\n  \vpython\15has_parser\28nvim-treesitter.parsers\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\2‘\14\0\0\4\0!\00026\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\14\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\2=\2\15\0015\2\16\0=\2\17\0015\2\18\0=\2\19\1B\0\2\1X\0\26Ä6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\26\0005\2\21\0005\3\20\0=\3\5\0025\3\22\0=\3\a\0025\3\23\0=\3\t\0025\3\24\0=\3\v\0025\3\25\0=\3\r\2=\2\15\0015\2\27\0005\3\28\0=\3\29\0025\3\30\0=\3\31\2=\2\17\0015\2 \0=\2\19\1B\0\2\1K\0\1\0\1\0\1\rinterval\3Ë\a\tn [c\1\2\1\0@&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'\texpr\2\tn ]c\1\2\1\0@&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'\texpr\2\1\0\t\vbuffer\2\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\17n <leader>hb0<cmd>lua require\"gitsigns\".blame_line()<CR>\to ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\tx ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hr5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\fnoremap\2\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hu0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\1\0\2\18sign_priority\3\6\nnumhl\1\1\0\2\ttext\6~\ahl\20GitGutterChange\1\0\2\ttext\b‚Äæ\ahl\20GitGutterDelete\1\0\2\ttext\6_\ahl\20GitGutterDelete\1\0\2\ttext\6~\ahl\20GitGutterChange\1\0\0\1\0\2\ttext\6+\ahl\17GitGutterAdd\16watch_index\1\0\1\rinterval\3Ë\a\fkeymaps\1\0\v\vbuffer\2\17n <leader>hb0<cmd>lua require\"gitsigns\".blame_line()<CR>\to ah2:<C-U>lua require\"gitsigns\".select_hunk()<CR>\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\14n <c-a-j>/<cmd>lua require\"gitsigns\".next_hunk()<CR>\tx ah2:<C-U>lua require\"gitsigns\".select_hunk()<CR>\17n <leader>hr5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\fnoremap\2\14n <c-a-h>/<cmd>lua require\"gitsigns\".prev_hunk()<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hu0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\nsigns\1\0\2\18sign_priority\3\6\nnumhl\1\17changedelete\1\0\3\ttext\t‚ñê_\nnumhl\21GitSignsChangeNr\ahl\20GitGutterChange\14topdelete\1\0\3\ttext\b‚Äæ\nnumhl\21GitSignsDeleteNr\ahl\20GitGutterDelete\vdelete\1\0\3\ttext\6_\nnumhl\21GitSignsDeleteNr\ahl\20GitGutterDelete\vchange\1\0\3\ttext\b‚ñê\nnumhl\21GitSignsChangeNr\ahl\20GitGutterChange\badd\1\0\0\1\0\3\ttext\b‚ñã\nnumhl\18GitSignsAddNr\ahl\17GitGutterAdd\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
try_loadstring("\27LJ\2\2Q\0\0\3\0\4\0\b5\0\0\0006\1\1\0'\2\2\0B\1\2\0029\1\3\1\18\2\0\0B\1\2\1K\0\1\0\nsetup\15rust-tools\frequire\1\0\1\17autoSetHints\2\0", "config", "rust-tools.nvim")
time([[Config for rust-tools.nvim]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\2-\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\18my_statusline\frequire\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)
-- Config for: neorg
time([[Config for neorg]], true)
try_loadstring("\27LJ\2\2¢\2\0\0\6\0\17\0\0236\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\15\0005\2\3\0004\3\0\0=\3\4\0025\3\6\0005\4\5\0=\4\a\3=\3\b\0024\3\0\0=\3\t\0025\3\r\0005\4\v\0005\5\n\0=\5\f\4=\4\a\3=\3\14\2=\2\16\1B\0\2\1K\0\1\0\tload\1\0\0\21core.norg.dirman\1\0\0\15workspaces\1\0\0\1\0\1\17my_workspace\f~/neorg\24core.norg.concealer\18core.keybinds\vconfig\1\0\0\1\0\2\17neorg_leader\14<Leader>o\21default_keybinds\2\18core.defaults\1\0\0\nsetup\nneorg\frequire\0", "config", "neorg")
time([[Config for neorg]], false)
-- Config for: telescope-fzy-native.nvim
time([[Config for telescope-fzy-native.nvim]], true)
try_loadstring("\27LJ\2\2¿\1\0\0\4\0\t\0\0176\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\6\0005\2\4\0005\3\3\0=\3\5\2=\2\a\1B\0\2\0016\0\0\0'\1\1\0B\0\2\0029\0\b\0'\1\5\0B\0\2\1K\0\1\0\19load_extension\15extensions\1\0\0\15fzy_native\1\0\0\1\0\2\28override_generic_sorter\1\25override_file_sorter\2\nsetup\14telescope\frequire\0", "config", "telescope-fzy-native.nvim")
time([[Config for telescope-fzy-native.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
vim.cmd [[command! -nargs=* -range -bang -complete=file LspTrouble lua require("packer.load")({'lsp-trouble.nvim'}, { cmd = "LspTrouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file TagbarToggle lua require("packer.load")({'tagbar'}, { cmd = "TagbarToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file TagbarOpenAutoClose lua require("packer.load")({'tagbar'}, { cmd = "TagbarOpenAutoClose", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file NERDTreeFind lua require("packer.load")({'nerdtree-execute', 'vim-nerdtree-syntax-highlight', 'nerdtree-git-plugin'}, { cmd = "NERDTreeFind", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Cheat lua require("packer.load")({'cheat.sh-vim'}, { cmd = "Cheat", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file NnnPicker lua require("packer.load")({'nnn.vim'}, { cmd = "NnnPicker", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file NERDTreeToggle lua require("packer.load")({'nerdtree-execute', 'vim-nerdtree-syntax-highlight', 'nerdtree-git-plugin'}, { cmd = "NERDTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file FloatermToggle lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file ComposerStart lua require("packer.load")({'vim-markdown-composer'}, { cmd = "ComposerStart", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'vim-endwise'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType toml ++once lua require("packer.load")({'rust.vim'}, { ft = "toml" }, _G.packer_plugins)]]
vim.cmd [[au FileType qml ++once lua require("packer.load")({'vim-qml'}, { ft = "qml" }, _G.packer_plugins)]]
vim.cmd [[au FileType org ++once lua require("packer.load")({'vim-orgmode'}, { ft = "org" }, _G.packer_plugins)]]
vim.cmd [[au FileType vlime_repl ++once lua require("packer.load")({'vim-sexp-mappings-for-regular-people', 'vim-sexp'}, { ft = "vlime_repl" }, _G.packer_plugins)]]
vim.cmd [[au FileType fennel ++once lua require("packer.load")({'vim-sexp-mappings-for-regular-people', 'vim-sexp'}, { ft = "fennel" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'vim-test', 'rust.vim'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType fsharp ++once lua require("packer.load")({'LanguageClient-neovim', 'Ionide-vim'}, { ft = "fsharp" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'vim-go'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'vim-test'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType scheme ++once lua require("packer.load")({'vim-sexp-mappings-for-regular-people', 'vim-sexp'}, { ft = "scheme" }, _G.packer_plugins)]]
vim.cmd [[au FileType clojure ++once lua require("packer.load")({'vim-sexp-mappings-for-regular-people', 'vim-sexp'}, { ft = "clojure" }, _G.packer_plugins)]]
vim.cmd [[au FileType query ++once lua require("packer.load")({'vim-sexp-mappings-for-regular-people', 'vim-sexp'}, { ft = "query" }, _G.packer_plugins)]]
vim.cmd [[au FileType zig ++once lua require("packer.load")({'zig.vim'}, { ft = "zig" }, _G.packer_plugins)]]
vim.cmd [[au FileType lisp ++once lua require("packer.load")({'vim-sexp-mappings-for-regular-people', 'vim-sexp', 'vlime'}, { ft = "lisp" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'vim-markdown-composer'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/zig.vim/ftdetect/zig.vim]], true)
vim.cmd [[source /home/stephan/.local/share/nvim/site/pack/packer/opt/zig.vim/ftdetect/zig.vim]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/zig.vim/ftdetect/zig.vim]], false)
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-orgmode/ftdetect/org.vim]], true)
vim.cmd [[source /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-orgmode/ftdetect/org.vim]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-orgmode/ftdetect/org.vim]], false)
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], true)
vim.cmd [[source /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], false)
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/Ionide-vim/ftdetect/fsharp.vim]], true)
vim.cmd [[source /home/stephan/.local/share/nvim/site/pack/packer/opt/Ionide-vim/ftdetect/fsharp.vim]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/Ionide-vim/ftdetect/fsharp.vim]], false)
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], true)
vim.cmd [[source /home/stephan/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], false)
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-qml/ftdetect/qml.vim]], true)
vim.cmd [[source /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-qml/ftdetect/qml.vim]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-qml/ftdetect/qml.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
