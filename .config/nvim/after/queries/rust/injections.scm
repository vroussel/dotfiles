; extends

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Ss][Ee][Ll][Ee][Cc][Tt]%s+.+[Ff][Rr][Oo][Mm]"))

; Highlight SQL injections with custom group
(#set! injection.highlight "SQLInjectionHighlight")

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Ww][Ii][Tt][Hh]%s+.*[Aa][Ss].*"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Uu][Pp][Ss][Ee][Rr][Tt]%s+[Ii][Nn][Tt][Oo]%s+.*"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Ee][Xx][Pp][Ll][Aa][Ii][Nn]"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Aa][Ll][Tt][Ee][Rr]%s+[Tt][Aa][Bb][Ll][Ee]%s+.*"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Tt][Rr][Uu][Nn][Cc][Aa][Tt][Ee]%s+[Tt][Aa][Bb][Ll][Ee]%s+.*"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Dd][Rr][Oo][Pp]%s+[Tt][Aa][Bb][Ll][Ee]%s+.*"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Ii][Nn][Ss][Ee][Rr][Tt]%s+[Ii][Nn][Tt][Oo]"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Ii][Nn][Dd][Ee][Xx]"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Dd][Rr][Oo][Pp]%s+[Ii][Nn][Dd][Ee][Xx]"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Uu][Pp][Dd][Aa][Tt][Ee]%s+.+[Ss][Ee][Tt]"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Dd][Ee][Ll][Ee][Tt][Ee]%s+[Ff][Rr][Oo][Mm]"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Tt][Aa][Bb][Ll][Ee]"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Uu][Ss][Ee][Rr]"))

([
  (string_content)
  ]@injection.content
 (#set! injection.language "sql")
 (#set! injection.include-children)
 (#any-lua-match? @injection.content
  "^%s*[Pp][Rr][Aa][Gg][Mm][Aa]%s+journal_mode"))

