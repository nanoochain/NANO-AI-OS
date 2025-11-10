#!/bin/bash

# NANO AI OS Project Rules Management Script

echo "NANO AI OS Project Rules Management"
echo "==================================="

# Function to display project rules summary
function show_rules_summary() {
    echo ""
    echo "Project Rules Summary:"
    echo "1. Technical Rules - Code structure, build system, testing, security"
    echo "2. Organizational Rules - Team structure, communication, release process"
    echo "3. Documentation Standards - Code and project documentation requirements"
    echo "4. Compliance - License, patent, and export compliance"
    echo ""
}

# Function to check for rule violations
function check_rules() {
    echo "Checking for common rule violations..."
    
    # Check if required files exist
    required_files=("CONTRIBUTING.md" "CODE_OF_CONDUCT.md" "PROJECT_RULES.md" "README.md")
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "WARNING: Required file $file is missing"
        fi
    done
    
    # Check for proper directory structure
    required_dirs=("device/nexusai" "vendor/nexusai" "frameworks" "services" "apps")
    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            echo "WARNING: Required directory $dir is missing"
        fi
    done
    
    echo "Rule check completed."
}

# Function to display detailed rules
function show_detailed_rules() {
    echo ""
    echo "Detailed Project Rules:"
    echo "======================"
    
    if [ -f "PROJECT_RULES.md" ]; then
        # Display a summary of key points from PROJECT_RULES.md
        echo "Key Technical Rules:"
        echo "- All custom AI components must be placed in vendor/nexusai/"
        echo "- Device-specific configurations must be placed in device/nexusai/"
        echo "- All AI services must implement AIDL interfaces"
        echo "- Use Android.bp files for build configuration"
        echo "- All new code must include unit tests"
        echo ""
        
        echo "Key Organizational Rules:"
        echo "- Follow semantic versioning for releases"
        echo "- Document important decisions in ADRs"
        echo "- Weekly team sync meetings"
        echo "- Major releases every 6 months"
        echo ""
    else
        echo "PROJECT_RULES.md not found. Please create it."
    fi
}

# Main menu
while true; do
    echo ""
    echo "Select an option:"
    echo "1. Show project rules summary"
    echo "2. Check for rule violations"
    echo "3. Show detailed rules"
    echo "4. Exit"
    
    read -p "Enter your choice (1-4): " choice
    
    case $choice in
        1)
            show_rules_summary
            ;;
        2)
            check_rules
            ;;
        3)
            show_detailed_rules
            ;;
        4)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1-4."
            ;;
    esac
done