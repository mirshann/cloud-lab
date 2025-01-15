#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Set project directories
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_ENV_DIR="$ROOT_DIR/terraform/environments/development"
ANSIBLE_INVENTORY="$ROOT_DIR/ansible/inventories/development/hosts.yml"

# Step 1: Destroy Terraform Infrastructure
cd "$TERRAFORM_ENV_DIR"
echo "Destroying Terraform-managed infrastructure..."
terraform destroy -auto-approve

# Step 2: Clean Up Ansible Inventory
if [ -f "$ANSIBLE_INVENTORY" ]; then
  echo "Cleaning up Ansible inventory: $ANSIBLE_INVENTORY"
  rm -f "$ANSIBLE_INVENTORY"
else
  echo "Ansible inventory not found, no cleanup needed."
fi

echo "Teardown completed successfully!"
