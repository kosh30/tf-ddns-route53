#!/bin/bash
# Check if a parameter was provided
if [ -z "$1" ]; then
  # No parameter was provided, find all files with the "-decrypted" suffix
  files=$(find . -type f -name "*encrypted.*")
else
  # A parameter was provided, only encrypt that file
  files=$(echo -n "$1" | tr '\n' '\0')
fi

for file in $files; do
  # Get the base name of the file without extension and "-encrypted"
  base_name=$(basename "$file" | rev | cut -d. -f2- | rev | sed 's/encrypted//')
  # Get the directory name of the file
  dir_name=$(dirname "$file")
  # Define the new file name with "-decrypted" suffix
  new_file="${dir_name}/${base_name}decrypted.${file##*.}"
  # Get the file extension
  extension="${file##*.}"
  # Check the file extension and decrypt accordingly
  case "$extension" in
  yaml | yml)
    # Check if the file is a Kubernetes Secret or ConfigMap
    kind=$(grep -oP '(?<=kind: ).*' "$file")
    if [[ "$kind" == "Secret" || "$kind" == "ConfigMap" ]]; then
      echo "File '$file' is a Kubernetes $kind"
      sops --decrypt --input-type yaml --output-type yaml "$file" >"$new_file"
    fi
    # Decrypt YAML file with sops and save it to the new file
    sops --decrypt --input-type yaml --output-type yaml "$file" >"$new_file"
    ;;
  json)
    # Decrypt JSON file with sops and save it to the new file
    sops --decrypt --input-type json --output-type json "$file" >"$new_file"
    ;;
  *)
    # Default case: Decrypt file with sops and save it to the new file
    sops --decrypt "$file" >"$new_file"
    ;;
  esac
done
