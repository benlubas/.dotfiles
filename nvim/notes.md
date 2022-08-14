
# How to Neovim 

While it is really nice to have this fast text editor, there are a lot of settings 
and there is a lot of configuration. I'm doing my best to comment everything that I 
can in the config files. There are some things that don't really have a spot in configs 
that I still need to remember. I'm going to put them here. 

## TODO

- Configure the snippets plugin
- setup harpoon (with tmux as well)
    - I really don't have a problem with this right now. Using `<leader>f` and just typing the file 
    name has worked for me so far. I'm sure in a larger project, it would be better. But right now
    it's not a problem that I think I have.
- Play around with lualine a little so that it's more my speed
- figure out why the telescope border isn't showing properly 
    - This was a Windows Terminal problem, I'm using Alacritty now, and that's fixed
- fix the pasting issue with comments 
- fix pasting issue with spacing  
    - There's a problem with pasting inserting newlines after each line, I think that it's 
    something to do with windows and the terminal that I'm using, I just have @q setup 
    to remove the next line, there are probably better find replace solutions
    - anyway, this was originally about tab formatting getting messed up, I haven't solved
    that that issue yet.

## Annoyances

- For some reason glow doesn't like when the tab size is two spaces? It messes up the way
lists are rendered. So the following would not render properly:

```md 
1. item
  - sub-point 
2. second item 
```

- The numbered list would be rendered both as number one and the sub-point would not be 
indented properly.


## Features 

A list of commands/features that my plugins are adding to vim. Hopefully this list 
becomes irrelevant very quickly as I commit these things to memory. 

- LSP stuff
    - Read diagnostic info `<leader>do`
    - go definition `gd`
    - others in lsp.lua and remap.lua

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
        - Note: this one repeats in a weird way, it requires that you retype the tag (or you can type a new one)

- Which Key 
    - The pop up at the bottom that will show you what key options will result in an action 

- NeoGit 
    - Press `<leader>gi` to pull up the window.
    - Move over the files, and press `s` to stage them
    - Press `p` to pull changes
    - Press `c` to start a commit, there are commit options, press `c` again to just skip those and 
    move forward. 
    - Press `P` to push 
    - Press `b` for branch options. Honestly, might just want to use the commands for this one. It's a little weird. 
    - Press `<C-r>` to refresh the GUI (if you run some git commands in another tmux window for example)

- Telescope
    - I really need to do some more configuration for this one. 
    - `<leader>ff` will fuzzy find files. 
        - Currently, this doesn't ignore .files or the things in .gitignore.
        - I would like this to ignore the gitignore files without ignoring _all_ dot files.
    - There are other keybinds that I'll add later

- I have auto-completion too, that's nice

- Clipboard interaction:
    - `<leader>y<motion>` to yank to the system clipboard
    - `<leader>p` or `<leader>P` to paste from the system clipboard
    - `<leader>c` to open telescope with clipboard history in it (Seemingly only the normal one tho,
    not the system clipboard. 

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

There are modules as well, you can just read about those on the 
[GitHub page](https://github.com/nvim-treesitter/nvim-treesitter)

