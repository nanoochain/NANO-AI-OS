#!/bin/bash

# Script to initialize AOSP repository for Nexus AI OS

echo "Initializing AOSP repository for Nexus AI OS..."

# Check if we're running inside the Docker container
if [ ! -d "/home/developer/nexus-ai-os" ]; then
    echo "This script should be run inside the Docker container."
    echo "Use: docker-compose exec nexus-ai-dev bash"
    echo "Then run this script from within the container."
    exit 1
fi

# Navigate to the project directory
cd /home/developer/nexus-ai-os

# Initialize repo with Android 14
echo "Initializing repo with Android 14..."
repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1

if [ $? -eq 0 ]; then
    echo "Repo initialized successfully!"
    echo ""
    echo "Next steps:"
    echo "1. Sync the source code (this will take several hours):"
    echo "   repo sync -c -j\$(nproc) --force-sync --no-clone-bundle --no-tags"
    echo ""
    echo "2. After syncing, you can build AOSP:"
    echo "   source build/envsetup.sh"
    echo "   lunch aosp_arm64-userdebug"
    echo "   make -j\$(nproc)"
else
    echo "Failed to initialize repo. Please check your internet connection and try again."
    exit 1
fi