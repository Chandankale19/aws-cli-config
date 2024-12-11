#!/bin/bash

# Error handling function
error_exit() {
    echo "ERROR: $1"
    exit 1
}

# Step 1: Check if the script is run as root or with sudo
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        error_exit "This script must be run as root or with sudo privileges."
    fi
}

# Step 2: Check internet connection
check_internet() {
    echo "Checking internet connection..."
    if ! ping -c 1 google.com &>/dev/null; then
        error_exit "No internet connection. Please check your network settings."
    fi
}

# Step 3: Update system package list (based on package manager)
update_system() {
    echo "Updating system package list..."
    
    if command -v apt-get &>/dev/null; then
        apt-get update &>/dev/null || error_exit "Failed to update package list with apt-get."
    elif command -v yum &>/dev/null; then
        yum update -y &>/dev/null || error_exit "Failed to update package list with yum."
    elif command -v dnf &>/dev/null; then
        dnf update -y &>/dev/null || error_exit "Failed to update package list with dnf."
    elif command -v zypper &>/dev/null; then
        zypper refresh &>/dev/null || error_exit "Failed to update package list with zypper."
    else
        error_exit "Unsupported package manager. Please install curl and unzip manually."
    fi
}

# Step 4: Install necessary dependencies (curl, unzip)
install_dependencies() {
    echo "Installing dependencies (curl, unzip)..."
    
    if command -v apt-get &>/dev/null; then
        apt-get install -y curl unzip &>/dev/null || error_exit "Failed to install dependencies (curl, unzip) with apt-get."
    elif command -v yum &>/dev/null; then
        yum install -y curl unzip &>/dev/null || error_exit "Failed to install dependencies (curl, unzip) with yum."
    elif command -v dnf &>/dev/null; then
        dnf install -y curl unzip &>/dev/null || error_exit "Failed to install dependencies (curl, unzip) with dnf."
    elif command -v zypper &>/dev/null; then
        zypper install -y curl unzip &>/dev/null || error_exit "Failed to install dependencies (curl, unzip) with zypper."
    else
        error_exit "Unsupported package manager. Please install curl and unzip manually."
    fi
}

# Step 5: Check if AWS CLI is installed
check_aws_cli_installed() {
    if command -v aws &>/dev/null; then
        echo "AWS CLI is already installed."
        return 0
    else
        echo "AWS CLI is not installed."
        return 1
    fi
}

# Step 6: Install the latest version of AWS CLI
install_aws_cli() {
    echo "Downloading the latest AWS CLI installer..."
    if ! curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &>/dev/null; then
        error_exit "Failed to download AWS CLI installer."
    fi

    echo "Extracting AWS CLI installer..."
    if ! unzip awscliv2.zip &>/dev/null; then
        error_exit "Failed to extract AWS CLI installer."
    fi

    echo "Installing AWS CLI..."
    if ! sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli &>/dev/null; then
        error_exit "Failed to install AWS CLI."
    fi

    # Clean up installer files
    echo "Cleaning up installation files..."
    rm -rf aws awscliv2.zip

    echo "AWS CLI installation successful."
}

# Step 7: Update the existing AWS CLI installation
update_aws_cli() {
    echo "Updating AWS CLI to the latest version..."
    if ! curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &>/dev/null; then
        error_exit "Failed to download AWS CLI installer."
    fi

    echo "Extracting AWS CLI installer..."
    if ! unzip awscliv2.zip &>/dev/null; then
        error_exit "Failed to extract AWS CLI installer."
    fi

    echo "Updating AWS CLI..."
    if ! sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update &>/dev/null; then
        error_exit "Failed to update AWS CLI."
    fi

    # Clean up installer files
    echo "Cleaning up installation files..."
    rm -rf aws awscliv2.zip

    echo "AWS CLI update successful."
}

# Step 8: Verify AWS CLI installation
verify_aws_cli() {
    echo "Verifying AWS CLI installation..."
    if ! aws --version &>/dev/null; then
        error_exit "AWS CLI installation failed. Please check the installation steps."
    fi
}

# Step 9: Configure AWS CLI
configure_aws_cli() {
    echo "Configuring AWS CLI..."
    aws configure
}

# Step 10: Check AWS CLI status and decide whether to install or update
install_or_update_aws_cli() {
    check_aws_cli_installed
    if [ $? -eq 1 ]; then
        install_aws_cli
    else
        update_aws_cli
    fi
}

# Main function to execute the steps
main() {
    check_root
    check_internet
    update_system
    install_dependencies
    install_or_update_aws_cli
    verify_aws_cli
    configure_aws_cli
}

# Execute the main function
main

