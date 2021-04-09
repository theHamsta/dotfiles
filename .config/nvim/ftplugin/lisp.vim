setlocal nospell
nnoremap <Leader>am :Gcommit -v --amend<CR>




lua <<EOF
        require "compe".setup {
          enabled = false,
          autocomplete = false,
          debug = false,
          min_length = 2,
          preselect = "disable",
          throttle_time = 80,
          source_timeout = 200,
          incomplete_delay = 399,
          allow_prefix_unmatch = false,
          source = {
            path = true,
            buffer = true,
            calc = true,
            vsnip = false,
            nvim_lsp = true,
            nvim_lua = true,
            spell = true,
            tags = true,
            snippets_nvim = false
          }
        }
EOF
