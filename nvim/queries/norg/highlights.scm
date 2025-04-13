;; extends

; ((shortcut_link
;    ((link_text) @text
;                 (#eq? @text "!WARNING"))
;    ) @text.warning (#set! conceal ""))
;
; ((shortcut_link
;    ((link_text) @text
;                 (#eq? @text "!INFO"))
;    ) @text.title.help (#set! conceal ""))
;
; ((shortcut_link
;    ((link_text) @text
;                 (#eq? @text "!IMPORTANT"))
;    ) @text.title (#set! conceal ""))

(quote
  (strong_carryover_set
    (strong_carryover
      name: (tag_name
              (word))) @keyword.return (#gsub! @keyword.return ".*(warning)" "_%1_") (#eq? @keyword.return "#warning"))
  )

((quote
  (strong_carryover_set
    (strong_carryover
      name: (tag_name
              (word))) @name (#eq? @name "#warning"))
  ) @keyword.return (#set! priority 101))
