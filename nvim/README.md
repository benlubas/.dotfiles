# Ben-vim

Haha, get it ... get it?

---

Welcome to my neovim setup. This isn't really intended for other people to use, it's more something
that you can look through and take ideas from. This is what it generally looks like:

## File Structure

```
├── after
│   ├── ftplugin
│   └── queries
├── ftplugin
├── lua
│   ├── benlubas
│   │   ├── telescope           # custom telescope layouts
│   │   ├── hydra               # hydras that are loaded with other plugins
│   │   ├── set.lua             # setting vim options
│   │   ├── remap.lua           # keymaps
│   │   └── ... others          # other various code
│   ├── plugins                 # lazy plugin specs
│   └── snippets                # luasnip snippets
├── data                        # I keep telescope sources here
├── templates                   # neorg templates
└── init.lua                    # entry point
```

## Plugins

Categorized somewhat arbitrarily:

<details>
  <summary>Theme and Visual Elements</summary>

No borders on floating windows unless they need a title, Molten floats are the exception

- [bluz71/vim-moonfly-colors](https://github.com/bluz71/vim-moonfly-colors)
  - I've customized a lot of plugin highlights myself
  - I also use this theme in my terminal, and tmux bar
- [MunifTanjim/nougat.nvim](https://github.com/MunifTanjim/nougat.nvim)
  - status line (fixed to the bottom) I don't use a window or tab line
- [luukvbaal/statuscol.nvim](https://github.com/luukvbaal/statuscol.nvim)
  - easy status column customization
- [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)
- [lukas-reineke/headlines.nvim](https://github.com/lukas-reineke/headlines.nvim)
- [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [benlubas/neoscroll.nvim](https://github.com/benlubas/neoscroll.nvim)
  - my own fork that adds time scaling and an on/off switch that I use in bigfile
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

I have a [noice](https://github.com/folke/noice.nvim) config in here too, but I don't currently use
it. It's caused too many problems and I'm not able to configure it quite the way that I want to, but
I'm definitely keeping my eye on it.

</details>

<details>
  <summary>Base - simple but powerful plugins</summary>

- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)
  - Custom surround for markdown links
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [benlubas/auto-save.nvim](https://github.com/benlubas/auto-save.nvim)
- [mbbill/undotree](https://github.com/mbbill/undotree)
- [LunarVim/bigfile.nvim](https://github.com/LunarVim/bigfile.nvim)
  - with custom config to disable neoscroll
- [max397574/better-escape.nvim](https://github.com/max397574/better-escape.nvim)
- [benlubas/wrapping-paper.nvim](https://github.com/benlubas/wrapping-paper.nvim)
- [ruifm/gitlinker.nvim](https://github.com/ruifm/gitlinker.nvim)
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
</details>

<details>
  <summary>Auto Completion and Snippets</summary>

- [benlubas/nvim-cmp](https://github.com/benlubas/nvim-cmp)
  - I use my own fork of nvim-cmp that adds two features:
    - Select-nth item; used for mapping `<A-n>` to select the `nth` item in the completion menu.
    - Numbering the options; aid for the `<A-n>` keybinds
  - There's a branch called `up_to_date` that I sync with upstream every few months if you'd like to
    use this feature as well, and [here's](https://github.com/hrsh7th/nvim-cmp/pull/1491) the PR to
    add this functionality to cmp.
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
  - custom snippets in [lua/snippets/](./lua/snippets/), there are a lot of react test library
    snippets and some other random ones
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)

Completion sources:

- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)
- [petertriho/cmp-git](https://github.com/petertriho/cmp-git)

</details>

<details>
  <summary>Jupyter Notebook Workflow</summary>

- [GCBallesteros/jupytext.nvim](https://github.com/GCBallesteros/jupytext.nvim)
- [benlubas/molten-nvim](https://github.com/benlubas/molten-nvim)
  - this plugin is amazing btw. go check it out
- [3rd/image.nvim](https://github.com/3rd/image.nvim)
- [quarto-dev/quarto-nvim](https://github.com/quarto-dev/quarto-nvim)
- [jmbuhr/otter.nvim](https://github.com/jmbuhr/otter.nvim)

This setup is documented in the molten-nvim
[docs](https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md) and lets me:

- open `.ipynb` files like normal, they're displayed as plaintext, outputs are loaded automatically
  and shown, including images
- run code cell by cell, and view and interact with output in editor (again including images)
- easily add new cells, delete them, move them around
- `:w` to save to `.ipynb` format with output chunks saved as well

</details>

<details>
  <summary>Telescope</summary>

All of my telescope pickers make use of
[telescope.nvim#2572](https://github.com/nvim-telescope/telescope.nvim/pull/2572), opting for custom
layouts using [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) instead of using
builtin telescope themes. Layouts are located at
[/lua/benlubas/telescope/layouts](./lua/benlubas/telescope/layouts).

- **default**: the default layout that's used for all of my file pickers
- **ivy**: a custom ivy-like layout that sits at the bottom of the screen. Used for tmux-sessionizer
- **spelling**: a tiny little window used for spelling suggestions, positioned to match the start of
  the word so that spelling suggestions line up as if you were seeing completion menu suggestions

I have mapping for all the normal ones, like project files, current buf fuzzy find, etc. I have
custom pickers (located here [/lua/benlubas/telescope/](./lua/benlubas/telescope/)) for:

- Importing Harpoon marks that were used on other branches
- Switching between workspaces with tmux and tmux-sessionizer (a bash script that's also in these
  dotfiles)

I also have a custom action that lets me harpoon a file from the telescope results page with `<c-s>`

</details>

<details>
  <summary>Harpoon</summary>

I use a fork that enables some better highlights, and git branch caching, as I use git branch
specific keys, and fetching them on an M2 Mac is slow enough to be noticeable.

- [benlubas/harpoon](https://github.com/benlubas/harpoon)

Integrations:

- [custom picker in telescope for importing marks from other branches](./lua/benlubas/telescope/harpoon.lua)
- [custom telescope action to mark files](./lua/benlubas/telescope/harpoon.lua)
- [custom keybind in oil to mark files](./lua/plugins/oil.lua)

I'll switch to harpoon 2 when it's more feature complete

</details>

<details>
  <summary>Treesitter and related</summary>

- [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  - I make heavy use of these in my notebook workflow, and just in general this plugin is awesome
- [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [Wansmer/treesj](https://github.com/Wansmer/treesj)
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
- [benlubas/nvim-treesitter-context](https://github.com/benlubas/nvim-treesitter-context)
  - Fork that hackily adds back the collapsing context nodes into one line. It doesn't have syntax
    highlighting b/c that is a lot of work, and I want to keep this as compatible as possible with
    upstream (even though it would not get accepted in it's current state)
- [chrisgrieser/nvim-various-textobjs](https://github.com/chrisgrieser/nvim-various-textobjs)
  - I use this for the `subword` text object. This is a must have

</details>

<details>
  <summary>Hydras</summary>

I have a few hydras:

- Telescope `<leader>f` just a fancy way to go my telescope binds
- Options `<leader><leader>o` easily change common options
- Windows `<C-w>` easily repeat window navigation, movement, resize actions
- Quarto Navigator `<localleader>j` quickly move around markdown notebooks and run code

</details>

<details>
  <summary>Firenvim</summary>

I have configuration for [firenvim](https://github.com/glacambre/firenvim), which makes it easier to
edit markdown for web fields. These slightly altered settings are also used for editing prs and
issues with `gh`

</details>

<details>
  <summary>IDE type stuff</summary>
  
- [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [nvim-neotest/neotest](https://github.com/nvim-neotest/neotest)

This stuff is great when I use it

Best dap configuration option:

```lua
vim.fn.sign_define("DapBreakpoint", { text = "ඞ", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
```

</details>

## Neat Custom Stuff

<details>
  <summary>View `:messages` in a buffer</summary>

You can view the output of `:messages` in a floating buffer with `M` or `:M`. The function that does this
is exposed as `:lua B()` and you can use it like `:lua B("highlight")` to see the output of the
highlight command in a buffer (doesn't support highlighting though, ironically)

</details>

<details>
  <summary>Search count</summary>

I have an in house solution for the search count problem. By default, `/` to search will only show
`[n/99]` items. This is a royal pain for when I just want to count the number of times something
shows up in a file, so I have written [this](./lua/benlubas/search_count.lua). I put the search
count in my status line when there's an active search.

</details>

<details>
  <summary>Yank to clipboard cleans leading whitespace</summary>

I can't think of the last time I've wanted to copy code to my clipboard and preserve the leading
whitespace. So I wrote a function that removes it. [code](./lua/benlubas/smart_copy.lua) and
[usage](./lua/benlubas/autocommands.lua)

</details>

<details>
  <summary>Remove duplicates from lsp go to definition</summary>

I use a custom go to definition [handler](./lua/benlubas/lsp_handlers.lua) from @ seblj which
removes results that are on the same line as each other (luals does this a lot).

</details>
