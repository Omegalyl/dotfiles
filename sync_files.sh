#!/bin/bash

# Files and directories to sync
files_to_sync=(".xinitrc" ".vimrc" ".dwm", "bin")

# Current directory
target_dir=$(pwd)

# Function to sync files/directories
sync_file() {
  local file="$HOME/$1"
  local dest=$2

  if [ -d "$file" ]; then
    rsync -a "$file/" "$dest/${file##*/}/"
  elif [ -f "$file" ]; then
    cp "$file" "$dest"
  else
    echo "Warning: $file does not exist or is not a regular file/directory."
  fi
}

for file in "${files_to_sync[@]}"; do
  echo "Syncing $HOME/$file to $target_dir..."
  sync_file "$file" "$target_dir"
done

echo "Syncing completed!"

