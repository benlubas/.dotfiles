;; extends

(ranged_verbatim_tag
 (tag_name) @tag_name (#eq? @tag_name "code")
 (ranged_verbatim_tag_content) @code_cell.inner) @code_cell.outer
