#!/bin/bash

# This conditional statement checks for the existence of ~/.config/kak and ~/bin directories.
# If these directories are present, an error message is displayed, and the script exits with a status code of 1 to indicate an error.
# If the directories do not exist, the else block executes, creating the necessary directories.
# Upon successful creation, a message is printed to inform the user.

if [[ -d ~/.config/kak && -d ~/bin/tmux ]]; then
  echo "The directory already exists."
else
  mkdir -p ~/.config/kak
  mkdir -p ~/.config/tmux
  mkdir -p ~/bin
  echo "Directories created successfully."
fi

# The if statement verifies the existence of specific symbolic links.
# If these symbolic links are already present, the user is informed with a message.
# If the links do not exist, the else block creates them.
# The user will receive a message confirming the successful creation of symbolic links if everything proceeds as expected.

if [[ -L ~/.config/kak && -L ~/.config/tmux && -L ~/.bashrc && -L ~/bin ]]; then
    echo "The symbolic links already exist."
else
    ln -s ~/home/arch/Assignment2/config/kak ~/.config/kak
    ln -s ~/home/arch/Assignment2/config/tmux/tmux.conf ~/.config/tmux
    ln -s ~/home/.bashrc ~/.bashrc
    ln -s ~/home/arch/Assignment2/bin ~/bin
    echo "Symbolic links created with no problems."
fi