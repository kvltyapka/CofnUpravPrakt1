#!/bin/bash

# Проверка наличия аргумента
if [ -z "$1" ]; then
    echo "Usage: $0 filename"
    exit 1
fi

grep -oE '\b[_a-zA-Z][_a-zA-Z0-9]*\b' "$1" | sort -u
