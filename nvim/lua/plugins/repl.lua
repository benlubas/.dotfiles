-- this is the file for repl like functionality in code.
-- quarto.nvim is kinda related, as it lets me edit jupyter notebook type files, but that has it's
-- own config file
return {
  { "goerz/jupytext.vim" },
  {
    "benlubas/molten-nvim",
    dependencies = { "3rd/image.nvim" },
    -- dependencies = { "benlubas/image.nvim", dev = true },
    dev = true,
    build = ":UpdateRemotePlugins",
    init = function()
      -- vim.g.molten_show_mimetype_debug = true
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_crop_border = true
      -- vim.g.molten_output_show_more = true
      vim.g.molten_output_win_border = { "", "━", "", "" }
      vim.g.molten_output_win_max_height = 10
      -- vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true

      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
      vim.keymap.set("n", "<localleader>ir", function()
        vim.cmd("MoltenInit rust")
      end, { desc = "Initialize Molten for Rust", silent = true })
      vim.keymap.set("n", "<localleader>ip", function()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv ~= nil then
          -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
          venv = string.match(venv, "/.+/(.+)")
          vim.cmd(("MoltenInit %s"):format(venv))
        else
          vim.cmd("MoltenInit python3")
        end
      end, { desc = "Initialize Molten for python3", silent = true, noremap = true })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInitPost",
        callback = function()
          -- quarto code runner mappings
          local r = require("quarto.runner")
          vim.keymap.set("n", "<localleader>rc", r.run_cell, { desc = "run cell", silent = true })
          vim.keymap.set("n", "<localleader>ra", r.run_above, { desc = "run cell and above", silent = true })
          vim.keymap.set("n", "<localleader>rb", r.run_below, { desc = "run cell and below", silent = true })
          vim.keymap.set("n", "<localleader>rl", r.run_line, { desc = "run line", silent = true })
          vim.keymap.set("n", "<localleader>rA", r.run_all, { desc = "run all cells", silent = true })
          vim.keymap.set("n", "<localleader>RA", function()
            r.run_all(true)
          end, { desc = "run all cells of all languages", silent = true })

          -- setup some molten specific keybindings
          vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
          vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
          vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
            { desc = "execute visual selection", silent = true })
          vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>",
            { desc = "open output window", silent = true })
          vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
          local open = false
          vim.keymap.set("n", "<localleader>ot", function()
            open = not open
            vim.fn.MoltenUpdateOption("auto_open_output", open)
          end)
        end,
      })
    end,
  },
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "neovim"
    end,
  },
}
