return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = true,
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
    },
  },
}
