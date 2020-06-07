--
-- lsp-ext.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

M = {}

M.switch_header_source = function()
    vim.lsp.buf_request(
        0,
        "textDocument/switchSourceHeader",
        vim.lsp.util.make_text_document_params(),
        function(err, _, result, _, _)
            if err then
                print(err)
            else
                vim.cmd('e '..vim.uri_to_fname(result))
            end
        end
    )
end

return M
