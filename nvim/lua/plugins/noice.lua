---@diagnostic disable: missing-fields

return {
  {
    "folke/noice.nvim",
    -- enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        enabled = true,   -- enables the Noice cmdline UI
        view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {
          border = {
            -- style = "none", -- this line breaks lsp-rename...
            padding = { 0, 1 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        }, -- global options for the cmdline. See section on views
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          search_down = { conceal = false, icon = "", view = "cmdline" },
          search_up = { conceal = false, icon = "", view = "cmdline" },
          cmdline = false,
          filter = false,
          lua = false,
          help = false,
          input = {}, -- Used by input()
        },
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true,            -- enables the Noice messages UI
        view = "mini",             -- default view for messages
        view_error = "mini",       -- view for errors
        view_warn = "mini",        -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = false,       -- view for search count messages. Set to `false` to disable
      },
      popupmenu = {
        enabled = true,  -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "nui", -- backend to use to show regular cmdline completions
      },
      -- default options for require('noice').redirect
      -- see the section on Command Redirection
      ---@type NoiceRouteConfig
      redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      },
      -- You can add any custom commands below that will be available with `:Noice command`
      ---@type table<string, NoiceCommand>
      commands = {
        history = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp",      kind = "message" },
            },
          },
        },
        -- :Noice last
        last = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp",      kind = "message" },
            },
          },
          filter_opts = { count = 1 },
        },
        -- :Noice errors
        errors = {
          -- options for the message history that you get with `:Noice`
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
      },
      notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = true,
        view = "mini",
      },
      lsp = {
        progress = {
          enabled = false, -- this is insanely buggy
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = "lsp_progress",
          --- @type NoiceFormat|string
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = false,
          -- override cmp documentation with Noice (needs the other options to work)
          ["cmp.entry.get_documentation"] = false,
        },
        hover = {
          enabled = true,
          silent = false, -- set to true to not show a message if hover is not available
          view = nil,     -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {},      -- merged with defaults from documentation
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 20,  -- Debounce lsp signature help request (50ms default)
          },
          view = nil,       -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {},        -- merged with defaults from documentation
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "popup",
          opts = {},
        },
        -- defaults for hover and signature help
        documentation = {
          view = "hover",
          ---@type NoiceViewOptions
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "nc", conceallevel = 3 },
          },
        },
      },
      -- markdown = {
      --   hover = {
      --     ["|(%S-)|"] = vim.cmd.help, -- vim help links
      --     ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
      --   },
      --   highlights = {
      --     ["|%S-|"] = "@text.reference",
      --     ["@%S+"] = "@parameter",
      --     ["^%s*(Parameters:)"] = "@text.title",
      --     ["^%s*(Return:)"] = "@text.title",
      --     ["^%s*(See also:)"] = "@text.title",
      --     ["{%S-}"] = "@parameter",
      --   },
      -- },
      smart_move = {
        -- noice tries to move out of the way of existing floating windows.
        enabled = true, -- you can disable this behaviour here
        -- add any filetypes here, that shouldn't trigger smart move.
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
      },
      ---@type NoicePresets
      presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = true,          -- use a classic bottom cmdline for search
        command_palette = false,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = false,        -- add a border to hover docs and signature help
      },
      throttle = 1000 / 30,            -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
      ---@type NoiceConfigViews
      views = {},
      ---@type NoiceRouteConfig[]
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "search_count",
          },
          opts = { skip = true },
        },
      },           --- @see section on routes
      ---@type table<string, NoiceFilter>
      status = {}, --- @see section on statusline components
      ---@type NoiceFormatOptions
      format = {}, --- @see section on formatting
    },
  },
}
