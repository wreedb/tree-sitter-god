(comment) @comment
(string) @string
[";"] @punctuation.delimiter
["{" "}" "[" "]"] @punctuation.bracket
["="] @operator

(identifier) @variable

(field
  ["="] @punctuation.delimiter)

(element
  (number) @number)
(element
  (string) @string)
(element
  (bool) @boolean)
(element
  (null) @null)

(document
  (field
    (identifier) @keyword))
