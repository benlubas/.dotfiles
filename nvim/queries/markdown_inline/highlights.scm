;; extends

((shortcut_link
   ((link_text) @text
                (#eq? @text "!WARNING"))
   ) @text.warning (#set! conceal ""))

((shortcut_link
   ((link_text) @text
                (#eq? @text "!INFO"))
   ) @text.title.help (#set! conceal ""))

((shortcut_link
   ((link_text) @text
                (#eq? @text "!IMPORTANT"))
   ) @text.title (#set! conceal ""))
