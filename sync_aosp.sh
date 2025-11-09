#!/bin/bash

# Script to sync AOSP source code for Nexus AI OS

echo "Syncing AOSP source code for Nexus AI OS..."

# Check if we're running inside the Docker container
if [ ! -d "/home/developer/nexus-ai-os" ]; then
    echo "This script should be run inside the Docker container."
    echo "Use: docker-compose exec nexus-ai-dev bash"
    echo "Then run this script from within the container."
    exit 1
fi

# Navigate to the project directory
cd /home/developer/nexus-ai-os

# Check if repo is initialized
if [ ! -d ".repo" ]; then
    echo "Error: Repo is not initialized. Please run init_aosp.sh first."
    exit 1
fi

# Sync the source code
echo "Syncing AOSP source code (this will take several hours)..."
repo sync -c -j$(nproc) --force-sync --no-clone-bundle --no-tags

if [ $? -eq 0 ]; then
    echo "AOSP source code synced successfully!"
    echo ""
    echo "Next steps:"
    echo "1. Set up the build environment:"
    echo "   source build/envsetup.sh"
    echo ""
    echo "2. Select a build target:"
    echo "   lunch aosp_arm64-userdebug"
    echo ""
    echo "3. Build AOSP:"
    echo "   make -j$(nproc)"
else
    echo "Failed to sync AOSP source code. Please check your internet connection and try again."
    exit 1
fi