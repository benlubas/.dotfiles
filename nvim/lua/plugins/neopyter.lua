return {
  {
    "SUSTech-data/neopyter",
    enabled = false,
    opts = {
      mode = "direct",
      remote_address = "127.0.0.1:9001",
      file_pattern = { "*.ju.*" },
      on_attach = function(buf)
        -- do some buffer keymap
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = buf })
        end
        -- same, recommend the former
        map("n", "<C-Enter>", "<cmd>Neopyter execute notebook:run-cell<cr>", "run selected")
        -- same, recommend the former
        map("n", "<space>X", "<cmd>Neopyter execute notebook:run-all-above<cr>", "run all above cell")

        -- same, recommend the former, but the latter is silent
        map("n", "<space>nt", "<cmd>Neopyter execute kernelmenu:restart<cr>", "restart kernel")
        map("n", "<S-Enter>", "<cmd>Neopyter execute runmenu:run<cr>", "run selected and select next")
        map("n", "<M-Enter>", "<cmd>Neopyter execute run-cell-and-insert-below<cr>", "run selected and insert below")
        map("n", "<F5>", "<cmd>Neopyter execute notebook:restart-run-all<cr>", "restart kernel and run all")
      end,
      highlight = {
        enable = true,
        shortsighted = false,
      },
      parser = {
        -- trim leading/tailing whitespace of cell
        trim_whitespace = false,
      },
    },
  },
}
