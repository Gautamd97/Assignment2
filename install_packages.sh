#!/bin/bash    
    # Shebang line -> indicates that the script should be run using bash shell

if [ "$UID" -ne 0 ]; then
  
    echo "This script must be run as root"
    exit 1
fi

cat ins_packages.txt | while read -r package; do
package=($(< "ins_packages.txt"))

pacman -S --noconfirm "$package"

done

echo "Installation of packages completed"
