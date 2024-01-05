vim.keymap.set("n", "R", function()
  if vim.fn.getloclist(0, { winid = 0 }).winid == 0 then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":cdo s//g<left><left>", true, false, true), "n", false)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":ldo s//g<left><left>", true, false, true), "n", false)
  end
end, { silent = true, buffer = true, noremap = true })
