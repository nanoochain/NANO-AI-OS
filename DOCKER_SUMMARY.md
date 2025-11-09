# Docker Environment for Nexus AI OS

## Overview
This document describes the Docker environment setup for developing Nexus AI OS. The Docker environment provides a consistent and isolated development environment for building the AI-powered mobile operating system.

## Files Created

### 1. Dockerfile
- **Purpose:** Defines the Docker image for the development environment
- **Base Image:** Ubuntu 22.04 LTS
- **Includes:** All necessary tools for AOSP development including Java, Python, Git, and build tools
- **Location:** `./Dockerfile`

### 2. docker-compose.yml
- **Purpose:** Defines the Docker services and volumes for the development environment
- **Service:** `nexus-ai-dev` - The main development container
- **Features:** Volume mounting for project files, environment variables, privileged mode for AOSP builds
- **Location:** `./docker-compose.yml`

### 3. setup_docker_env.ps1
- **Purpose:** PowerShell script to set up the Docker environment on Windows
- **Features:** Checks for Docker installation, builds images, starts containers
- **Location:** `./setup_docker_env.ps1`

### 4. build_in_docker.sh
- **Purpose:** Bash script to build and initialize the Docker environment on Linux/macOS
- **Features:** Builds Docker image, starts container, initializes AOSP repository
- **Location:** `./build_in_docker.sh`

### 5. test_docker_env.sh
- **Purpose:** Simple test script to verify Docker environment setup
- **Features:** Checks for Docker installation, verifies required files exist
- **Location:** `./test_docker_env.sh`

### 6. Makefile
- **Purpose:** Provides convenient commands for managing the Docker environment
- **Targets:** build, run, shell, stop, clean, init-aosp, sync-aosp, quick-start
- **Location:** `./Makefile`

## Usage

### Quick Start
```bash
# Using Makefile (Linux/macOS)
make quick-start
make shell

# Using PowerShell (Windows)
.\setup_docker_env.ps1
docker-compose exec nexus-ai-dev bash
```

### Detailed Usage
1. **Build the Docker image:**
   ```bash
   docker-compose build
   ```

2. **Start the development container:**
   ```bash
   docker-compose up -d
   ```

3. **Access the development environment:**
   ```bash
   docker-compose exec nexus-ai-dev bash
   ```

4. **Initialize AOSP repository:**
   ```bash
   docker-compose exec nexus-ai-dev repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1
   ```

5. **Sync AOSP source code:**
   ```bash
   docker-compose exec nexus-ai-dev repo sync -c -j$(nproc) --force-sync --no-clone-bundle --no-tags
   ```

## Benefits

1. **Consistency:** Ensures all developers have the same environment
2. **Isolation:** Prevents conflicts with host system dependencies
3. **Portability:** Works on Windows, macOS, and Linux
4. **Reproducibility:** Easy to recreate the exact development environment
5. **Simplicity:** One-command setup for new developers

## Requirements

1. **Docker Desktop** (Windows/macOS) or **Docker Engine** (Linux)
2. **docker-compose** (usually included with Docker Desktop)
3. **At least 100GB free disk space** for AOSP source code
4. **16GB+ RAM** recommended for building AOSP

## Troubleshooting

### Common Issues

1. **Insufficient disk space:**
   - Ensure at least 100GB free space
   - Use `docker system prune` to clean up unused Docker data

2. **Permission errors:**
   - On Linux, ensure your user is in the docker group
   - Run commands with `sudo` if necessary

3. **Build failures:**
   - Check internet connectivity
   - Ensure sufficient system resources (RAM, CPU)

4. **Container access issues:**
   - Verify container is running: `docker-compose ps`
   - Check logs: `docker-compose logs nexus-ai-dev`

## Next Steps

1. Run the setup script for your platform
2. Access the development environment
3. Initialize and sync the AOSP repository
4. Begin development work as outlined in the technical architecture