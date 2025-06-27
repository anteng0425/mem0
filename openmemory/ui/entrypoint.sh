#!/bin/sh
set -e

# Ensure the working directory is correct
cd /app



# Replace env variable placeholders with real values
printenv | grep NEXT_PUBLIC_ | while IFS='=' read -r key value ; do
  esc_value=$(printf '%s' "$value" | sed -e 's/[\&|]/\\&/g')
  find .next/ -type f -exec sed -i "s|$key|$esc_value|g" {} \;
done
echo "Done replacing env variables NEXT_PUBLIC_ with real values"


# Execute the container's main process (CMD in Dockerfile)
exec "$@"
