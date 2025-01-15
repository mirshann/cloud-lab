#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Set project directories
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_ENV_DIR="$ROOT_DIR/terraform/environments/development"

# Navigate to Terraform environment directory
cd "$TERRAFORM_ENV_DIR"

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Apply Terraform changes
echo "Applying Terraform changes..."
terraform apply -auto-approve

echo "Terraform changes applied successfully!"
