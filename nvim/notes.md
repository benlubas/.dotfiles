
# How to Neovim 

There's a lot to remember, early on if you take a break it's easy to forget about something

## TODO

- Harpoon is slow with branch specific marks
  - I kinda want to write my own plugin (possibly in rust) to fix it.
- Setup Luasnip 
- Commit the default spelling binds to memory to use those and free up `<leader>s` as a prefix 

## Feature Rundown & Commands

- LSP stuff
  - Read diagnostic info `<leader>do`
  - `gd` go to definition
  - `gr` go to references
  - `H` for lsp info on symbol under the cursor
  - others in lsp.lua

- 'surround' 
  - Command: `ysiw'` -> to surround a word with ''
    - Part: `ys` -> add surroundings
    - Part: `iw` ->  to the inner word
    - Part: `'` -> those surroundings should be ''
  - Command: `ds(` -> delete the surrounding ()
  - Command: `cs"'` -> change the surrounding " to ' 
    - Ex: "hello" => 'hello'
  - Command: `cst<p>` -> change the surrounding tag to <p>
    - Ex: <div>text</div> => <p>text</p>
    - you can also do ysiw<tag>

- Which Key 
  - The pop up at the bottom that will show you what key options will result in an action 
  - `:WhichKey` to see all the mappings

- Gitsigns
  - `<leader>gb` blame line
  - `<leader>ga` git add hunk
  - `<leader>gu` git un-stage hunk
  - `<leader>gr` git reset hunk
  - `<leader>gd` diff hunk
  - `<leader>gD` diff file (not that great currently)

- Telescope
  - `<leader>fd` will fuzzy find git files in a git project, or all files in a non git project.
  - `<leader>fa` grep all text in entire project, follows gitignore
  - `<leader>h` search help doc
  - `<leader>wh` search help with word under cursor
  - `<`

- Spelling
  - TODO: working to remove these and just use the defaults
  - `<leader>ss` spell suggest
  - `<leader>sa` spell add
  - `<leader>sr` spell remove 

- I have auto-completion too, that's nice
  - default `<C-n>` and `<C-p>` for next and previous

- Clipboard interaction:
  - `<leader>y` to yank to the system clipboard
  - `<leader>p` or `<leader>P` to paste from the system clipboard
  - `<leader>c` to open telescope with un-named register history


## Treesitter 

This plugin is essentially a syntax parser(?) I think. It allows for a better 
understanding of tokens to get better syntax highlighting. So, in theory, this python 
block should be highlighted...
But also the indentation highlighting I think uses Treesitter.
```python 
for i in range(10): 
    if i % 2 == 0:
        print(f'number {i} is even')
        # cursor here, the lines will be highlighted. 
```

Treesitter relies on grammar for each language. We can install those with 
`:TSInstall <language>` so whenever you encounter a new language you have to install its 
grammar with that command. 

To see languages that you have installed (and options for langs to install), run 
`:TSInstallInfo` 

There are modules as well [GitHub page](https://github.com/nvim-treesitter/nvim-treesitter)

