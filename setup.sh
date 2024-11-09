#!/bin/bash

if [ "$UID" -ne 0 ]; then

  echo "This script must be run as root"
  exit 1
fi

while getopts "icb" opt; do
  case $opt in 
    i)
      bash install_packages.sh
      echo"Installed packages"
    ;;

    c)
      bash sym_link.sh
      echo"Created Symbolic Links"
    ;;

    b)
      ./install_packages.sh
      ./sym_link.sh
      echo"Setup is complete"
    ;;

    *)
      echo "Invalid option"
      exit 1
    ;;
  esac
done
