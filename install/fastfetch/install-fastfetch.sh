#!/usr/bin/env bash
# Fastfetch installer/updater/remover for Steam Deck (user-space)

set -e

INSTALL_DIR="$HOME/.local/bin"
SHARE_DIR="$HOME/.local/share"
FASTFETCH_BIN="$INSTALL_DIR/fastfetch"
BASHRC="$HOME/.bashrc"
RELEASE_URL="https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.tar.gz"

# Ensure required commands exist
for cmd in curl tar; do
    command -v "$cmd" >/dev/null 2>&1 || { echo "❌ $cmd is required but not installed."; exit 1; }
done

ensure_path() {
    if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$BASHRC"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$BASHRC"
    fi
}

install_fastfetch() {
    echo "⬇️ Installing Fastfetch..."

    mkdir -p "$INSTALL_DIR" "$SHARE_DIR" || { echo "❌ Cannot create installation directories."; exit 1; }

    TMP_TAR="$(mktemp)"
    TMP_DIR="$(mktemp -d)"
    trap 'rm -rf "$TMP_DIR" "$TMP_TAR"' EXIT

    curl -fsSL -L "$RELEASE_URL" -o "$TMP_TAR"
    echo "📦 Extracting Fastfetch..."
    tar -xzf "$TMP_TAR" -C "$TMP_DIR"

    EXTRACTED_DIR="$(find "$TMP_DIR" -maxdepth 1 -type d -name 'fastfetch-*' | head -n 1)"
    if [ -z "$EXTRACTED_DIR" ]; then
        echo "❌ Could not find extracted fastfetch directory!"
        exit 1
    fi

    if [ -f "$EXTRACTED_DIR/usr/bin/fastfetch" ]; then
        mv -f "$EXTRACTED_DIR/usr/bin/fastfetch" "$FASTFETCH_BIN"
        chmod +x "$FASTFETCH_BIN"
    else
        echo "❌ fastfetch binary not found in archive!"
        exit 1
    fi

    if [ -d "$EXTRACTED_DIR/usr/share/fastfetch" ]; then
        rm -rf "$SHARE_DIR/fastfetch"
        mv -f "$EXTRACTED_DIR/usr/share/fastfetch" "$SHARE_DIR/"
    fi

    ensure_path
    echo "✅ Fastfetch installed successfully!"
    echo "➡️ You can now run 'fastfetch' from the terminal."
}

update_fastfetch() {
    echo "🔄 Updating Fastfetch..."
    install_fastfetch
    echo "✅ Fastfetch updated successfully!"
}

remove_fastfetch() {
    echo "🗑️ Removing Fastfetch..."
    rm -f "$FASTFETCH_BIN"
    rm -rf "$SHARE_DIR/fastfetch"

    # Remove PATH line if added by this script
    sed -i '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$BASHRC"

    # Remove fastfetch auto-run line
    sed -i '/fastfetch/d' "$BASHRC"

    echo "✅ Fastfetch removed!"
    echo "➡️ Restart your terminal or run: source $BASHRC"
}

enable_autorun() {
    if ! grep -q "$FASTFETCH_BIN" "$BASHRC"; then
        echo "$FASTFETCH_BIN" >> "$BASHRC"
        echo "✅ Fastfetch will now auto-run when you open a terminal."
    else
        echo "ℹ️ Fastfetch is already set to auto-run."
    fi
}

disable_autorun() {
    sed -i '/fastfetch/d' "$BASHRC"
    echo "✅ Fastfetch auto-run disabled. It will no longer run on terminal startup."
}

case "$1" in
    --update) update_fastfetch ;;
    --remove) remove_fastfetch ;;
    --autorun) enable_autorun ;;
    --no-autorun) disable_autorun ;;
    *) install_fastfetch ;;
esac
