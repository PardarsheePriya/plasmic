#!/bin/bash

usage() {
    echo "Usage: $0 --repourl <repository_url> --reponame <repository_name> --branch <branch_name>"
    exit 1
}

# Log the input arguments
echo "REPO_URL: $1"
echo "REPO_NAME: $2"
echo "BRANCH: $3"

# The rest of your script...


# Function to check if required arguments are provided
check_required_arguments() {
    if [[ -z "$REPO_URL" || -z "$REPO_NAME" || -z "$BRANCH" ]]; then
        echo "Error: Missing required arguments."
        usage
    fi
}

# Parsing command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --repourl) REPO_URL="$2"; shift ;;
        --reponame) REPO_NAME="$2"; shift ;;
        --branch) BRANCH="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; usage ;;
    esac
    shift
done

# Check required arguments
check_required_arguments

echo "Updating system packages..."
sudo apt-get update -y

# Install Git if not already installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing..."
    sudo apt-get install -y git
fi

# Clone or update the repository
if [[ -d "/var/www/$REPO_NAME" ]]; then
    echo "Pulling latest changes from the $BRANCH branch..."
    cd "/var/www/$REPO_NAME" || exit
    git pull origin "$BRANCH"
else
    echo "Cloning repository from the $BRANCH branch..."
    git clone -b "$BRANCH" "$REPO_URL" "/var/www/$REPO_NAME"
    cd "/var/www/$REPO_NAME" || exit
fi

git config --global --add safe.directory "/var/www/$REPO_NAME"

echo "Cloning or updating the repository is complete!"
