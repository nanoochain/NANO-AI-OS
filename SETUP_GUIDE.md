# Nexus AI OS Development Environment Setup Guide

## Overview
This guide provides step-by-step instructions for setting up a development environment for Nexus AI OS, an AI-powered mobile operating system built on Android Open Source Project (AOSP).

## Prerequisites

### Hardware Requirements
```yaml
Minimum:
  CPU: 8-core x86_64 processor
  RAM: 16GB
  Storage: 300GB SSD
  Internet: Stable high-speed connection

Recommended:
  CPU: 16-core x86_64 processor (Ryzen 9/Core i9)
  RAM: 32GB
  Storage: 500GB NVMe SSD
  Internet: Gigabit connection
```

### Operating System
- Ubuntu 22.04 LTS (Recommended)
- Minimum: Ubuntu 20.04 LTS
- Kernel: 5.15+

## Step-by-Step Setup

### Step 1: Install Base Dependencies

Create a setup script:
```bash
#!/bin/bash
# setup_base.sh - Base dependency installation

# Update system
sudo apt-get update && sudo apt-get upgrade -y

# Install essential build tools
sudo apt-get install -y \
    git-core gnupg flex bison build-essential zip curl \
    zlib1g-dev libc6-dev-i386 libncurses5 x11proto-core-dev \
    libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils \
    xsltproc unzip fontconfig

# Install additional dependencies
sudo apt-get install -y \
    openjdk-11-jdk python3 python3-pip python3-dev \
    gcc-multilib g++-multilib libc6-dev-i386 \
    lib32ncurses5-dev lib32readline-dev lib32z1-dev

# Install Python packages for ML
pip3 install --upgrade pip
pip3 install numpy scipy tensorflow onnx

# Install repo tool
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH

# Add to .bashrc
echo 'export PATH=~/bin:$PATH' >> ~/.bashrc
```

### Step 2: Configure Git

```bash
# Configure git for AOSP
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Optimize git for large repos
git config --global core.compression 0
git config --global pack.threads 8
git config --global http.postBuffer 524288000
```

### Step 3: Download AOSP Source

```bash
#!/bin/bash
# download_aosp.sh - Download AOSP source code

# Create workspace
mkdir -p ~/nexus-ai-os
cd ~/nexus-ai-os

# Initialize repo (Android 14)
repo init -u https://android.googlesource.com/platform/manifest \
    -b android-14.0.0_r1 \
    --depth=1

# Sync source (this will take hours)
# Use -j for parallel downloads (adjust based on CPU cores)
repo sync -c -j$(nproc) --force-sync --no-clone-bundle --no-tags

# Expected download size: ~100GB
# Expected time: 2-6 hours depending on connection
```

### Step 4: Set Up Build Environment

```bash
#!/bin/bash
# setup_build.sh - Initialize build environment

cd ~/nexus-ai-os

# Load environment
source build/envsetup.sh

# List available lunch targets
lunch

# Select target (example for Pixel 8)
lunch aosp_husky-userdebug

# For generic system image (GSI)
lunch aosp_arm64-userdebug
```

### Step 5: Install AI/ML Dependencies

```bash
#!/bin/bash
# setup_ml.sh - Install ML frameworks

# TensorFlow Lite
cd ~/nexus-ai-os/external
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout v2.14.0

# Build TFLite
bazel build -c opt //tensorflow/lite:libtensorflowlite.so

# ONNX Runtime
cd ~/nexus-ai-os/external
git clone https://github.com/microsoft/onnxruntime.git
cd onnxruntime
./build.sh --config Release --build_shared_lib --parallel

# MediaPipe
cd ~/nexus-ai-os/external
git clone https://github.com/google/mediapipe.git
cd mediapipe
bazel build -c opt --define MEDIAPIPE_DISABLE_GPU=1 mediapipe/examples/android
```

## Directory Structure

After setup, your project structure should look like:

