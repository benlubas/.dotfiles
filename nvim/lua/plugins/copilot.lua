return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  -- enabled = false,
  opts = {
    suggestion = {
      enabled = false, -- off by default, enable with :Copilot enable
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-j>",
        prev = "<M-k>",
        dismiss = "<M-h>",
      },
    },
    filetypes = {
      norg = false,
      quarto = false, -- it get's very confused
    },
  },
}
