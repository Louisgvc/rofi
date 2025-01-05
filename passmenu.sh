#!/usr/bin/env bash

shopt -s nullglob globstar

dir="$HOME/.config/rofi"
theme='rose-pine'

typeit=0
if [[ $1 == "--type" ]]; then
	typeit=1
	shift
fi

if [[ -n $WAYLAND_DISPLAY ]]; then
	dmenu="rofi -dmenu -modi 'dmenu' -theme ${dir}/${theme}.rasi -p "Password""
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
	dmenu="rofi -dmenu -modi 'dmenu' -theme ${dir}/${theme}.rasi -p "Password""
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Erreur : Aucun affichage Wayland ou X11 détecté" >&2
	exit 1
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}

password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" | $dmenu "$@")

[[ -n $password ]] || exit

if [[ $typeit -eq 0 ]]; then
	pass show -c "$password" 2>/dev/null
else
	pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } | $xdotool
fi

