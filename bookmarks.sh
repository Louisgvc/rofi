#!/bin/bash

DIR="$HOME/.config/rofi"
THEME='rose-pine'
BOOKMARKS_FILE="$HOME/.config/rofi/.bookmarks"

# Note: the default browser is setted by the default envirorment variable $BROWSER
# You can change in uncommenting the following line (the example browser is "firefox")
BROWSER="firefox"

# Check if there is a bookmarks file and if not, make one

if [[ ! -a "${BOOKMARKS_FILE}" ]]; then
    touch "${BOOKMARKS_FILE}"
fi

INPUT=$(rofi -dmenu -theme "${DIR}"/${THEME}.rasi -p "bookmarks" < "$BOOKMARKS_FILE")

if   [[ $INPUT == "+"* ]]; then
    INPUT=$(echo $INPUT | sed 's/+//')
    if [[ $INPUT == *"."* ]]; then
        echo "$INPUT" >> "$BOOKMARKS_FILE"
    else 
        INPUT="${INPUT}.com" && echo "$INPUT" >> "$BOOKMARKS_FILE"
    fi
elif [[ $INPUT == "_"* ]]; then
    INPUT=$(echo "$INPUT" | sed 's/_//') && sed -i "/$INPUT/d" "$BOOKMARKS_FILE"
elif [[ $INPUT == *"."* ]]; then
    $BROWSER "$INPUT"
elif [[ -z $INPUT  ]]; then
    exit 0
else
    $BROWSER -new-tab "https://www.google.com/search?q=$INPUT"
    # $BROWSER --search $INPUT
    # Set search engine (comment $BROWSER --search $INPUT and uncomment the following (example is duckducgo)
    # $BROWSER "http://www.duckduckgo.com/search?q=$INPUT"
fi
