#!/bin/bash

# Ensure DigitalOcean API token is set
if [ -z "$TF_VAR_do_token" ]; then
  echo "Error: TF_VAR_do_token environment variable is not set."
  exit 1
fi

cd terraform/environments/development
terraform init
# terraform plan
terraform apply -auto-approve
