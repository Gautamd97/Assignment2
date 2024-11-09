# System Setup and User Creation

This repository contains two scripts:
1. System Setup Script (Project 1) - Automates the installation of packages and configuration
2. User Creation Script (Project 2) - Automates the creation of new user

You will need to gitclone this repository where you want to run these scripts before proceeding any further.
## Project 1: System Setup

The system setup script automates the installation of packages and creates symbolic links for configuration files from a Git repository

### Running the System Setup Script

To run this script, execute the following command:
```bash
sudo ./setup.sh -b
```
The above command will run the install_packages.sh and sym_link.sh scripts.

If you require only one script to run, replace the "b" from the command with "i" to run the install_packages script or "c" to run the sym_link script.

## Project 2: User Creation Script

The User Creation Script automates the process of creating a new user on the system with a password, sudo privelages, and a group.

### Running the User Creation Script

To run this script, use the following command

```bash
sudo ./new_user.sh -u <username> -p <password>
```

### Arguments
- -u: The username of the new user

- -p: The password for the new user

If either argument is missing, it will show an error.

## Troubleshooting
- Ensure you are running the scripts as the root user.

## Conclusion
These scripts provide an efficient way to automate system setup and user creation on Linux systems. The System Setup Script installs the necessary packages to ensure a consistent development environment. The User Creation Script simplifies the process of creating users. These scripts help save time, reduce errors and help maintain a standard configuration across the system.

## References

CBT Nuggets. (n.d.). Linux file permissions: UID vs. GID. Retrieved November 8, 2024, from https://www.cbtnuggets.com/blog/technology/system-admin/linux-file-permission-uid-vs-gid

GitLab. (n.d.). CIT 2420 notes for Fall 2024. Retrieved November 8, 2024, from https://gitlab.com/cit2420/2420-notes-f24

Ask Ubuntu. (n.d.). How do I grant sudo privileges to an existing user? Retrieved November 8, 2024, from https://askubuntu.com/questions/168280/how-do-i-grant-sudo-privileges-to-an-existing-user

Pluralsight. (n.d.). How to add a user in Linux (adduser command). Retrieved November 8, 2024, from https://www.pluralsight.com/resources/blog/software-development/linux-add-user-command