#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    dirs=()
    for d in ~/Github ~/Projects; do
        [[ -d "$d" ]] && dirs+=("$d")
    done
    selected=$(find "${dirs[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

existing=$(herdr workspace list 2>/dev/null | python3 -c "
import json,sys
data=json.load(sys.stdin)
for w in data['result']['workspaces']:
    if w['label'] == '$selected_name':
        print(w['workspace_id'])
        break
")

if [[ -n $existing ]]; then
    herdr workspace focus "$existing"
else
    herdr workspace create --cwd "$selected" --label "$selected_name" --focus
fi
