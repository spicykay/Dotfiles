#!/usr/bin/env bash
# Backup Brew
brew_file_location=$(git rev-parse --show-toplevel)/Brewfile
brew bundle dump --file=- | sed '/groupon/d' > "${brew_file_location}"
