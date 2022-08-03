#!/usr/bin/python3

from types import Dict
# Script that will replace dotfiles specified in this directory with symlinks 
# to the corresponding file in this git repo.

here_to_sym: Dict[str, str] = {
        "./.zshrc" : "~/.zshrc", 
        "./nvim" : "~/.config/nvim"
}

print('WARNING: This script will delete the following files: ')
print(path for path in here_to_sym.values())

