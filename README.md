# Assignment 2 - Shell scripting project

This repository contains several shell scripts designed for system setup and user configuration on an Arch Linux system. These scripts automate tasks such as installing packages, creating symbolic links, and setting up a new user with specified attributes. Below is a description of each script, its functionality, and how to use it.

## Scripts Overview for Project 1

### 1. `install_packages`
This script installs a set of predefined packages using `pacman`.

- **Packages Installed:** `kakoune` and `tmux`.
- **How it Works:** The script checks if each package is already installed. If not, it installs the package with `pacman -S --noconfirm`.

### 2. `symlinks`
This script sets up directories if they are not already set up and symbolic links for configuration files.

- **Directories Created:** `~/.config/kak`, `~/.config/tmux`, and `~/bin`.
- **Symbolic Links Created:** Links are created from a specified source to each of the directories and configuration files:
  - `~/.config/kak`
  - `~/.config/tmux/tmux.conf`
  - `~/.bashrc`
  - `~/bin`


### 3. `setup`
A main script to coordinate both package installation and symbolic link creation. This script grants executable permissions to `install_packages` and `symlinks`, then offers options to run either or both scripts. It also must be run with sudo otherwise it will show an error

#### Usage
You can run the script with the following options:
- `-i`: Install packages only
- `-s`: Create symbolic links only
- `-a`: Perform both actions



```bash
sudo ./setup -a
```

## Script Overview for Project 2

### 1. `usersetup`
This script creates a new user with specified properties such as username, shell, home directory, and additional groups. 

- **Functions**
  - **Root User Check**: makes sure the script is run as the root user
  - **Command-line options**: Parses options using `getopts` to set the username, home directory, shell and additional groups along with an invalid option that shows how to properly run the command
  - **Directory setup**: Creates a home directory for the user that defaults to `/home/username` along with copying files from `/etc/skel` 
  - **Group creation**: Finds an unused group ID and assigns it as the primary group of the new user. If additional groups are specified the script will check for their existance, create them if necessary and add the user to each group

- **Options:**
  - `-u <username>`: The username for the new user.
  - `-s <shell>`: Specify the login shell (default: `/bin/bash`).
  - `-h <home_directory>`: Home directory for the user (default: `/home/<username>`).
  - `-g <groups>`: Additional groups (comma-separated) to add the user to.

#### Usage
Run the script with `sudo`, passing the required options to set up a new user as needed. For example:
```bash
sudo ./usersetup -u newuser -s /bin/zsh -h /home/newuser -g group1,group2
```