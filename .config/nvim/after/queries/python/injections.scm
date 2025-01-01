;; extends

(call
  function: (attribute
    attribute: (identifier) @_sql)
  arguments: (argument_list
    .
    (string
      (string_content) @injection.content))
  (#any-of? @_sql "read_sql_query" "execute")
  (#set! injection.language "sql"))
