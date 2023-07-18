#!/bin/bash

# Read the current version from current_version.txt
version=$(cat current_version.txt)

# Append the current date to the version
version=${version}-$(date +"%Y-%m-%d")

# Create a new git tag with the version
git tag ${version}

# Replace the placeholder in main.aplf with the version
sed -i.bak "s/{{VERSION}}/${version}/g" main.aplf

# Push the new tag to the repository
git push origin ${version}

# Create JSON payload
json='{
"tag_name": "'"$version"'",
"name": "'"$version"'",
"body": "Release '"$version"'"
}'

# Create a new release
response=$(curl -H "Authorization: token ${GITHUB_TOKEN}" --data "$json" https://api.github.com/repos/xpqz/dyversion/releases)

echo "$response"

# Get upload_url from the response
upload_url=$(echo "$response" | /opt/homebrew/bin/jq -r .upload_url | sed -e "s/{?name,label}//")

# Upload the release
curl -XPOST -H "Authorization: token ${GITHUB_TOKEN}" -H "Content-Type: application/octet-stream" --data-binary "@main.aplf" "${upload_url}?name=main.aplf"

# Put back the templated backup, as created by sed
mv main.aplf.bak main.aplf
