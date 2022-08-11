
# How to Neovim 

While it is really nice to have this fast text editor, there are a lot of settings 
and there is a lot of configuration. I'm doing my best to comment everything that I 
can in the config files. There are some things that don't really have a spot in configs 
that I still need to remember. I'm going to put them here. 

## TODO

- Configure the snippets plugin
- setup harpoon (with tmux as well)
- Play around with lualine a little so that it's more my speed
- figure out why the telescope border isn't showing properly 
- perma set the theme to not use italics in comments 
- fix the pasting issue with comments 
- fix pasting issue with spacing 
- maybe bring back highlight under the cursor (there has to be a plugin that 
  does it without highlighting comment (even if not, I don't use italic comments 
  anymore so it's not that big a deal. 

## Features 

A list of commands/features that my plugins are adding to vim. Hopefully this list 
becomes irrelevant very quickly as I commit these things to memory. 

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
  - move over the files, and press `s` to stage them
  - Press `p` to pull changes
  - Press `c` to start a commit, there are commit options, press `c` again to just skip those and move forward. 
  - Press `P` to push 
  - Press `b` for branch options. Honestly, might just want to use the commands for this one. It's a little weird. 
  - Press `<C-r>` to refresh the GUI (if you run some git commands in another tmux window for example)

- Telescope
  - I really need to do some more configuration for this one. 
  - `<leader>ff` will fuzzy find files. 
    - Currently, this doesn't ignore .files or the things in .gitignore.
    - I would like this to ignore the gitignore files without ignoring _all_ dot files.
  - There are other keybinds that I'll add later


## Tree Sitter 
This plugin is essentially a syntax parser(?) I think. It allows for a better 
understanding of tokens to get better syntax highlighting. It also allows for
the highlighting of tab lines the line under the `if` keyword is highlighted while the 
cursor is in the if block. 
```python 
for i in range(10): 
  if i % 2 == 0:
    print(f'number {i} is even')
    # cursor here, the lines will be highlighted. 
```

Treesitter relies on grammar for each language. We can install those with `:TSInstall <language>`
so whenever you encounter a new language you have to install it's grammar with that command. 

To see languages that you have installed (and options for langs to install), run `:TSInstallInfo` 

There are modules as well, you can just read about those on the [github page](https://github.com/nvim-treesitter/nvim-treesitter)

