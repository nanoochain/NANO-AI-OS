#!/bin/bash

# Script to build Nexus AI OS within Docker container

echo "=================================="
echo "Nexus AI OS Docker Build Script"
echo "=================================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Error: docker-compose is not installed. Please install docker-compose first."
    exit 1
fi

# Build the Docker image
echo "Building Docker image..."
docker-compose build

if [ $? -ne 0 ]; then
    echo "Error: Failed to build Docker image."
    exit 1
fi

echo "Docker image built successfully."

# Start the container
echo "Starting development container..."
docker-compose up -d

if [ $? -ne 0 ]; then
    echo "Error: Failed to start container."
    exit 1
fi

echo "Container started successfully."

# Execute initialization commands in the container
echo "Initializing AOSP repository..."
docker-compose exec nexus-ai-dev repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1

if [ $? -ne 0 ]; then
    echo "Error: Failed to initialize AOSP repository."
    exit 1
fi

echo "AOSP repository initialized successfully."

echo ""
echo "=================================="
echo "Setup Complete!"
echo "=================================="
echo "You can now access the development environment with:"
echo "  docker-compose exec nexus-ai-dev bash"
echo ""
echo "To sync the AOSP source code (will take several hours):"
echo "  docker-compose exec nexus-ai-dev repo sync -c -j\$(nproc) --force-sync --no-clone-bundle --no-tags"
echo ""
echo "For more information, see the SETUP_GUIDE.md file."