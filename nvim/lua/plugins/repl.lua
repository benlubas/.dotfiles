-- this is the file for repl like functionality in code.
-- quarto.nvim is kinda related, as it lets me edit jupyter notebook type files, but that has it's
-- own config file
return {
  {
    "Olical/conjure",
    setup = function()
      -- this plugin is configured with global variables, :h conjure-config to see them

      -- local leader is `\` which is sym + c on my keyboard
      vim.g["conjure#mapping#eval_comment_current_form"] = "o"
    end,
  },
  {
    -- "dccsillag/magma-nvim",
    "benlubas/magma-nvim",
    dev = true,
    init = function()
      vim.g.magma_output_window_borders = false
      vim.g.magma_automatically_open_output = false

      vim.keymap.set("n", "<localleader>mp", function()
        vim.cmd("MagmaInit python3")
      end, { desc = "Initialize Magma for python3", silent = true, noremap = true })

      -- Magma is currently setup for python3
      vim.api.nvim_create_autocmd("User", {
        pattern = "MagmaInitPost",
        callback = function()
          -- setup some magma specific keybindings
          vim.keymap.set("n", "<localleader>o", "vib:<C-u>MagmaEvaluateVisual<CR>gv<ESC>_",
            { desc = "execute code cell", silent = true, remap = true })
          vim.keymap.set("n", "<localleader>O", function()
            require("benlubas.magma_functions").run_all_above("python")
          end, { desc = "find the next cell" })
          vim.keymap.set("n", "<localleader>v", ":MagmaShowOutput<CR>",
            { desc = "open output window", silent = true })
        end,
      })
    end,
  },
}
