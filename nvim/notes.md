
# How to Neovim

This file is mainly a running list of TODO items that I've completed or need to work on.

If anyone wants to learn about my setup, I'd suggest just reading through the
`lua/plugins` directory, and maybe `lua/benlubas/remap.lua` and `lua/benlubas/set.lua`. Most
everything else in the `benlubas` directory is referenced at some point in those other files and you 
can see how they're used.

## TODO

- [ ] add virtual text to nvim-treesitter-context
- [ ] Commit the default spelling binds to memory to use those and free up `<leader>s` as a prefix
    - holding out until I have a use for `<leader>s`
- [x] Tmux-sessionizer telescope picker
- [x] nvim-cmp alt+n bindings and numbering items
    - DONE: forked to add this, maintainer won't except the PR, so I'm just merging from upstream
- [x] Harpoon is slow on macOS with branch specific marks
    - DONE: forked version that caches the branch key. Inactive, so I can't get this merged to main
- [x] Neotest initial load time in a large repos
    - DONE: this was a feature called discovery that looks for all the test files in the entire repo
- [x] Setup Luasnip
