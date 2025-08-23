#!/usr/bin/env bash

options=("Go" "Java" "Javascript" "Rust" "C" "C++" "Python" "youtube" "fullstack" "nvim-package" "other")
PS3="Select folder: "

select folder_name in "${options[@]}"; do
    if [[ -z $folder_name ]]; then
        echo "Invalid selection."
        exit 1
    fi
    break
done

read -p "Enter subfolder name: " subfolder_name

if [[ -z $subfolder_name ]]; then
    echo "Subfolder name cannot be empty."
    exit 1
fi

mkdir "$HOME/personal/$folder_name/$subfolder_name"
echo "$HOME/personal/$folder_name/$subfolder_name"

if [[ $? -ne 0 ]]; then
    echo "Error creating subfolder '$subfolder_name' in '$folder_name'."
    exit 1
fi

echo "Subfolder '$subfolder_name' created successfully in '$folder_name' folder of your home directory."

selected="$HOME/personal/$folder_name/$subfolder_name"
selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t $selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name

