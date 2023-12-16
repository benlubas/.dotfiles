-- File with all things related to auto complete (excluding the LSP server stuff itself)

local winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel"

local ELLIPSIS_CHAR = "..."
local MAX_LABEL_WIDTH = 25

return {
  {
    "benlubas/nvim-cmp",
    branch = "up_to_date",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer" },
      {
        "petertriho/cmp-git",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
          filetypes = { "gitcommit", "gitrebase", "markdown" }, -- markdown covers gh edits, which are markdown files
        },
      },
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      vim.api.nvim_set_hl(0, "CmpItemAbbr", {})
      local cmp = require("cmp")

      local keys = {
        ["<C-n>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-c>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        }),
      }

      -- key mappings for Alt+number to select, have to press enter after to confirm though
      for i = 0, 9, 1 do
        local key = table.concat({ "<M-", i, ">" })
        keys[key] = function(fallback)
          if cmp.visible() and #cmp.get_entries() > i then
            return cmp.select_nth(i + 1)
          end

          return fallback()
        end
      end

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = {
            winhighlight = winhighlight,
            col_offset = -2,
          },
          documentation = {
            winhighlight = winhighlight,
          },
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        mapping = keys,
        formatting = {
          number_options = {
            start_index = 0,
            end_index = 9,
          },
          fields = { "num", "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
              vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            end
            return vim_item
          end,
        },
        -- Installed sources
        sources = {
          { name = "git" },
          { name = "neorg" },
          { name = "otter" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      ls.setup({
        history = false,
        update_events = { "TextChanged", "TextChangedI" },
      })
      require("snippets") -- loading custom snippets

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true, desc = "expand snippet or jump to the next snippet node" })

      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true, desc = "previous spot in the snippet" })

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true, desc = "next snippet choice" })

      vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end, { silent = true, desc = "previous snippet choice" })
    end,
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   dependencies = {
  --     { "benlubas/nvim-cmp" },
  --   },
  --   config = function()
  --     require("nvim-autopairs").setup({
  --       check_ts = true,
  --       fast_wrap = {
  --         map = '<A-e>',
  --         chars = { '{', '[', '(', '"', "'", "`" },
  --         pattern = [=[[%'%"%>%]%)%}%,]]=],
  --         end_key = '$',
  --         before_key = 'h',
  --         after_key = 'l',
  --         cursor_pos_before = true,
  --         keys = 'qwertyuiopzxcvbnmasdfghjkl',
  --         manual_position = true,
  --         highlight = 'Search',
  --         highlight_grey = 'Comment'
  --       },
  --     })
  --     -- If you want insert `(` after select function or method item
  --     local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  --     require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --   end,
  -- },
  {
    "altermo/ultimate-autopair.nvim", -- :h ultimate-autopairs
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {
      fastwarp = {
        enable = true,
        enable_normal = true,
        enable_reverse = true,
        hopout = false,
        --{(|)} > fastwarp > {(}|)
        map = "<A-e>",
        rmap = "<A-b>",
        cmap = "<A-e>",
        rcmap = "<A-b>",
        nocursormove = true,
        do_nothing_if_fail = true,
        no_filter_nodes = { "string", "raw_string", "string_literals", "character_literal" },
        --which nodes to skip for tsnode filtering
        faster = false, -- TODO: I'm not sure if I want to enable this or not
        --only enables jump over pair, goto end/next line
        --useful for the situation of:
        --{|}M.foo('bar') > {M.foo('bar')|}
      },
      close = {
        enable = true,
        map = { "<A-)>", "<A-]>", "<A-}>" },
        cmap = { "<A-)>", "<A-]>", "<A-}>" },
      },
    },
  },
}
