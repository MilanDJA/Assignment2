#!/bin/bash

# This command checks if the script is being run as the root user.
# If not, it prompts the user to use 'sudo' and exits with a status code of 1.

if [[ "$EUID" -ne 0 ]]; then
    echo "You must run this script as the root user!"
    exit 1
fi

# Define paths to the scripts for installing packages and creating symbolic links.
# Both scripts are assumed to be located in the same directory as this main script.
PACKAGES="./install_packages"
SYMLINKS="./symlinks"

# Update permissions to make both scripts executable.
chmod +x "$PACKAGES"
chmod +x "$SYMLINKS"

# Function to install packages by running the 'install_packages' script.
install_packages() {
    echo "Starting installation..." 
    "$PACKAGES"

    # Check the exit code of the install_packages script.
    # If it's 0, the installation was successful.
    if [[ $? -eq 0 ]]; then
        echo "Packages installed successfully."
    # Otherwise, print an error message and exit with a status code of 1.
    else
        echo "Installing packages failed." >&2
        exit 1
    fi	    
}

# Function to create symbolic links by running the 'symlinks' script.
symlinks() {
    echo "Creating symbolic links..." 
    "$SYMLINKS"

    # Check the exit code of the symlinks script.
    # If it's 0, the symbolic links were created successfully.
    if [[ $? -eq 0 ]]; then
        echo "Symbolic links created successfully."
    # Otherwise, print an error message and exit with a status code of 1.
    else
        echo "Creating symbolic links failed." >&2
        exit 1
    fi
}

# Parse command-line options using getopts.
# The user can choose to:
#   - install packages only (-i)
#   - create symbolic links only (-s)
#   - perform both actions (-a)
# If an invalid option is provided, a usage message is displayed.

while getopts "isa" opt; do
    case "${opt}" in
        # Option -i: calls install_packages function to install packages.
        i)
            install_packages
            ;;
        # Option -s: calls symlinks function to create symbolic links.
        s)
            symlinks
            ;;
        # Option -a: calls both functions to install packages and create symbolic links.
        a)
            install_packages
            symlinks
            ;;
        # Invalid option: displays usage information.
        *)
            echo "Usage: $0 [-i] [-s] [-a]"
            echo "-i: Install packages"
            echo "-s: Create symbolic links"
            echo "-a: Install packages and create symbolic links"
            exit 1
            ;;
    esac
done

# If no options were provided, display usage information and exit.
if [[ $OPTIND -eq 1 ]]; then
    echo "Usage: $0 [-i] [-s] [-a]"
    echo "-i: Install packages"
    echo "-s: Create symbolic links"
    echo "-a: Install packages and create symbolic links"
    exit 1
fi

echo "Script executed successfully."