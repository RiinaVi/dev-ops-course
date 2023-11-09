#!/bin/bash

# Creating associative array to store all possible install commands
declare -A package_install_commands

#Install command type is identified by a ditribution type which is defined by presense of particular release directory
package_install_commands["/etc/redhat-release"]="yum install"
package_install_commands["/etc/arch-release"]="pacman -S"
package_install_commands["/etc/gentoo-release"]="emerge"
package_install_commands["/etc/SuSE-release"]="zypper in"
package_install_commands["/etc/debian_version"]="apt-get install"
package_install_commands["/etc/fedora-release"]="dnf install"

#The package that needs to be installed is taken from the first argument
package_to_install=$1

#Function that invokes installation command passed to it via arguments
install_package() {
 local package_to_install=$1
 local install_command=$2
 "${install_command}" "${package_to_install}"
}

#Iterating through all possible instalation commands
for package_manager in "${!package_install_commands[@]}"
do

#If certain directoty exists in the system
   if [[ -f $package_manager ]]; then
  # call function that installes needed package
       install_package "$package_to_install" "${package_install_commands[$package_manager]}"
   fi
done

