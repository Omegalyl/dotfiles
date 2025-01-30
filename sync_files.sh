#!/bin/bash

# Files and directories to sync
files_to_sync=(".xinitrc" ".vimrc" "dwm" "bin")

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

rm_git() {
  local file=$1

  if [ -d "$file" ]; then
	echo "Removing .git from $file"
	find "$file" -type d -name ".git" -exec rm -rf {} +
  fi

}

for file in "${files_to_sync[@]}"; do
  echo "Syncing $HOME/$file to $target_dir..."
  sync_file "$file" "$target_dir"
  rm_git "$target_dir/$file"
done

echo "Syncing completed!"

