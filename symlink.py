#!/usr/bin/python3

from typing import Dict
import os

"""
Script that will replace dotfiles listed below repo with symlinks 
to the corresponding file in this git repo.
"""

HOME = os.path.expanduser('~') + "/"
here_to_sym: Dict[str, str] = {
    "nvim/" : ".config/nvim", 
#    "Brewfile" : ".config/Brewfile/Brewfile", 
    ".bashrc" : ".bashrc", 
    ".gitconfig" : ".gitconfig",
    ".zshrc" : ".zshrc", 
    "tmux.conf" : ".config/tmux/tmux.conf",
    "alacritty.yml" : ".config/alacritty.yml",
}

# Print a warning
print('WARNING: This script will delete the following files: ')
[print(path) for path in here_to_sym.values()]

# ask the user to confirm 
answer = input('Are you sure you want to continue? [y/n]\n')

if answer.lower() == 'y' or answer.lower() == 'yes':
    print('you said yes')
    # continues on
else: # if they type anything that isn't y or yes, then cancel
    print('exiting early. Nothing will be changed.')
    exit(0)

# for each file in the list, find it, remove it, and then add the symlink. 

for key in here_to_sym:
    repo_path = ""
    if key[-1] == '/': 
        repo_path = key[:-1]
    else: 
        repo_path = key
    og_path = here_to_sym[key]
    if og_path[-1] == '/' and os.path.exists(HOME + og_path):
        print(f'removing directory: {HOME}{og_path}')
        os.rmdir(f'{HOME}{og_path}')
    elif os.path.exists(HOME + og_path):
        print(f'removing: {HOME}{og_path}')
        os.remove(f'{HOME}{og_path}')

    print(f'linking {repo_path} to {og_path}')
    os.symlink(HOME + "github/.dotfiles/" + repo_path, HOME + og_path, target_is_directory=og_path[-1] == '/')

print("Done! Make sure to check that all the symlinks actually exist.")
print("You should also restart your terminal")
