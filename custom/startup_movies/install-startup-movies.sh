#!/usr/bin/env bash
# Script to copy startup movies to Steam UI Overrides
# Source folder is relative to this script

set -e

# Determine the directory this script is in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR"
TARGET_DIR="$HOME/.steam/steam/config/uioverrides/movies"

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "📁 Target directory does not exist. Creating: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Copy .webm and .jpg files without overwriting
echo "📂 Copying .webm and .jpg files from $SRC_DIR to $TARGET_DIR..."
shopt -s nullglob
for file in "$SRC_DIR"/*.{webm,jpg}; do
    filename=$(basename "$file")
    if [ -e "$TARGET_DIR/$filename" ]; then
        echo "⚠️ Skipping existing file: $filename"
    else
        cp "$file" "$TARGET_DIR/"
        echo "✅ Copied: $filename"
    fi
done
shopt -u nullglob

echo "🎬 All done!"