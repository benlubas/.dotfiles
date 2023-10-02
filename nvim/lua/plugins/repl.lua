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
    -- "dccsillag/magma-nvim",
    "benlubas/magma-nvim",
    dependencies = { "benlubas/image.nvim", dev = true },
    dev = true,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.magma_output_window_borders = false
      vim.g.magma_automatically_open_output = false
      -- vim.g.magma_image_provider = "kitty"
      vim.g.magma_image_provider = "image.nvim"
      vim.g.magma_enter_output_behavior = "open_then_enter"

      vim.keymap.set("n", "<localleader>ip", function()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv ~= nil then
          -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
          venv = string.match(venv, "/.+/(.+)")
          vim.cmd(("MagmaInit %s"):format(venv))
        else
          vim.cmd("MagmaInit python3")
        end
      end, { desc = "Initialize Magma for python3", silent = true, noremap = true })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MagmaInitPost",
        callback = function()
          require("benlubas.quarto_code_runner").attach_run_mappings()
          -- setup some magma specific keybindings
          vim.keymap.set("n", "<localleader>ov", ":noautocmd MagmaEnterOutput<CR>",
            { desc = "open output window", silent = true })
          vim.keymap.set("v", "<localleader>r", ":<C-u>MagmaEvaluateVisual<CR>gv",
            { desc = "execute visual selection", silent = true })
          vim.keymap.set("n", "<localleader>oh", ":MagmaHideOutput<CR>",
            { desc = "close output window", silent = true })
        end,
      })
    end,
  },
}
