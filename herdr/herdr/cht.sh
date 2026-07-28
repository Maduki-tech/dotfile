#!/usr/bin/env bash
dirs=("$HOME/.config/script" "$HOME/.config/tmux")
for d in "${dirs[@]}"; do
  f1="$d/cht-languages"; f2="$d/cht-commands"
  [[ -f "$f1" ]] && cat "$f1"
  [[ -f "$f2" ]] && cat "$f2"
done | sort -u | fzf | read -r selected
[[ -z "$selected" ]] && exit 0

read -p "Query: " query

is_lang=
for d in "${dirs[@]}"; do
  f="$d/cht-languages"
  [[ -f "$f" ]] && grep -qs "$selected" "$f" && is_lang=1
done

if [[ $is_lang ]]; then
  query=$(echo "$query" | tr ' ' '+')
  curl cht.sh/"$selected"/"$query"
else
  curl -s cht.sh/"$selected"~"$query"
fi

echo
read -p "Press Enter to close"
