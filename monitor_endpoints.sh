#!/bin/bash

# Array of backend URLs
backend_urls=(
  "https://imf-gadgetapi.onrender.com"
)

# Add timestamp to log
echo "Starting endpoint check at $(date)"

# Loop through the array of URLs
for url in "${backend_urls[@]}"; do
  echo "Checking $url"
  response=$(curl -s -w "\n%{http_code}" "$url")
  http_code=$(echo "$response" | tail -n1)
  body=$(echo "$response" | sed '$d')
  
  if [ "$http_code" -eq 200 ]; then
    echo "✅ Success: $url"
  else
    echo "❌ Failed: $url (Status: $http_code)"
  fi
done

echo "Endpoint check completed at $(date)"
