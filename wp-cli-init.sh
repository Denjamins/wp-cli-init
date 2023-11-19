#!/bin/bash

# wp-cli-init
# Shell Script by Denis Surkov
# GitHub: https://github.com/Denjamins/wp-cli-init 

# Current version of the script
current_version="1.01"

# Function to check the version
check_version() {
    remote_version=$(curl -s https://raw.githubusercontent.com/Denjamins/wp-cli-init/main/wp-cli-init.sh | grep -oP '^current_version="\K[^"]+')
    
    if [[ "$current_version" == "$remote_version" ]]; then
        echo -e "\n WP-CLI-Init $current_version is up to date."
    else
        echo "WP-CLI-Init $remote_version is available."
        read -p "Would you like to update? (Y/N): " choice
        if [[ "$choice" == "Y" || "$choice" == "y" ]]; then
            wget -O wp-cli-init.sh https://raw.githubusercontent.com/Denjamins/wp-cli-init/main/wp-cli-init.sh
            echo "WP-CLI-Init updated to $remote_version."
        else
            echo "Update canceled."
        fi
    fi
}

# Check the version when the script is executed
check_version

# Paths to WP-CLI and WP-Completion files
wp_cli_path=~/wp-cli.phar
wp_completion_path=~/wp-completion.bash

# Function to install WP-CLI
install_wp_cli() {
    curl -o "$wp_cli_path" https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x "$wp_cli_path"
    echo "✅ WP-CLI installed"
}

# Function to install WP-Completion
install_wp_completion() {
    curl -o "$wp_completion_path" https://raw.githubusercontent.com/wp-cli/wp-cli/main/utils/wp-completion.bash
    echo "✅ WP-Completion installed"
}

echo ""

# Checking for WP-CLI
if [ -e "$wp_cli_path" ]; then
    # If wp-cli.phar exists
    alias wp="$wp_cli_path"
    echo "WP-CLI is running"

    update_status=$(wp cli check-update)
    if [[ "$update_status" == *"Success: WP-CLI is at the latest version."* ]]; then
        echo "WP-CLI is up to date"
    else
        echo -e "\nUpdates available for WP-CLI:"
        echo "$update_status"
    
        read -p "Update WP-CLI? (Y/N): " choice
        if [[ "$choice" == "Y" || "$choice" == "y" ]]; then
            # Updating WP-CLI
            wp cli update --yes
            # Downloading wp-completion.bash
            install_wp_completion
        else
            echo "Update canceled."
        fi
    fi
else
    # If wp-cli.phar does not exist, install it
    install_wp_cli
fi

# Checking for WP-Completion
if [ -e "$wp_completion_path" ]; then
    # If file exists, set up alias using the variable
    source "$wp_completion_path"
    echo "WP-Completion is running"
else
    # If wp-completion.bash does not exist, install it
    install_wp_completion
fi
