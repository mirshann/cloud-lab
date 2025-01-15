#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Set project directories
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ANSIBLE_DIR="$ROOT_DIR/ansible"
INVENTORY_FILE="$ANSIBLE_DIR/inventories/development/hosts.yml"

# Ensure the inventory file exists
if [ ! -f "$INVENTORY_FILE" ]; then
  echo "Error: Ansible inventory file not found at $INVENTORY_FILE"
  exit 1
fi

# Apply Ansible changes
echo "Running Ansible playbook to apply changes..."
cd "$ANSIBLE_DIR"
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
  -i "$INVENTORY_FILE" \
  playbooks/webserver.yml

echo "Ansible changes applied successfully!"
