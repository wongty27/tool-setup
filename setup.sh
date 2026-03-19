#!/bin/bash

# Detect Operating System
OS="$(uname)"

if [ "$OS" == "Darwin" ]; then
    echo "Detected macOS. Using Homebrew..."
    # Install Homebrew if not present
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    INSTALL_CMD="brew install"
elif [ "$OS" == "Linux" ]; then
    echo "Detected Linux. Using apt..."
    sudo apt update
    INSTALL_CMD="sudo apt install -y"
else
    echo "Unsupported OS"
    exit 1
fi

# 1. Install pnpm via Package Manager
echo "Installing pnpm..."
$INSTALL_CMD pnpm

# 2. Install bun
$INSTALL_CMD oven-sh/bun/bun

# 3. Install uv 
echo "Installing uv..."
$INSTALL_CMD uv

# 4. Install nvm (Official Script)
echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Load nvm for the remainder of this script session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "------------------------------------------------"
echo "Setup complete! Please restart your terminal."
echo "------------------------------------------------"