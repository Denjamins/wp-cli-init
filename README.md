# WP-CLI-Init Script

This Shell script is designed for shared hosting environments without root access. It facilitates the installation, verification, and updating of [WP CLI](https://wp-cli.org) along with [Tab Completion for WP CLI](https://make.wordpress.org/cli/handbook/guides/installing/#tab-completions).

## Features:
- Installs WP-CLI and WP-Completion if not already present.
- Checks for WP-CLI updates and prompts for an update if available.
- Ensures seamless usage of WP-CLI and its tab completion.

## Instructions:
1. Run the script to install WP-CLI and WP-Completion.
2. The script checks for updates, and if available, prompts for an update.
3. Enjoy the latest version of WP-CLI with tab completion support.

## Installation:
1. Download to the user home directory with:
   ```bash
   wget -O wp-cli-init.sh https://raw.githubusercontent.com/Denjamins/wp-cli-init/main/wp-cli-init.sh
   ```
2. Add `source ~/wp-cli-init.sh` to your `.bashrc`:
   ```bash
   echo "source ~/wp-cli-init.sh" >> ~/.bashrc
   ```
   or `.bash_profile`:
   ```bash
   echo "source ~/wp-cli-init.sh" >> ~/.bash_profile
   ```

**Author:** Denis Surkov

**GitHub:** https://github.com/Denjamins

Feel free to contribute or provide feedback!
