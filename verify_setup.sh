#!/bin/bash

# Script to verify the Nexus AI OS setup

echo "Verifying Nexus AI OS setup..."

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
    echo "Warning: Repo is not initialized."
else
    echo "✓ Repo is initialized"
fi

# Check if source code is synced
if [ ! -d "build" ]; then
    echo "Warning: AOSP source code is not synced."
else
    echo "✓ AOSP source code is synced"
fi

# Check for our custom files
if [ -d "vendor/nexusai" ]; then
    echo "✓ Nexus AI OS vendor directory exists"
else
    echo "Warning: Nexus AI OS vendor directory not found"
fi

# Check for AI Manager service
if [ -f "vendor/nexusai/services/AIManagerService/src/com/android/server/ai/AIManagerService.java" ]; then
    echo "✓ AI Manager Service source file exists"
else
    echo "Warning: AI Manager Service source file not found"
fi

# Check for test application
if [ -f "vendor/nexusai/apps/AITestApp/src/com/nexusai/testapp/MainActivity.java" ]; then
    echo "✓ AI Test Application source file exists"
else
    echo "Warning: AI Test Application source file not found"
fi

echo ""
echo "Verification complete."