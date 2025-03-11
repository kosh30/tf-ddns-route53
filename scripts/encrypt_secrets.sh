#!/bin/bash
# Check if a parameter was provided
if [ -z "$1" ]; then
  # No parameter was provided, find all files with the "-decrypted" suffix
  files=$(find . -type f -name "*decrypted.*")
else
  # A parameter was provided, only encrypt that file
  files=$(echo -n "$1" | tr '\n' '\0')
fi

for file in $files; do
  echo "Encrypting file '$file'"
  # Get the base name of the file without extension
  base_name=$(basename "$file" | rev | cut -d. -f2- | rev | sed 's/decrypted//')
  # Get the directory name of the file
  dir_name=$(dirname "$file")
  # Define the new file name with "-encrypted" suffix
  new_file="${dir_name}/${base_name}encrypted.${file##*.}"
  # Get the file extension
  extension="${file##*.}"
  # Check the file extension and encrypt accordingly
  case "$extension" in
  yaml | yml)
    # Check if the file is a Kubernetes Secret or ConfigMap
    kind=$(grep -oP '(?<=kind: ).*' "$file")
    if [[ "$kind" == "Secret" || "$kind" == "ConfigMap" ]]; then
      echo "File '$file' is a Kubernetes $kind"
      sops --config .sops.yaml --encrypt --input-type yaml --output-type yaml --encrypted-regex '^(data|stringData)$' "$file" > "$new_file"
    fi
    # Encrypt YAML file with sops and save it to the new file
    sops --encrypt --age "$age_key" --input-type yaml --output-type yaml "$file" >"$new_file"
    ;;
  json)
    # Encrypt JSON file with sops and save it to the new file
    sops --encrypt --age "$age_key" --input-type json --output-type json "$file" >"$new_file"
    ;;
  *)
    # Default case: Encrypt file with sops and save it to the new file
    sops --encrypt --age "$age_key" "$file" >"$new_file"
    ;;
  esac
done
