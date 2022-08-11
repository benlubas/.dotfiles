
require('Comment').setup {
  toggler = {
    -- Line-comment toggle keymap
    line = 'glg',
    -- Block-comment toggle keymap (this one doesn't do the whole line, it does 
    -- to the end of the line.
    block = 'gaa',
  },
  opleader = {
    line = 'gl',
    block = 'ga',
  },
  extra = {
    -- Add comment on the line above
    above = 'glO',
    -- Add comment on the line below
    below = 'glo',
    -- Add comment at the end of line
    eol = 'glA',
  },
}
