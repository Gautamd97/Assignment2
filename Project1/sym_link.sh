#!/bin/bash

# to confirm if the script is being run as Root, and exits if its not.
if [ "$UID" -ne 0 ]; then

  echo "This script must be run as root"
  exit 1
fi

#Symbolic links
#For each symbolic link, we add the path to the target and then the name of the link we need to create. The link contains the path to the target. It is basically a shortcut

# for config file.
ln -s /home/$USER/2420-as2-starting-files/config ~/.config
# for bashrc
ln -s /home/$USER/2420-as2-starting-files/home/bashrc ~/.bashrc
# for bin
ln -s /home/$USER/2420-as2-starting-files/bin ~/.bin
