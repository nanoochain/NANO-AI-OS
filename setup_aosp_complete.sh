#!/bin/bash

# Comprehensive script to set up AOSP for Nexus AI OS
# This script will initialize, sync, and build AOSP

echo "========================================="
echo "Nexus AI OS - AOSP Setup Script"
echo "========================================="

# Check if we're running inside the Docker container
if [ ! -d "/home/developer/nexus-ai-os" ]; then
    echo "This script should be run inside the Docker container."
    echo "Use: docker-compose exec nexus-ai-dev bash"
    echo "Then run this script from within the container."
    exit 1
fi

# Navigate to the project directory
cd /home/developer/nexus-ai-os

echo "Starting AOSP setup for Nexus AI OS..."
echo ""

# Step 1: Initialize repo
echo "Step 1: Initializing repo..."
if [ ! -d ".repo" ]; then
    repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to initialize repo."
        exit 1
    fi
    echo "Repo initialized successfully!"
else
    echo "Repo already initialized, skipping..."
fi

echo ""

# Step 2: Sync source code
echo "Step 2: Syncing AOSP source code..."
echo "This will take several hours. Please be patient."
repo sync -c -j$(nproc) --force-sync --no-clone-bundle --no-tags

if [ $? -ne 0 ]; then
    echo "Error: Failed to sync AOSP source code."
    exit 1
fi

echo "AOSP source code synced successfully!"
echo ""

# Step 3: Set up build environment
echo "Step 3: Setting up build environment..."
source build/envsetup.sh

if [ $? -ne 0 ]; then
    echo "Error: Failed to set up build environment."
    exit 1
fi

echo "Build environment set up successfully!"
echo ""

# Step 4: Select build target
echo "Step 4: Selecting build target..."
lunch aosp_arm64-userdebug

if [ $? -ne 0 ]; then
    echo "Error: Failed to select build target."
    exit 1
fi

echo "Build target selected successfully!"
echo ""

# Step 5: Build AOSP
echo "Step 5: Building AOSP..."
echo "This will take a long time. Please be patient."
make -j$(nproc)

if [ $? -ne 0 ]; then
    echo "Error: Failed to build AOSP."
    exit 1
fi

echo "AOSP built successfully!"
echo ""

# Summary
echo "========================================="
echo "AOSP Setup Complete!"
echo "========================================="
echo "Build outputs are located in out/target/product/generic_arm64/"
echo "You can find system.img, vendor.img, boot.img, and other images there."
echo ""
echo "Next steps:"
echo "1. Test the build in an emulator:"
echo "   emulator -avd <avd_name>"
echo ""
echo "2. Begin implementing Nexus AI OS features"
echo "   by modifying the AOSP source code according"
echo "   to the technical architecture document."