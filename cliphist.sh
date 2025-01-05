#!/bin/bash

DIR="$HOME/.config/rofi"
THEME='rose-pine'

CLIPHIST_FILE="$HOME/.config/rofi/.cliphist.txt"


if [ ! -f "$CLIPHIST_FILE" ]; then
    touch "$CLIPHIST_FILE"
fi

show_clip_history() {
    local selected_clip
    selected_clip=$(cat "$CLIPHIST_FILE" | rofi -dmenu -theme "${DIR}"/${THEME}.rasi -i -p "historique")

    if [ -n "$selected_clip" ]; then
        echo "$selected_clip" | xclip -selection clipboard
    fi
}

show_clip_history

