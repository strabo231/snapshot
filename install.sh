#!/bin/bash

# SnapShot installer script
set -e

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="snapshot"
REPO_URL="https://raw.githubusercontent.com/YOUR_USERNAME/snapshot/main/snapshot"

echo "📸 SnapShot Installer"
echo "===================="
echo ""

if [ "$EUID" -eq 0 ]; then
    INSTALL_DIR="/usr/local/bin"
    echo "Installing system-wide to $INSTALL_DIR"
elif [ -w "$INSTALL_DIR" ]; then
    echo "Installing system-wide to $INSTALL_DIR"
else
    INSTALL_DIR="$HOME/.local/bin"
    echo "Installing to user directory $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"
    
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo ""
        echo "⚠️  Note: $HOME/.local/bin is not in your PATH"
        echo "Add this line to your ~/.bashrc:"
        echo ""
        echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
        echo ""
    fi
fi

echo "Downloading snapshot..."
if command -v curl &> /dev/null; then
    curl -sSL "$REPO_URL" -o "/tmp/$SCRIPT_NAME"
elif command -v wget &> /dev/null; then
    wget -q "$REPO_URL" -O "/tmp/$SCRIPT_NAME"
else
    echo "Error: Neither curl nor wget is available"
    exit 1
fi

chmod +x "/tmp/$SCRIPT_NAME"

if [ -w "$INSTALL_DIR" ]; then
    mv "/tmp/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
else
    sudo mv "/tmp/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
fi

echo "✓ SnapShot installed successfully!"
echo ""
echo "Try it out:"
echo "  snapshot save test"
echo "  snapshot list"
echo ""
