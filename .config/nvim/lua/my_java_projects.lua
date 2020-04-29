#! /usr/bin/env lua
--
-- my_java_project.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

M = {}

M.get_java_main_classes = function()
    local main_files = vim.fn.systemlist('rg "(public|static)\\s*(public|static)\\s*void\\s*main" -l')
    for i, f in ipairs(main_files) do
      main_files[i] = string.gsub(string.gsub(f, '/', '.'), '(.*%.java%.)(.*).java', '%2')
    end
    return main_files
end

M.launch_java_main = function(main_class)
  M.last_main = main_class
  vim.cmd('T ./gradlew run -PmainClass='..main_class)
end

M.launch_java_main = function(main_class)
  M.last_main = main_class
  vim.cmd('T ./gradlew run -PmainClass='..main_class)
end

return M
