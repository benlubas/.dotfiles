return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set("n", "<leader>Fo", require("ufo").openAllFolds, { desc = "open all folds" })
      vim.keymap.set("n", "<leader>Fc", require("ufo").closeAllFolds, { desc = "close all folds" })
      vim.keymap.set("n", "<leader>i", "za", { desc = "toggle fold" })

      -- Need to disable this plugin in some files. Specifically ones that have custom folds or
      -- don't need folds
      local ufo_disable_augroup = vim.api.nvim_create_augroup("ufo_disable_augroup", { clear = true })
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.norg" },
        group = ufo_disable_augroup,
        callback = function()
          require("ufo").detach()
        end,
      })

      ---@diagnostic disable-next-line: missing-fields
      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = ("  %d "):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
      })
    end,
  },
}
