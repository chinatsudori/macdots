#!/bin/zsh

# Install xCode CLI tools
echo "Installing command-line tools..."
xcode-select --install

# Homebrew
## Install
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

## Taps
echo "Tapping Brew..."
brew tap FelixKratz/formulae
brew tap koekeishiya/formulae
brew tap homebrew/cask-fonts

## Formulae
echo "Installing Brew Formulae..."
### Essentials
brew install gsl
brew install llvm
brew install boost
brew install libomp
brew install armadillo
brew install wget
brew install jq
brew install ripgrep
brew install bear
brew install mas
brew install gh
brew install ifstat
brew install switchaudio-osx
brew install skhd
brew install sketchybar
brew install borders
brew install aerospace  # Replaced yabai with aerospace

### Terminal & CLI Enhancements
brew install neovim
brew install helix
brew install starship
brew install zsh-autosuggestions
brew install zsh-fast-syntax-highlighting
brew install zoxide
brew install eza
brew install bat
brew install fd
brew install tldr
brew install fzf
brew install lazygit
brew install btop
brew install svim
brew install dooit
brew install git
brew install tmate
brew install mtr
brew install iperf
brew install duf
brew install ncdu
brew install exa

### Custom HEAD only forks
brew install fnnn --head # nnn fork (changed colors, keymappings)

## Casks
echo "Installing Brew Casks..."
### Terminal & Development
brew install --cask ghostty
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask devutils
brew install --cask postman
brew install --cask chatgpt
brew install --cask grammarly

### System Utilities & Enhancements
brew install --cask soundsource
brew install --cask onyx
brew install --cask xnip
brew install --cask vesktop
brew install --cask parsec
brew install --cask openvpn-connect
brew install --cask maccy
brew install --cask ice
brew install --cask itsycal
brew install --cask hyperkey
brew install --cask capslocknodelay
brew install --cask mos
brew install --cask latest
brew install --cask tacky-borders
brew install --cask porting-kit

### Microsoft Suite
brew install --cask microsoft-office
brew install --cask powershell
brew install --cask microsoft-outlook
brew install --cask microsoft-teams
brew install --cask slack
brew install --cask miro
brew install --cask adobe-acrobat-reader

### Media & Productivity
brew install --cask skim
brew install --cask vlc
brew install --cask spotify

### Reversing & Development
brew install --cask machoview
brew install --cask hex-fiend
brew install --cask cutter
brew install --cask sloth

### Fonts
brew install --cask sf-symbols
brew install --cask font-sf-mono
brew install --cask font-sf-pro
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono
brew install --cask font-fira-code
brew install --cask font-maple-mono-nf  # Added Maple Font

# Mac App Store Apps
echo "Installing Mac App Store Apps..."
mas install 1451685025 # Wireguard
mas install 497799835  # xCode
mas install 1480933944 # Vimari

# macOS Performance & Arch-Like Defaults
echo "Applying macOS performance optimizations..."
## General Performance Tweaks
sudo pmset -a hibernatemode 0       # Disable hibernation
sudo pmset -a standby 0             # Disable standby mode
sudo pmset -a autopoweroff 0        # Disable auto power off
sudo systemsetup -setcomputersleep Off > /dev/null
sudo systemsetup -setdisplaysleep Off > /dev/null
sudo systemsetup -setharddisksleep Off > /dev/null

## Faster Key Repeat & Trackpad Tweaks
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain com.apple.trackpad.scaling -int 3
defaults write NSGlobalDomain com.apple.mouse.scaling -1

## Reduce Animations & UI Enhancements
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide -bool true
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write com.apple.finder DisableAllAnimations -bool true

## Dock & Spaces Tweaks
defaults write com.apple.spaces spans-displays -bool false
defaults write com.apple.dock "mru-spaces" -bool "false"
defaults write com.apple.dock show-recents -bool false

## Finder Tweaks for Performance
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder ShowStatusBar -bool false
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.Finder AppleShowAllFiles -bool true

## Keyboard Navigation in UI
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

## Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

## Disable System Sounds
defaults write com.apple.systemsound "com.apple.sound.beep.volume" -float 0
defaults write NSGlobalDomain "com.apple.sound.uiaudio.enabled" -int 0

## Disable Siri
defaults write com.apple.assistant.supported -bool false
launchctl disable gui/$(id -u)/com.apple.Siri.agent

## Disable Auto-Correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

## Disable Auto-Capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Fix for MX Master 3S
sudo defaults write /Library/Preferences/com.apple.airport.bt.plist bluetoothCoexMgmt Hybrid

# Copying and checking out configuration files
echo "Planting Configuration Files..."
[ ! -d "$HOME/dotfiles" ] && git clone --bare git@github.com:FelixKratz/dotfiles.git $HOME/dotfiles
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout master

# Installing Fonts
git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
mv /tmp/SFMono_Nerd_Font/* $HOME/Library/Fonts
rm -rf /tmp/SFMono_Nerd_Font/

curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.28/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

source $HOME/.zshrc

# Start Services
echo "Starting Services..."
brew services start skhd
brew services start aerospace
brew services start sketchybar
brew services start borders
brew services start svim

csrutil status
echo "Installation complete!"
