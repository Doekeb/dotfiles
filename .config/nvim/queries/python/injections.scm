; This one isn't all that great due to the string possibly being a descendant of the next sibling.
; (
;   (comment) @magic_comment (#match? @magic_comment "!sql")
;   .
;   (string
;     (string_content) @injection.content (#set! injection.language "sql")
;   )
; )

(
  (string_content) @injection.content (#match? @injection.content "-- !sql") (#set! priority 151) (#set! injection.language "sql")
)
