-- this is the file for repl like functionality in code.
-- quarto.nvim is kinda related, as it lets me edit jupyter notebook type files, but that has it's
-- own config file
return {
  {
    "benlubas/molten-nvim",
    -- dependencies = { "3rd/image.nvim" },
    dependencies = { "benlubas/image.nvim", dev = true },
    dev = true,
    build = ":UpdateRemotePlugins",
    init = function()
      -- vim.g.molten_output_win_border = { "", { "━", "MoonflySky" }, "", "", }
      -- vim.g.molten_output_window_border = {
      --   { "🬭", "MoonflySky" },
      --   { "🬭", "MoonflySky" },
      --   { "🬭", "MoonflySky" },
      --   "",
      --   { "🬂", "MoonflySky" },
      --   { "🬂", "MoonflySky" },
      --   { "🬂", "MoonflySky" },
      --   "",
      -- }
      -- vim.g.molten_output_win_highlight = "Normal"
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_wrap_output = true

      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
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
          require("benlubas.quarto_code_runner").attach_run_mappings()
          -- setup some molten specific keybindings
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
    "Olical/conjure",
    -- this plugin is configured with global variables, :h conjure-config to see them
    config = function()
      vim.keymap.set("n", "<localleader>ir", function()
        local evcxr = require("conjure.client.rust.evcxr")
        evcxr.start()

        -- TODO: can this go in a conjure hook?
        require("benlubas.quarto_code_runner").attach_run_mappings()
        require("benlubas.quarto_code_runner").attach_conjure_mappings()
      end, { desc = "start evcxr for rust" })

      -- local leader is `\` which is sym + c on my keyboard
      vim.g["conjure#mapping#eval_comment_current_form"] = "o"

      -- This doesn't show up all the time though, this is just when we're in a rust buffer
      vim.g["conjure#client#rust#evcxr#mapping#start"] = "ir" -- init rust
    end,
  },
  -- { "morsecodist/magma-nvim" },
}
