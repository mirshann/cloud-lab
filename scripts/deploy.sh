#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Set project directories
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_ENV_DIR="$ROOT_DIR/terraform/environments/development"
ANSIBLE_DIR="$ROOT_DIR/ansible"
INVENTORY_FILE="$ANSIBLE_DIR/inventories/development/hosts.yml"

# Step 1: Deploy Terraform Infrastructure
cd "$TERRAFORM_ENV_DIR"
echo "Initializing Terraform..."
terraform init -input=false

echo "Applying Terraform configuration..."
terraform apply -auto-approve -input=false

# Step 2: Fetch Terraform Outputs
echo "Fetching Terraform outputs..."
VM_IP=$(terraform output -raw public_ip)

# Step 3: Generate Ansible Inventory
echo "Generating Ansible inventory..."
cat > "$INVENTORY_FILE" <<EOF
all:
  children:
    web_servers:
      hosts:
        cloud-lab-vm:
          ansible_host: $VM_IP
          ansible_user: root
          ansible_ssh_private_key_file: "~/.ssh/id_rsa"
EOF

echo "Inventory file created at $INVENTORY_FILE"

# Step 4: Run Ansible Playbook
cd "$ANSIBLE_DIR"
echo "Running Ansible playbook to configure web server..."
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
  -i "$INVENTORY_FILE" \
  playbooks/webserver.yml

echo "Deployment completed successfully!"
