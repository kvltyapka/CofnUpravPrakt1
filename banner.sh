#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 \"text\""
    exit 1
fi

text="$1"
length=${#text}
border=$(printf '%*s' $((length + 2)) '' | tr ' ' '-')

echo "+$border+"
echo "| $text |"
echo "+$border+"
