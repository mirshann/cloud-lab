#!/bin/bash

# Ensure Terraform CLI is available
if ! command -v terraform &>/dev/null; then
  echo "Error: Terraform CLI is not installed."
  exit 1
fi

# Navigate to Terraform environment
cd terraform/environments/development || {
  echo "Error: Terraform environment not found."
  exit 1
}

# Extract Terraform outputs
echo "Fetching Terraform outputs..."
terraform_output=$(terraform output -json)

if [ -z "$terraform_output" ]; then
  echo "Error: Terraform outputs are empty. Run 'terraform apply' first."
  exit 1
fi

# Parse resource details from Terraform outputs
vm_size=$(echo "$terraform_output" | jq -r '.vm_size.value')
num_vms=$(echo "$terraform_output" | jq -r '.num_vms.value // 1')
lb_count=$(echo "$terraform_output" | jq -r '.lb_count.value // 1')

# Pricing details (Update these values as per DigitalOcean's pricing)
vm_cost_per_month=5      # Cost for s-1vcpu-1gb (smallest droplet)
lb_cost_per_month=10     # Cost for a load balancer

# Calculate costs
vm_cost=$(echo "$vm_cost_per_month * $num_vms" | bc)
lb_cost=$(echo "$lb_cost_per_month * $lb_count" | bc)
total_cost=$(echo "$vm_cost + $lb_cost" | bc)

# Output the budget summary
echo "========== Budget Summary =========="
echo "Droplet size: $vm_size"
echo "Number of VMs: $num_vms"
echo "Load Balancers: $lb_count"
echo "-----------------------------------"
echo "Cost for VMs: \$$vm_cost"
echo "Cost for Load Balancers: \$$lb_cost"
echo "-----------------------------------"
echo "Estimated Total Monthly Cost: \$$total_cost"
echo "===================================="

# Warn if the total cost exceeds $100
if (( $(echo "$total_cost > 100" | bc -l) )); then
  echo "Warning: Estimated cost exceeds \$100/month!"
fi