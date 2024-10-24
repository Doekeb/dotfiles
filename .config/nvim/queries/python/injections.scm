(
  (comment) @magic_comment (#match? @magic_comment "!sql")
  (string
    (string_content) @injection.content (#set! injection.language "sql")
  )
)

