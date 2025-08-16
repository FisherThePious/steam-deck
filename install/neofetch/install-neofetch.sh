#!/usr/bin/env bash
# Neofetch installer/updater/remover for Steam Deck (user-space)

set -e

INSTALL_DIR="$HOME/.local/bin"
BASHRC="$HOME/.bashrc"
NEOFETCH_PATH="$INSTALL_DIR/neofetch"

# Ensure required commands exist
command -v curl >/dev/null 2>&1 || { echo "❌ curl is required but not installed."; exit 1; }

ensure_path() {
    if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$BASHRC"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$BASHRC"
    fi
}

install_neofetch() {
    echo "⬇️ Installing Neofetch..."
    mkdir -p "$INSTALL_DIR" || { echo "❌ Cannot create installation directory."; exit 1; }

    curl -fsSL https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch -o "$NEOFETCH_PATH"
    chmod +x "$NEOFETCH_PATH"

    ensure_path

    echo "✅ Neofetch installed successfully!"
    echo "➡️ You can now run 'neofetch' from the terminal."
}

update_neofetch() {
    echo "🔄 Updating Neofetch..."
    install_neofetch
    echo "✅ Neofetch updated successfully!"
}

remove_neofetch() {
    echo "🗑️ Removing Neofetch..."
    rm -f "$NEOFETCH_PATH"

    # Remove PATH line if added by this script
    sed -i '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$BASHRC"

    # Remove neofetch auto-run line
    sed -i '/neofetch/d' "$BASHRC"

    echo "✅ Neofetch removed!"
    echo "➡️ Restart your terminal or run: source $BASHRC"
}

enable_autorun() {
    if ! grep -q "$NEOFETCH_PATH" "$BASHRC"; then
        echo "$NEOFETCH_PATH" >> "$BASHRC"
        echo "✅ Neofetch will now auto-run when you open a terminal."
    else
        echo "ℹ️ Neofetch is already set to auto-run."
    fi
}

disable_autorun() {
    sed -i '/neofetch/d' "$BASHRC"
    echo "✅ Neofetch auto-run disabled. It will no longer run on terminal startup."
}

case "$1" in
    --update) update_neofetch ;;
    --remove) remove_neofetch ;;
    --autorun) enable_autorun ;;
    --no-autorun) disable_autorun ;;
    *) install_neofetch ;;
esac