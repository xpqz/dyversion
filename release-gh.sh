#!/bin/bash
# This version uses the GitHub cli-tool, gh

# Read the current version from current_version.txt
version=$(cat current_version.txt)

# Append the current date to the version
version=${version}-$(date +"%Y-%m-%d")

# Replace the placeholder in main.aplf with the version
sed -i.bak "s/{{VERSION}}/${version}/g" main.aplf

# Create a new git tag with the version
git tag ${version}

# Push the new tag to the repository
git push origin ${version}

# Create a new release using gh, and upload the project file as a release asset
gh release create "${version}" main.aplf -t "${version}" -n "Release ${version}"

# Put back the templated backup, as created by sed
mv main.aplf.bak main.aplf