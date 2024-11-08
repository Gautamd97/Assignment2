#!/bin/bash    
    # Shebang line -> indicates that the script should be run using bash shell

# Check if the script is being run as Root, and exit if it is not being run as Root
if [ "$UID" -ne 0 ]; then
  
    echo "This script must be run as root"
    exit 1
fi

#The cat command displays the content of the ins_packages file
#The while loop reads each line separately and stores it in the variable package.
cat ins_packages.txt | while read -r package; do
#pacman -S installs the package and syncs it
# --noconfirm automatically downloads it without requiring user input
# $package is the name of the package called earlier in the while loop
pacman -S --noconfirm "$package"

done #ends the while loop

echo "Installation of packages completed"
