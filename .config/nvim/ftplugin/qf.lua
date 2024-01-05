vim.keymap.set("n", "R", ":cdo s//g<left><left>", { silent = true, buffer = true, noremap = true })
vim.keymap.set("n", "L", ":ldo s//g<left><left>", { silent = true, buffer = true, noremap = true })