```
nexus-ai-os/
├── art/                    # Android Runtime (ART)
├── bionic/                 # C library, math library, dynamic linker
├── bootable/               # Boot and recovery
├── build/                  # Build system
├── cts/                    # Compatibility Test Suite
├── dalvik/                 # Dalvik VM (deprecated but still present)
├── development/            # Development tools
├── device/                 # Device-specific configurations
│   ├── google/
│   │   ├── pixel/          # Pixel devices
├── external/               # External projects
│   ├── tensorflow/         # TensorFlow (our addition)
│   ├── onnxruntime/        # ONNX Runtime (our addition)
│   └── mediapipe/          # MediaPipe (our addition)
├── frameworks/             # Android frameworks
│   ├── base/              # Core framework
│   │   ├── core/
│   │   │   ├── java/
│   │   │   │   └── android/
│   │   │   │       └── ai/          # Our AI APIs (NEW)
│   │   │   └── jni/
│   │   │       └── ai/              # Native AI code (NEW)
│   │   ├── services/
│   │   │   └── core/
│   │   │       └── java/
│   │   │           └── com/
│   │   │               └── android/
│   │   │                   └── server/
│   │   │                       └── ai/  # AI System Services (NEW)
│   │   └── packages/
│   │       └── AILauncher/          # Our AI Launcher (NEW)
├── hardware/              # Hardware interfaces
│   └── interfaces/
│       └── ai/            # AI HAL interfaces (NEW)
├── kernel/                # Linux kernel
│   └── common/
│       ├── drivers/
│       │   └── ai/        # Custom AI drivers (NEW)
│       └── sched/
│           └── ai/        # AI task scheduler (NEW)
├── packages/              # Stock Android apps
│   └── apps/
│       └── AILauncher/    # Our launcher app (NEW)
├── prebuilts/             # Prebuilt binaries
├── system/                # Core system components
│   ├── core/
│   ├── netd/
│   └── sepolicy/          # SELinux policies
│       └── private/
│           └── ai/        # AI service policies (NEW)
├── toolchain/             # Build toolchain
└── vendor/                # Vendor-specific code
    └── nexusai/           # Our vendor additions (NEW)
        ├── models/        # Pre-trained models
        ├── config/        # Device configurations
        └── apps/          # Vendor apps
```

## Build Commands

### Full Build
```bash
# Set up environment
cd ~/nexus-ai-os
source build/envsetup.sh

# Select target
lunch aosp_husky-userdebug

# Clean build (first time or after major changes)
make clobber

# Build everything
make -j$(nproc)

# Expected time: 2-4 hours on 16-core system
```

### Incremental Build
```bash
# Build only changed modules
make -j$(nproc)

# Build specific module
make libnexusai -j$(nproc)
make AILauncher -j$(nproc)
make framework-ai -j$(nproc)
```

### Module-Specific Build
```bash
# Build and install specific app
mmm packages/apps/AILauncher
adb install -r out/target/product/husky/system/app/AILauncher/AILauncher.apk

# Build native library
mmm vendor/nexusai/frameworks/native
adb push out/target/product/husky/vendor/lib64/libnexusai.so /vendor/lib64/
```

## Testing

### Unit Tests
```bash
# Run framework tests
atest framework-ai

# Run specific test class
atest AIManagerTest
```

### Integration Tests
```bash
# Run integration tests
atest integration-tests
```

## Development Workflow

1. **Sync with upstream**
   ```bash
   repo sync -c
   ```

2. **Create feature branch**
   ```bash
   repo start feature-branch-name ./
   ```

3. **Make changes**

4. **Build and test**
   ```bash
   make -j$(nproc)
   ```

5. **Commit changes**
   ```bash
   git add .
   git commit -m "Description of changes"
   ```

6. **Push for review**
   ```bash
   repo upload
   ```

## Troubleshooting

### Common Issues

1. **Insufficient memory during build**
   - Increase swap space
   - Reduce parallel jobs: `make -j8` instead of `make -j$(nproc)`

2. **Repo sync failures**
   ```bash
   repo sync -c --force-sync
   ```

3. **Missing dependencies**
   ```bash
   sudo apt-get install -f
   ```

4. **Java version issues**
   ```bash
   sudo update-alternatives --config java
   # Select OpenJDK 11
   ```

## Next Steps

1. Complete the environment setup as described above
2. Verify AOSP builds correctly
3. Begin implementing Phase 0: Foundation components
4. Set up CI/CD pipeline
5. Start core team development

## Useful Resources

- [AOSP Building Guide](https://source.android.com/setup/build)
- [TensorFlow Lite Documentation](https://www.tensorflow.org/lite)
- [ONNX Runtime Documentation](https://onnxruntime.ai/docs/)
- [MediaPipe Documentation](https://google.github.io/mediapipe/)