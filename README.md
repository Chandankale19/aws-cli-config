# Install or Update AWS CLI Script

This repository provides a **production-grade Bash script** to install or update the AWS CLI on any Linux distribution. The script supports Debian-based, Red Hat-based, and SUSE-based Linux distros, ensuring compatibility with various environments.

## Features

- **Automatic Detection of Installed AWS CLI**: Checks if AWS CLI is already installed.
- **Seamless Update or Installation**: Installs AWS CLI if not installed or updates it to the latest version.
- **Multi-Distro Support**: Works with:
  - Debian-based distributions (e.g., Ubuntu, Debian)
  - Red Hat-based distributions (e.g., RHEL, CentOS, Fedora)
  - SUSE-based distributions (e.g., openSUSE)
- **Dependency Management**: Automatically installs `curl` and `unzip` if missing.
- **Error Handling**: Includes robust error handling for every step.
- **Interactive AWS CLI Configuration**: Guides you through configuring AWS CLI after installation or update.

## Prerequisites

1. **Root Privileges**: The script must be executed with `sudo` or as the root user.
2. **Internet Connection**: Required to download the AWS CLI installer and dependencies.
3. **AWS Credentials**: You need an **AWS Access Key ID** and **Secret Access Key** for configuration. The script will guide you through setting these details interactively.  
   Example configuration values:  
   ```plaintext
   AWS Access Key ID [None]: 
   AWS Secret Access Key [None]: 
   Default region name [None]: 
   Default output format [None]: 

## Usage

To install or update AWS CLI using this script, follow these steps:

1. Clone the repository or download the script directly:

   ```bash
   git clone https://github.com/your-repo/aws-cli-installer.git
   cd aws-cli-installer

2. Make the script executable:

   ```bash
   chmod +x install_or_update_aws_cli.sh

3. Run the script with sudo:

   ```bash
   sudo ./install_or_update_aws_cli.sh
