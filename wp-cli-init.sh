#!/bin/bash

wp_cli_path=~/wp-cli.phar
wp_completion_path=~/wp-completion.bash

function install_wp_cli {
	curl -o $wp_cli_path https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x $wp_cli_path
	echo "✅ WP-CLI установлен"
}
function install_wp_completion {
	curl -o $wp_completion_path https://raw.githubusercontent.com/wp-cli/wp-cli/main/utils/wp-completion.bash
	echo "✅ WP-Completion установлен"
}

echo ""
# проверка WP-CLI

if [ -e "$wp_cli_path" ]; then
    # Если wp-cli.phar существует

    alias wp="$wp_cli_path"
    echo "WP-CLI запущен"

		update_status=$(wp cli check-update)
		if [[ "$update_status" == *"Success: WP-CLI is at the latest version."* ]]; then
		    echo "WP-CLI последней версии"
		else
		    echo -e "\nДоступны обновления WP-CLI:"
		    echo "$update_status"

		    read -p "Обновить WP-CLI? (Y/N): " choice
		    if [[ "$choice" == "Y" || "$choice" == "y" ]]; then
		        # Обновляем WP-CLI
		        wp cli update --yes
		        # Загружаем файл wp-completion.bash
		        install_wp_completion
		    else
		        echo -e "\nWP-CLI не обновлен"
		    fi
		fi
else
		install_wp_cli
fi

# проверка WP-Completion

if [ -e "$wp_completion_path" ]; then
    # Если файл существует, устанавливаем псевдоним с использованием переменной
    source $wp_completion_path
    echo "WP-Completion запущен"
else
	install_wp_completion
fi
