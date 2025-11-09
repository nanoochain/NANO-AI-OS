# Makefile for Nexus AI OS Development Environment

# Default target
.PHONY: help build run shell stop clean init-aosp sync-aosp

help:
	@echo "Nexus AI OS Development Environment Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  build       - Build the Docker image"
	@echo "  run         - Start the development container"
	@echo "  shell       - Access the development environment shell"
	@echo "  stop        - Stop the development container"
	@echo "  clean       - Remove the Docker container"
	@echo "  init-aosp   - Initialize AOSP repository"
	@echo "  sync-aosp   - Sync AOSP source code"
	@echo "  help        - Show this help message"

build:
	docker-compose build

run:
	docker-compose up -d

shell:
	docker-compose exec nexus-ai-dev bash

stop:
	docker-compose stop

clean:
	docker-compose down

init-aosp:
	docker-compose exec nexus-ai-dev repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1

sync-aosp:
	docker-compose exec nexus-ai-dev repo sync -c -j$$(nproc) --force-sync --no-clone-bundle --no-tags

# Quick start - build, run, and initialize
quick-start: build run init-aosp
	@echo "Quick start complete. You can now access the shell with 'make shell'"