#!/usr/bin/env bash


dir="$HOME/.config/rofi"
theme='rose-pine'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
