#!/bin/bash

if [ "$UID" -ne 0 ]; then

  echo "This script must be run as root"
  exit 1
fi

./install_packages.sh

./sym_link.sh

echo "Setup is complete"


