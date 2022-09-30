#!/bin/bash

cat << "EOF"
  _    _ _ _   _                 _                 
 | |  | | | | (_)               | |                
 | |  | | | |_ _ _ __ ___   __ _| |_ ___           
 | |  | | | __| | '_ ` _ \ / _` | __/ _ \          
 | |__| | | |_| | | | | | | (_| | ||  __/          
  \____/|_|\__|_|_|_|_| |_|\__,_|\__\___|          
               |  __ \      | |  / _(_) |          
               | |  | | ___ | |_| |_ _| | ___  ___ 
               | |  | |/ _ \| __|  _| | |/ _ \/ __|
               | |__| | (_) | |_| | | | |  __/\__ \
               |_____/ \___/ \__|_| |_|_|\___||___/
                                                   
EOF

echo ""
echo "Version: 1.0.0"

function linkDotfilesZSH {
  DOTFILESDIR="/dotfiles"

  if [ -n "$1" ]; then
    DOTFILESDIR=$1
  fi


  rm ~/.zshrc
  ln -s $DOTFILESDIR/zsh/configs/$2 ~/.zshrc

  rm -R ~/.oh-my-zsh/custom/themes
  rm -R ~/.oh-my-zsh/custom/plugins

  ln -s $DOTFILESDIR/zsh/themes ~/.oh-my-zsh/custom/themes
  ln -s $DOTFILESDIR/zsh/plugins ~/oh-my-zsh/custom/plugins
}

function linkDotfilesHyper {
  DOTFILESDIR="/dotfiles"

  if [ -n "$1" ]; then
    DOTFILESDIR=$1
  fi

  rm ~/.hyper.js
  ln -s $DOTFILESDIR/hyper/preferences ~/.hyper.js
}


if [ ! -n "$1" ]; then
  echo "[Warning] Profile type not specified, defaulting to work"
elif [ "$1" = "container" ]; then
  echo "[Info] Installing Container Profile"

  # Installing Oh My ZSH
  echo "[Info] Installing Oh My ZSH"
  sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --unattended
  linkDotfilesZSH /dotfiles container

elif [ "$1" = "work" ]; then
  echo "[Info] Installing Work Profile"

  # Installing Oh My ZSH
  echo "[Info] Installing Oh My ZSH"
  sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --unattended
  linkDotfilesZSH ~/.dotfiles work

  echo "[Info] Install Hyper Preferences"
  linkDotfilesHyper ~/.dotfiles
else 
  echo "[Error] Unknown install type"
fi