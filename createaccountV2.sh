#!/bin/bash
# Student Number: S4228356
# Student Full Name: Jed Ernest John Beard
#
# ================= CODE INSPECTION =================
# Inspected by:   Jed Beard
# Date inspected: 28/10/2026
# Total number of errors found: 4
#
# Error 1
#   Category:    Syntax error
#   Description: "User@dd" is not a valid command. Linux commands are case-sensitive
#                and "@" is not part of the command name, so the shell shows
#                "command not found" and no user account is created.
#   Solution:    Replace "User@dd" with the correct command "useradd".
#
# Error 2
#   Category:    Syntax error
#   Description: The shell path "/bin/bash" is given without its option flag, so
#                useradd treats it as the username argument and fails.
#   Solution:    Add the -s option before the shell (-s /bin/bash) and -m to
#                create a home directory: useradd -m -s /bin/bash "$user"
#
# Error 3
#   Category:    Logic error
#   Description: "passwd $pwrd" passes the password as if it were a username, so
#                passwd tries to change the password of a user that does not exist.
#   Solution:    Set the password for the new user with chpasswd:
#                echo "$user:$pwrd" | chpasswd
#
# Error 4
#   Category:    Logic error
#   Description: The script never asks for a group or assigns the user to one, so
#                user accounts are not placed into groups as required.
#   Solution:    Prompt for a group name, create the group with groupadd if it does
#                not exist, and add the user to it with useradd -G.
#
# Improvements also made: root privilege check, password hidden while typing (-s),
# variables quoted, check for an existing user, and output to confirm the result.
# ===================================================

# Creating users and groups needs root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo: sudo ./createaccountV2.sh"
    exit 1
fi

read -p "Enter Username: " user
read -s -p "Enter Password: " pwrd
echo
read -p "Enter Group (e.g. students or teachers): " group

# Stop if the user account already exists
if id "$user" &>/dev/null; then
    echo "User $user already exists."
    exit 1
fi

# Create the group if it does not already exist
if ! getent group "$group" > /dev/null; then
    groupadd "$group"
    echo "Group $group created."
fi

# Create the user with a home directory, bash shell, and assign to the group
useradd -m -s /bin/bash -G "$group" "$user"

# Set the user's password
echo "$user:$pwrd" | chpasswd

echo "User $user has been created and added to the $group group."
id "$user"
