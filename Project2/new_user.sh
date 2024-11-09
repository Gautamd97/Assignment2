#!/bin/bash

#This makes sure that the script is run as Root, and exits if it is not run as Root

if [ "$UID" -ne 0 ]; then

  echo "This script must be run as root"
  exit 1
fi

#The user will have to enter both -u and -p arguments for it to work, if one is missing, there will be an error
while getopts ":u:p:" opt; do
  case "${opt}" in
    u)
      username="$OPTARG"
      ;;
    p)
      password="$OPTARG"
      ;;
    :)
      echo "Option -$OPTARG requires an argument"
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
  esac
done

# This checks if both arguments are provided, if they are not then it echoes the error message
if [[ -z "$username" || -z "$password" ]]; then
  echo "Error: both -u (username) and -p (password) must be specified"
  exit 1
fi

#This checks if the username already exists, and if it does it exits.
if id "$username" &>/dev/null; then
  echo "Error: User $username already exists."
  exit 1
fi


home_dir="/home/$username"
mkdir -p "$home_dir"
echo "Created home directory: $home_dir"

#This generates a UID and GID for the user and makes sure it doesnt match one in the system already
uid=$(awk -F: '{if ($3 > max) max = $3} END {print max+1}' /etc/passwd)
gid=$(awk -F: '{if ($3 > max) max = $3} END {print max+1}' /etc/group)

#This adds the user to the /etc/passwd
echo "$username:x:$uid:$gid:$username,,,:$home_dir:/bin/bash" >> /etc/passwd
echo "Added $username to /etc/passwd"

#This adds the group to /etc/group
echo "$username:x:$gid:" >> /etc/group
echo "Created group and added $username to /etc/group"

# setting the password for user
# This
echo "$username:$password" | chpasswd

#grant sudo privelages to new user
echo "$username ALL=(ALL) ALL" >> /etc/sudoers

#This step is to add ownership of the new directory to the new user

chown -R "$username:$username" "$home_dir"
echo "Configured ownership for $home_dir"

echo "User $username has been created with sudo privelages, password, and a group"
