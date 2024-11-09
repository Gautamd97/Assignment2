#!/bin/bash

# Check if the script is being run as Root, and exit if it is not being run as Root
if [ "$UID" -ne 0 ]; then

  echo "This script must be run as root"
  exit 1
fi

#The getopts function allows users to run the scripts separately or together.
while getopts "icb" opt; do
  case $opt in 
    # -i will run the install_packages.sh script
    i)
      bash install_packages.sh
      echo"Installed packages"
    ;;

    c)
      # -c will run the sym_link.sh script
      bash sym_link.sh
      echo"Created Symbolic Links"
    ;;

    b)
      # -b runs both scripts 
      ./install_packages.sh
      ./sym_link.sh
      echo"Setup is complete"
    ;;

    *)
      # If the user enteres any other option, it will return "Invalid Option" and exit
      echo "Invalid option"
      exit 1
    ;;
  esac
done
