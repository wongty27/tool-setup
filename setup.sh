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

# 1. Install Go and Yarn via Package Manager
echo "Installing Yarn..."
$INSTALL_CMD yarn

# 2. Install uv (Official Script)
echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# 3. Install nvm (Official Script)
echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Load nvm for the remainder of this script session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 4. Install Node.js LTS via nvm
echo "Installing Node.js LTS..."
nvm install --lts

echo "------------------------------------------------"
echo "Setup complete! Please restart your terminal."
echo "------------------------------------------------"