#!/bin/bash

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MONITOR_FILE="$REPO_DIR/.monitor"

sync_to_home() {
    echo "Installing monitored files/folders to \$HOME..."

    while IFS= read -r path; do
        # Skip empty lines or lines starting with #
        [[ -z "$path" || "$path" =~ ^# ]] && continue

        SRC="$REPO_DIR/$path"
        DEST="$HOME/$path"

        if [ -d "$SRC" ]; then
            echo "Syncing directory $SRC -> $DEST"
            mkdir -p "$DEST"
            rsync -a --exclude='.git' "$SRC/" "$DEST/"
        elif [ -f "$SRC" ]; then
            echo "Copying file $SRC -> $DEST"
            mkdir -p "$(dirname "$DEST")"
            cp "$SRC" "$DEST"
        else
            echo "Warning: $SRC does not exist in repo, skipping."
        fi
    done < "$MONITOR_FILE"

    echo "Install complete."
}

sync_to_repo() {
    echo "Pulling monitored files/folders from \$HOME to repo..."

    while IFS= read -r path; do
        # Skip empty lines or lines starting with #
        [[ -z "$path" || "$path" =~ ^# ]] && continue

        SRC="$HOME/$path"
        DEST="$REPO_DIR/$path"

        if [ -d "$SRC" ]; then
            echo "Syncing directory $SRC -> $DEST"
            mkdir -p "$DEST"
            rsync -a --delete --exclude='.git' "$SRC/" "$DEST/"
        elif [ -f "$SRC" ]; then
            echo "Copying file $SRC -> $DEST"
            mkdir -p "$(dirname "$DEST")"
            cp "$SRC" "$DEST"
        else
            echo "Warning: $SRC does not exist in \$HOME, skipping."
        fi
    done < "$MONITOR_FILE"

    echo "Pull complete."
}

usage() {
    echo "Usage: $0 [install|pull]"
    exit 1
}

if [ ! -f "$MONITOR_FILE" ]; then
    echo "Error: .monitor file not found in repo root."
    exit 1
fi

if [ $# -ne 1 ]; then
    usage
fi

case "$1" in
    install)
        sync_to_home
        ;;
    pull)
        sync_to_repo
        ;;
    *)
        usage
        ;;
esac
