#!/bin/bash

# Check if python3 command exists
if command -v python3 &>/dev/null; then
    echo "Python 3 is installed."
    python3 --version
else
    echo "Error: Python 3 is not installed. Python 3 must be installed to run this script." >&2
    exit 1
fi

# Create the .dotfiles directory in the user's home directory if it doesn't exist
if [ ! -d "$HOME/.dotfiles" ]; then
    mkdir $HOME/.dotfiles
fi

# Synchronize the current directory with the .dotfiles directory, overwriting the destination
rsync -a --delete ./ $HOME/.dotfiles/

# Download and install Zimfw
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

# Add configurations to the .zshrc file
echo '# - - - - - - - - - - DFOX - - - - - - - - - -' >> $HOME/.zshrc
echo 'export DFOX_PATH="$HOME/.dotfiles"'             >> $HOME/.zshrc
echo 'source $DFOX_PATH/init.sh'                      >> $HOME/.zshrc
echo '# - - - - - - - - - - - - - - - - - - - - - -'  >> $HOME/.zshrc