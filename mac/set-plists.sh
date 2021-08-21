#!/usr/bin/env bash

# General Mac Settings
## Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

## Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

## Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

## Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Finder
# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
   General -bool true \
   OpenWith -bool true \
   Privileges -bool true

# Dock/Dashboard
## Automatically hide and show Dock.
sudo defaults write /Library/Preferences/com.apple.dock autohide -bool YES
defaults write com.apple.dock autohide -bool true

## Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

## Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

## Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# TextEdit
## Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

## Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
