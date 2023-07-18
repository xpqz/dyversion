#!/bin/bash
VERSION=$(git describe --tags)
echo "version ← '${VERSION}'" > version.apla
