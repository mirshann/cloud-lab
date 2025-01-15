
```
cloud-lab/
├── ansible/                     # Ansible configuration management
│   ├── inventories/             # Inventory files for managing hosts
│   │   ├── development/         # Inventory for development environment
│   │   │   ├── hosts.yml        # Define hosts and groups
│   │   │   ├── group_vars/      # Variables for groups
│   │   │   └── host_vars/       # Variables for specific hosts
│   └── playbooks/               # Ansible playbooks
│       ├── site.yml             # Main playbook
│       ├── roles/               # Roles for reusable configurations
│       │   ├── common/          # Common setup for all VMs
│       │   │   ├── tasks/       # Tasks to execute
│       │   │   ├── handlers/    # Handlers for services
│       │   │   └── templates/   # Jinja2 templates
│       │   └── webserver/       # Role for web servers
│       │       ├── tasks/
│       │       └── templates/
├── terraform/                   # Terraform infrastructure management
│   ├── modules/                 # Custom Terraform modules
│   │   ├── compute/             # Module for virtual machines
│   │   │   ├── main.tf          # Resource definitions
│   │   │   ├── outputs.tf       # Outputs for module
│   │   │   ├── variables.tf     # Inputs for module
│   │   │   └── providers.tf     # Cloud provider configuration
│   │   ├── network/             # Module for networking
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── variables.tf
│   │   │   └── providers.tf
│   │   └── dns/                 # Module for DNS configuration
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── variables.tf
│   │       └── providers.tf
│   ├── environments/            # Environment-specific configurations
│   │   ├── development/         # Development environment
│   │   │   ├── main.tf          # Environment entrypoint
│   │   │   ├── variables.tf     # Variables specific to this environment
│   │   │   ├── terraform.tfvars # Values for variables
│   │   │   └── outputs.tf       # Outputs for this environment
│   │   └── production/          # Production environment
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       ├── terraform.tfvars
│   │       └── outputs.tf
├── scripts/                     # Helper scripts
│   ├── deploy.sh                # Script to deploy the entire environment
│   ├── destroy.sh               # Script to tear down the environment
│   └── budget-check.sh          # Script to estimate costs
├── README.md                    # Documentation
├── .gitignore                   # Git ignore file
└── LICENSE                      # Project license
```