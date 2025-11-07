; (identifier) @identifier
; (field) @field
; (map) @map
; (list) @list
; (document) @document
; (list (element) @element)

(map) @map
(document) @document
(list) @list
(field) @field
(element) @element

(field
  (_) @identifier
  (_) @assignment
  (_) @element
  (_) @termination)

; (field
;   (_) .
;   (assignment) .
;
;   (termination) @termination)
;
; (field
;   (identifier) .
;   (_) .
;   (element) .
;   (termination) @assignment)
;
; (field
;   (identifier) .
;   (assignment) .
;   (_) .
;   (termination) @element)
;
; (field
;   (identifier) .
;   (assignment) .
;   (element) .
;   (_) @termination)
