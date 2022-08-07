
# How to Neovim 

While it is really nice to have this fast text editor, there are a lot of settings 
and there is a lot of configuration. I'm doing my best to comment everything that I 
can in the config files. There are some things that don't really have a spot in configs 
that I still need to remember. I'm going to put them here. 

## Tree Sitter 
This pluggin is essentially a syntax parser(?) I think. It allows for a better 
understanding of tokens to get better syntax highlighting. it also allows for the 
the highlighting of tablines the line under the `if` keyword is highlighted while the 
coursor is in the if block. 
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

