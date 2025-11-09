# Nexus AI OS Development Environment Dockerfile
# Based on Ubuntu 22.04 LTS for AOSP development

FROM ubuntu:22.04

# Avoid warnings by setting noninteractive environment
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /nexus-ai-os

# Install essential packages
RUN apt-get update && apt-get install -y \
    git-core \
    gnupg \
    flex \
    bison \
    build-essential \
    zip \
    curl \
    zlib1g-dev \
    libc6-dev-i386 \
    libncurses5 \
    x11proto-core-dev \
    libx11-dev \
    lib32z1-dev \
    libgl1-mesa-dev \
    libxml2-utils \
    xsltproc \
    unzip \
    fontconfig \
    openjdk-11-jdk \
    python3 \
    python3-pip \
    python3-dev \
    gcc-multilib \
    g++-multilib \
    libc6-dev-i386 \
    lib32ncurses5-dev \
    lib32readline-dev \
    lib32z1-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages for ML
RUN pip3 install --upgrade pip \
    && pip3 install numpy scipy tensorflow onnx

# Install repo tool
RUN mkdir -p /usr/local/bin \
    && curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo \
    && chmod a+x /usr/local/bin/repo

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:/usr/local/bin

# Create non-root user
RUN useradd -m -s /bin/bash developer
USER developer
WORKDIR /home/developer

# Set up Android SDK directory
RUN mkdir -p /home/developer/nexus-ai-os

# Default command
CMD ["/bin/bash"]