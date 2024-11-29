;; extends

(call
  function: (attribute
    attribute: (identifier) @_sql)
  arguments: (argument_list
    .
    (string
      (string_content) @injection.content))
  (#eq? @_sql "read_sql_query")
  (#set! injection.language "sql"))
