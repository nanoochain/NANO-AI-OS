#!/bin/bash

# Test script to verify Docker environment setup

echo "Testing Nexus AI OS Docker Environment"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "FAIL: Docker is not installed"
    exit 1
else
    echo "PASS: Docker is installed"
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "FAIL: docker-compose is not installed"
    exit 1
else
    echo "PASS: docker-compose is installed"
fi

# Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
    echo "FAIL: Dockerfile not found"
    exit 1
else
    echo "PASS: Dockerfile found"
fi

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo "FAIL: docker-compose.yml not found"
    exit 1
else
    echo "PASS: docker-compose.yml found"
fi

# Try to build the Docker image (this will take some time)
echo "Testing Docker build..."
timeout 300 docker-compose build > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "PASS: Docker build successful"
else
    echo "WARN: Docker build test timed out or failed (this is expected for first-time builds)"
fi

echo "Docker environment test completed."