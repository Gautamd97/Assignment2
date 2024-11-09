#!/bin/bash

#This makes sure that the script is run as Root, and exits if it is not run as Root

if [ "$UID" -ne 0 ]; then

  echo "This script must be run as root"
  exit 1
fi

# getopts allows us to handle different arguments that the user types in.
#The user will have to enter both -u and -p arguments for this to work, if one is missing, there will be an error
#This allows us to have a standard user input and create users consistently
while getopts ":u:p:" opt; do
  case "${opt}" in
    u) 
      username="$OPTARG"
      ;;
      # this is the option for username
      # this assigns the argument entered by user to the variable
    p)
      password="$OPTARG"
      ;;
      # this is the option for password
      # this assigns the argument entered by user to the variable
    :) 
      echo "Option -$OPTARG requires an argument"
      exit 1
      ;;
      # This is for when there are missing arguments for options
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
      # This is for when there are invalid options entered by users
  esac
done

# This checks if both arguments are provided, if they are not then it echoes the error message
if [[ -z "$username" || -z "$password" ]]; then
  echo "Error: both -u (username) and -p (password) must be specified"
  exit 1
fi

#This checks if the username already exists, and if it does it exits. It notifies the user with the echo message if the username already exists
if id "$username" &>/dev/null; then
  echo "Error: User $username already exists." 
  exit 1
fi

# The home directory path for the new user
home_dir="/home/$username"
mkdir -p "$home_dir" # creates the home directory, the -p avoids any errors in case the directory already exists

#This generates a UID and GID for the user and makes sure it doesnt match one in the system already
uid=$(awk -F: '{if ($3 > max) max = $3} END {print max+1}' /etc/passwd)
gid=$(awk -F: '{if ($3 > max) max = $3} END {print max+1}' /etc/group)
#awk finds the maximum UID and GID and assigns it to the max variable, then adds 1 for the new GID and UID

#This adds the user to the /etc/passwd with the GID and UID generated earlier
echo "$username:x:$uid:$gid:$username,,,:$home_dir:/bin/bash" >> /etc/passwd

#This creates a group and adds the group to /etc/group
echo "$username:x:$gid:" >> /etc/group


# setting the password for user
echo "$username:$password" | chpasswd

#grant sudo privelages to new user
# The ALL=(ALL) ALL makes it so that the user has full sudo privelages
echo "$username ALL=(ALL) ALL" >> /etc/sudoers

#This step is to add ownership of the new directory to the new user

#sets ownership to of the home directory to the new user.
chown -R "$username:$username" "$home_dir"

echo "User $username has been created with sudo privelages, password, and a group"