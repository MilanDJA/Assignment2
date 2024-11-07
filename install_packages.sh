#!/bin/bash
# This line specifies that the script should be run using the Bash shell.

PACKAGES=("kakoune" "tmux")
# The packages are in an array called PACKAGES


# Loop through each package in the PACKAGES array.
for pkg in "${PACKAGES[@]}"; do
  # "${PACKAGES[@]}" expands to each element in the PACKAGES array.
  # Each element is assigned to the variable pkg one by one.

  if ! pacman -Q "$pkg"; then
    # pacman -Q is for if the package isn't installed, it will return a non-zero value in that case
    
    echo "Installing $pkg..."
    # Informs the user that the package installation is starting.

    pacman -S --noconfirm "$pkg"
    # Installs the package using pacman.
    # -S is the sync/install command for pacman.
    # --noconfirm automatically answers "yes" to all prompts.
  else
    echo "$pkg is already installed."
    # If the package is found, says it's been installed already and has exit code 1
	exit 1
done