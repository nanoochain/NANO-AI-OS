#!/bin/bash

# Demo script showing how to use the Docker environment for Nexus AI OS development

echo "========================================="
echo "Nexus AI OS Docker Environment Demo"
echo "========================================="

# Check prerequisites
echo "Checking prerequisites..."

if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed."
    echo "Please install Docker Desktop (https://www.docker.com/products/docker-desktop)"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Error: docker-compose is not installed."
    echo "Please install Docker Compose (usually included with Docker Desktop)"
    exit 1
fi

echo "✓ Docker and docker-compose are installed"

# Check if required files exist
if [ ! -f "Dockerfile" ] || [ ! -f "docker-compose.yml" ]; then
    echo "Error: Required Docker files not found in current directory."
    echo "Please run this script from the project root directory."
    exit 1
fi

echo "✓ Docker configuration files found"

# Build the Docker image
echo ""
echo "Building Docker image (this may take a few minutes)..."
docker-compose build

if [ $? -ne 0 ]; then
    echo "Error: Failed to build Docker image."
    exit 1
fi

echo "✓ Docker image built successfully"

# Start the container
echo ""
echo "Starting development container..."
docker-compose up -d

if [ $? -ne 0 ]; then
    echo "Error: Failed to start container."
    exit 1
fi

echo "✓ Container started successfully"

# Demonstrate basic usage
echo ""
echo "Demonstrating basic usage..."
echo "Running 'ls -la' in the container:"
docker-compose exec nexus-ai-dev ls -la

echo ""
echo "Checking Java version in container:"
docker-compose exec nexus-ai-dev java -version

echo ""
echo "Checking Python version in container:"
docker-compose exec nexus-ai-dev python3 --version

# Show next steps
echo ""
echo "========================================="
echo "Demo Complete!"
echo "========================================="
echo ""
echo "You can now:"
echo "1. Access the development environment:"
echo "   docker-compose exec nexus-ai-dev bash"
echo ""
echo "2. Initialize the AOSP repository:"
echo "   docker-compose exec nexus-ai-dev repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1"
echo ""
echo "3. Sync the AOSP source code (will take several hours):"
echo "   docker-compose exec nexus-ai-dev repo sync -c -j\$(nproc) --force-sync --no-clone-bundle --no-tags"
echo ""
echo "4. Stop the container when done:"
echo "   docker-compose stop"
echo ""
echo "For more information, see DOCKER_SUMMARY.md"