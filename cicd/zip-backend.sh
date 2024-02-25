#!/bin/bash

# check if in root folder if not change one folder up
if [ ! -f "pnpm-workspace.yaml" ]; then
  cd ..
fi

# Remove existing backend.zip
rm -rf backend.zip

# Define files to zip and exclude
# Yes, I'm aware that files_to_zip are not necessary, I could achieve the same with only files_to_exclude...
files_to_zip=(
    "./apps/backend/"
    "./shared/"
    "./pnpm-workspace.yaml"
    "./pnpm-lock.yaml"
    "package.json"
    "./cicd/"
)
files_to_exclude=(
    "*/node_modules/*"
    "*/.env"
    "*/.env.old"
)

# Check if files exist before zipping
for file in "${files_to_zip[@]}"; do
  if [ ! -e "$file" ]; then
    echo "File $file does not exist"
    exit 1
  fi
done

# Create exclude string
exclude_string=$(printf -- "-x %s " "${files_to_exclude[@]}")

# Create zip file
zip -r backend.zip "${files_to_zip[@]}" $exclude_string