#!/usr/bin/python3

from typing import Dict
import os

# Script that will replace dotfiles specified in this directory with symlinks 
# to the corresponding file in this git repo.

here_to_sym: Dict[str, str] = {
        "./nvim/" : "~/.config/nvim/", 
        # "./Brewfile" : "~/.config/Brewfile/Brewfile", 
        "./.bashrc" : "~/.bashrc", 
        "./.gitconfig" : "~/.gitconfig",
        "./.zshrc" : "~/.zshrc", 
}

# Print a warning
print('WARNING: This script will delete the following files: ')
[print(path) for path in here_to_sym.values()]

# ask the user to confirm 
answer = input('Are you sure you want to continue? [y/n]\n')

if answer.lower() == 'y' or answer.lower() == 'yes':
    print('you said yes')
    # continue on:
else: # if they type anything that isn't y or yes, then cancel
    print('exiting early. nothing will be changed.')
    exit(0)

# for each file in the list, find it, remove it, and then add the symlink. 

for key in here_to_sym:
    repo_path = key
    og_path = here_to_sym[key]
    if og_path[-1] == '/' and os.path.exists(og_path):
        print(f'removing directory: {og_path}')
        os.rmdir(og_path)
    elif os.path.exists(og_path):
        print(f'removing: {og_path}')
        os.remove(og_path)

    print(f'linking {repo_path} to {og_path}')
    os.symlink(repo_path, og_path, target_is_directory=og_path[-1] == '/')

print("Done! Make sure to check that all the symlinks actually exist.")
print("You should also restart your terminal")
