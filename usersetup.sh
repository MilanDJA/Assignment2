#!/bin/bash

# Check if the script is run as the root user (EUID of 0 is root)
if [[ "$EUID" -ne 0 ]]; then
    echo "Please run this script as the root user."
    exit 1
fi

# Function to display usage instructions for command-line options
show_usage() {
    echo "Usage: $0 -u username -p password -s shell -h home_directory -g groups"
    echo " -u username: Set the username for the new user"
    echo " -s shell: Specify the login shell for the new user"
    echo " -h home_directory: Set home directory for the new user"
    echo " -g groups: Add the user to additional groups (comma-separated)"
    exit 1
}

# Initialize variables for command-line options
user_name=""
login_shell="/bin/bash"
user_home_dir=""
additional_groups=""

# Parse command-line options with getopts
while getopts ":u:s:h:g:" option; do
    case "${option}" in
        # Handle username option
        u)
            user_name=${OPTARG}
            ;;
        # Handle shell option
        s)
            login_shell=${OPTARG}
            ;;
        # Handle home directory option
        h)
            user_home_dir=${OPTARG}
            ;;
        # Handle groups option
        g)
            additional_groups=${OPTARG}
            ;;
        # Invalid option handling
        *)
            echo "Invalid option: ${OPTARG}"
            show_usage
            ;;
    esac
done

# Ensure that username and password are provided
if [[ -z $user_name ]]; then
    show_usage
fi


# Set a default home directory if none is provided
if [[ -z $user_home_dir ]]; then
    user_home_dir="/home/$user_name"
fi

# Create the home directory
if [[ ! -d $user_home_dir ]]; then
    echo "Creating home directory at $user_home_dir"
    mkdir -p "$user_home_dir"
    # Copy default skeleton files to the new home directory
    cp -r /etc/skel/. "$user_home_dir"
fi

# Prompt for the shell if it's empty and set a default if not provided
if [[ -z $login_shell ]]; then
    read -p "Enter the login shell for the new user: " login_shell
    login_shell="${login_shell:-/bin/bash}"
fi

# Create the user's primary group by finding an unused group ID
group_id=$(($(tail -n 1 /etc/group | cut -d: -f3) + 1))
echo "$user_name:x:$group_id:" | tee -a /etc/group

# Assign a new user ID and set primary group ID equal to user ID
user_id=$(($(tail -n 1 /etc/passwd | cut -d: -f3) + 1))
group_id=$user_id

# Append user information to the /etc/passwd file
echo "$user_name:x:$user_id:$group_id:$user_name:$user_home_dir:$login_shell" | tee -a /etc/passwd

# If additional groups are specified, add the user to those groups
if [[ -n $additional_groups ]]; then
    # Read comma-separated groups into an array using IFS
    IFS="," read -ra group_array <<< "$additional_groups"
    for group in "${group_array[@]}"; do
        # Check if each group exists in /etc/group using grep
        if grep -q "^$group:" /etc/group; then
            # If the group exists, add the user to it
            sed -i "/^$group:/ s/$/,$user_name/" /etc/group
        else
            # If the group doesn't exist, create it with a new GID and add the user
            new_group_id=$(( $(tail -n 1 /etc/group | cut -d: -f3) + 1 ))
            echo "$group:x:$new_group_id:$user_name" | tee -a /etc/group
        fi
    done
fi

# Notify that the user has been created successfully
echo "User $user_name has been created successfully."

# Creating password for the new user
passwd $username
echo "Password created successfully"