#!/bin/bash

# Set variables
VSCODE_DIR="$HOME/.local/share/vscode"
DESKTOP_FILE="$HOME/.local/share/applications/vscode.desktop"
VSCODE_URL="https://update.code.visualstudio.com/latest/linux-x64/stable"

# Create directories if they don't exist
mkdir -p "$VSCODE_DIR"
mkdir -p "$(dirname "$DESKTOP_FILE")"

# Download VS Code tar.gz
echo "Downloading Visual Studio Code..."
curl -L "$VSCODE_URL" -o /tmp/vscode.tar.gz

# Extract and overwrite existing installation
echo "Extracting..."
tar -xzf /tmp/vscode.tar.gz -C "$VSCODE_DIR" --strip-components=1

# Add to PATH in ~/.bashrc if not already present
if ! grep -q "$VSCODE_DIR" "$HOME/.bashrc"; then
    echo "export PATH=\$PATH:$VSCODE_DIR" >> "$HOME/.bashrc"
    echo "Added VS Code to PATH in ~/.bashrc"
fi

# Create .desktop file
echo "Creating desktop launcher..."
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Visual Studio Code
Comment=Code Editing. Redefined.
Exec=$VSCODE_DIR/code
Icon=$VSCODE_DIR/resources/app/resources/linux/code.png
Type=Application
Categories=Development;IDE;
Terminal=false
EOF

# Refresh desktop database
update-desktop-database "$HOME/.local/share/applications/"

# Cleanup
rm /tmp/vscode.tar.gz

echo "VS Code setup complete!"
echo "You may need to restart your terminal or run 'source ~/.bashrc' to use 'code' from anywhere."
