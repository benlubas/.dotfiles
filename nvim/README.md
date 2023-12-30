# Ben-vim

Haha, get it ... get it?

---

Welcome to the neovim setup. The `main` branch is for me, the `stable` branch is for people that
want to try this out, but this isn't intended for other people to use as is, it's more something
that you can look through and take ideas from.

This is ever improving. Here are the current TODO items:
- [ ] Hydra floating window border customization
- [ ] harpoon files from Oil.nvim buffer
- [ ] Nvim surround link surround

## Theme and Visual Elements

No borders on floating windows unless they need a title, Molten floats are the exception

- bluz71/vim-moonfly-colors but I've customized a lot of the plugin highlight groups
- MunifTanjim/nougat.nvim status line fixed to the bottom (no tabline)

## Plugins

Plugins organized by the workflow that I use them for

<details>
  <summary>Base - basic often small but powerful plugins</summary>

- kylechui/nvim-surround
- benlubas/auto-save.nvim
- mbbill/undotree
- LunarVim/bigfile.nvim (with custom config to disable neoscroll)
- max397574/better-escape.nvim
- echasnovski/mini.trailspace
</details>

<details>
  <summary>Auto Completion and Snippets</summary>

- benlubas/nvim-cmp
  - I use my own fork of nvim-cmp that adds two features:
    - Select-nth item; used for mapping `<A-n>` to select the `nth` item in the completion menu.
    - Numbering the options; aid for the `<A-n>` keybinds
  - There's a branch called `up_to_date` that I sync with upstream every few months if you'd like to
    use this feature as well, and [here's](https://github.com/hrsh7th/nvim-cmp/pull/1491) the PR to
    add this functionality to cmp.
- L3MON4D3/LuaSnip (custom snippets in [lua/snippets/](./lua/snippets/))
- windwp/nvim-autopairs

Completion sources:

- hrsh7th/cmp-buffer
- hrsh7th/cmp-nvim-lsp
- hrsh7th/cmp-path
- petertriho/cmp-git

</details>

<details>
  <summary>Jupyter Notebook Workflow</summary>
 
I wrote a [Reddit post](https://www.reddit.com/r/neovim/comments/17ynpg2/how_to_edit_jupyter_notebooks_in_neovim_with_very/)
about this setup, the short of it is: these plugin allow me to interact with `.ipynb` files seamlessly™.

- goerz/jupytext.vim
- benlubas/molten-nvim
- 3rd/image.nvim
- quarto-dev/quarto-nvim
- jmbuhr/otter.nvim

</details>

<details>
  <summary>Telescope</summary>

All of my telescope pickers make use of [telescope.nvim#2572](https://github.com/nvim-telescope/telescope.nvim/pull/2572),
opting for custom layouts using MunifTanjim/nui.nvim instead of using builtin telescope themes.
Layouts are located at [/lua/benlubas/telescope/layouts](./lua/benlubas/telescope/layouts).

- default: the default layout that's used for all of my file pickers
- ivy: a custom ivy-like layout that sits at the bottom of the screen. Used for tmux-sessionizer
- spelling: a tiny little window used for spelling suggestions, positioned to match the start of the
  word so that spelling suggestions line up as if you were seeing completion menu suggestions

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

- benlubas/harpoon

Integrations:
- custom picker in telescope for importing marks from other branches
- custom telescope action to mark files
- custom keybind in oil to mark files
</details>

## Other cool stuff

<details>
  <summary>View `:mes` in a buffer</summary>

You can view the output of `:mes` in a floating buffer with `M` or `:M`. The function that does this
is exposed as `:lua B()` and you can use it like `:lua B("highlight")` to see the output of the
highlight command in a buffer (doesn't support highlighting though, ironically)

</details>

<details>
  <summary>Search Count</summary>

I have an in house solution for the search count problem. By default, `/` to search will only show
`[n/99]` items. This is a royal pain for when I just want to count the number of times something
shows up in a file, so I have written [this](./lua/benlubas/search_count.lua). I put the search
count in my status line when there's an active search.

</details>
