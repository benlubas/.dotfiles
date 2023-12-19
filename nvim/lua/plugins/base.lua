return {
  { "tpope/vim-sleuth" },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  { "benlubas/auto-save.nvim", cond = not MarkdownMode() },
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>u",
        ":UndotreeToggle<CR>:UndotreeFocus<CR>",
        desc = "toggle undotree",
        silent = true,
      },
    },
  },
  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 2, -- MiB (2 MiB is just over 2MB)
      features = {
        "indent_blankline",
        "lsp",
        "treesitter",
        "syntax",
        -- "matchparen", -- I'm not sure about this having a large impact on perf, and it stays disabled, so I'm going to comment it out
        "vimopts",
        "filetype",
        {
          name = "neoscroll",
          disable = function()
            vim.api.nvim_buf_set_var(0, "disable_neoscroll", true)
          end,
        },
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk", "kj" }, -- why not both
    },
  },
  {
    "stevearc/oil.nvim",
    dev = true, -- currently a hack to make chmod stuff not editable
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local permission_hlgroups = {
        ["-"] = "NonText",
        ["r"] = "Normal",
        ["w"] = "Normal",
        ["x"] = "MoonflyOrchid",
      }
      local type_hlgroups = {
        ["-"] = "NonText",
        ["d"] = "MoonflyBlue",
        ["p"] = "MoonflyCranberry",
        ["l"] = "MoonflyPurple",
        ["s"] = "MoonflyCranberry",
      }
      local size_hlgroup = "MoonflyBlue"
      local mtime_hlgroup = "NonText"

      require("oil").setup({
        columns = {
          {
            "type",
            icons = {
              directory = "d",
              fifo = "p",
              file = "-",
              link = "l",
              socket = "s",
            },
            highlight = function(type_str)
              return type_hlgroups[type_str]
            end,
          },
          {
            "permissions",
            highlight = function(permission_str)
              local hls = {}
              for i = 1, #permission_str do
                local char = permission_str:sub(i, i)
                table.insert(hls, { permission_hlgroups[char], i - 1, i })
              end
              return hls
            end,
          },
          { "size",  highlight = size_hlgroup },
          { "mtime", highlight = mtime_hlgroup },
          { "icon" },
        },
        normal_uneditable = { "permissions" },
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
        buf_options = {
          filetype = "oil",
        },
        win_options = {
          signcolumn = "yes",
          cursorcolumn = false,
          foldcolumn = "1",
          spell = false,
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = false,
          ["<C-h>"] = false,
          ["<C-t>"] = false,
          ["<C-p>"] = false,
          ["<C-c>"] = false,
          ["<C-l>"] = false,
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = "none",
          win_options = {
            winblend = 14,
          },
        },
      })

      vim.keymap.set("n", "-", function()
        require("oil").open()
      end, { desc = "Open parent directory" })
    end,
  },
  {
    "echasnovski/mini.trailspace",
    keys = {
      {
        "<leader>ds",
        ":lua require('mini.trailspace').trim()<CR>",
        desc = "trim trailing whitespace",
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set("n", "<leader>fo", require("ufo").openAllFolds, { desc = "open all folds" })
      vim.keymap.set("n", "<leader>fc", require("ufo").closeAllFolds, { desc = "close all folds" })
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
