# Nexus AI OS Docker Environment Setup Script for Windows

Write-Host "=========================================" -ForegroundColor Green
Write-Host "Nexus AI OS Docker Environment Setup" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

# Check if Docker is installed
try {
    $dockerVersion = docker --version
    Write-Host "Docker is installed: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Docker is not installed. Please install Docker Desktop for Windows first." -ForegroundColor Red
    exit 1
}

# Check if docker-compose is installed
try {
    $composeVersion = docker-compose --version
    Write-Host "Docker Compose is installed: $composeVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: docker-compose is not installed. Please install Docker Desktop which includes docker-compose." -ForegroundColor Red
    exit 1
}

Write-Host "Building Docker image for Nexus AI OS development..." -ForegroundColor Yellow
docker-compose build

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to build Docker image." -ForegroundColor Red
    exit 1
}

Write-Host "Docker image built successfully." -ForegroundColor Green

Write-Host "Starting development container..." -ForegroundColor Yellow
docker-compose up -d

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to start container." -ForegroundColor Red
    exit 1
}

Write-Host "Container started successfully." -ForegroundColor Green

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
Write-Host "You can now access the development environment with:" -ForegroundColor Cyan
Write-Host "  docker-compose exec nexus-ai-dev bash" -ForegroundColor White
Write-Host ""
Write-Host "To initialize the AOSP repository:" -ForegroundColor Cyan
Write-Host "  docker-compose exec nexus-ai-dev repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1" -ForegroundColor White
Write-Host ""
Write-Host "To sync the AOSP source code (will take several hours):" -ForegroundColor Cyan
Write-Host "  docker-compose exec nexus-ai-dev repo sync -c -j`$(nproc) --force-sync --no-clone-bundle --no-tags" -ForegroundColor White
Write-Host ""
Write-Host "For more information, see the SETUP_GUIDE.md file." -ForegroundColor Cyan