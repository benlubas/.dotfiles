-- this is the file for repl like functionality in code.
-- quarto.nvim is kinda related, as it lets me edit jupyter notebook type files, but that has it's
-- own config file
return {
  {
    "Olical/conjure",
    -- this plugin is configured with global variables, :h conjure-config to see them
    config = function()
      vim.keymap.set("n", "<localleader>ir", function()
        local evcxr = require("conjure.client.rust.evcxr")
        evcxr.start()

        -- TODO: can this go in a conjure hook?
        require('benlubas.quarto_code_runner').attach_run_mappings()
        require('benlubas.quarto_code_runner').attach_conjure_mappings()
      end, { desc = "start evcxr for rust" })

      -- local leader is `\` which is sym + c on my keyboard
      vim.g["conjure#mapping#eval_comment_current_form"] = "o"

      -- This doesn't show up all the time though, this is just when we're in a rust buffer
      vim.g["conjure#client#rust#evcxr#mapping#start"] = "ir" -- init rust
    end,
  },
  {
    "benlubas/molten-nvim",
    dependencies = { "3rd/image.nvim" },
    dev = true,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_output_window_borders = false
      vim.g.molten_automatically_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_enter_output_behavior = "open_then_enter"

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
          vim.keymap.set("n", "<localleader>ov", ":noautocmd MoltenEnterOutput<CR>",
            { desc = "open output window", silent = true })
          vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
            { desc = "re-eval cell", silent = true })
          vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
            { desc = "execute visual selection", silent = true })
          vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>",
            { desc = "close output window", silent = true })
        end,
      })
    end,
  },
}
