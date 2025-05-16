#!/bin/sh

# HELP: Choose local branch from list

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
    echo >&2 "AXT ERROR: Please execute $0 from axt"
    exit 1
fi
command -v peco  >/dev/null 2>&1 || { echo >&2 "AXT ERROR: axt git branch requires helper 'peco'!"; exit 1; }

while true; do
    SELECTION=$(git branch | peco)

    if [ -z "${SELECTION}" ]; then
        exit
    fi

    DELETE_BRANCH="${SELECTION:2:${#SELECTION}}"

    read -p "Do you really want to delete ${DELETE_BRANCH}? (y/N): " CONFIRM
    if [[ "${CONFIRM}" =~ ^[Yy]$ ]]; then
        git branch -D ${DELETE_BRANCH}
    fi
done



