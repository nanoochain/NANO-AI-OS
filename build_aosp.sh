#!/bin/bash

# Script to build AOSP for Nexus AI OS

echo "Building AOSP for Nexus AI OS..."

# Check if we're running inside the Docker container
if [ ! -d "/home/developer/nexus-ai-os" ]; then
    echo "This script should be run inside the Docker container."
    echo "Use: docker-compose exec nexus-ai-dev bash"
    echo "Then run this script from within the container."
    exit 1
fi

# Navigate to the project directory
cd /home/developer/nexus-ai-os

# Check if source code is synced
if [ ! -d "build" ]; then
    echo "Error: AOSP source code is not synced. Please run sync_aosp.sh first."
    exit 1
fi

# Set up the build environment
echo "Setting up build environment..."
source build/envsetup.sh

# Select build target
echo "Selecting build target..."
lunch aosp_arm64-userdebug

# Build AOSP
echo "Building AOSP (this will take a long time)..."
make -j$(nproc)

if [ $? -eq 0 ]; then
    echo "AOSP built successfully!"
    echo ""
    echo "Build outputs are located in out/target/product/generic_arm64/"
    echo "You can find system.img, vendor.img, boot.img, and other images there."
else
    echo "Failed to build AOSP. Please check the error messages above."
    exit 1
fi