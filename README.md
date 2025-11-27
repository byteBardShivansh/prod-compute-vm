# prod-compute-vm

Infrastructure-as-Code (IaC) for provisioning a production-grade compute virtual machine using Terraform.

This repository contains Terraform configuration files (main.tf, variables.tf, outputs.tf, backend.tf) to deploy a compute VM and its associated resources. The exact provider(s) and resources are defined in main.tf; variables are exposed in variables.tf and outputs in outputs.tf.


## Repository layout
- backend.tf: Remote/backend state configuration for Terraform state management.
- main.tf: Root module with providers and resources to create the compute VM and dependencies.
- variables.tf: Input variables with types, descriptions, and defaults (if any).
- outputs.tf: Useful outputs after apply, such as VM IDs, IP addresses, or connection info.


## Prerequisites
- Terraform CLI installed (v1.3+ recommended)
- Access/credentials for the target cloud provider(s) configured in your environment (see main.tf for provider blocks)
- Remote state backend prerequisites, if backend.tf configures a remote backend (e.g., storage bucket, resource group, etc.)


## Getting started
1. Clone this repository
2. Review backend.tf and ensure the backend exists and is correctly configured
3. Review variables.tf and prepare a values file for required inputs (e.g., prod.tfvars)
4. Initialize modules and providers:
   terraform init
5. Validate configuration:
   terraform validate
6. See planned changes:
   terraform plan -var-file="prod.tfvars"
7. Apply to create resources:
   terraform apply -var-file="prod.tfvars"


## Input variables
All input variables and their descriptions live in variables.tf. Common variables typically include:
- Region / location
- VM size / machine type
- Image or OS details
- Network parameters (VNet/VPC, subnet IDs)
- Authentication (SSH key, admin username)

To provide values, create a tfvars file (e.g., prod.tfvars):

variable_name_1 = "value"
variable_name_2 = "value"

Pass it with -var-file as shown above. You may also set variables via environment variables or -var flags.


## Outputs
After terraform apply, key attributes are printed from outputs.tf, such as:
- VM resource ID
- Public/Private IP
- Admin/connection details (non-sensitive)

Use terraform output to list outputs after deployment.


## State management
The Terraform state backend is configured in backend.tf. Ensure any required remote backend resources exist and your credentials allow read/write to the state location. Never commit terraform.tfstate or secrets to version control.


## Environment separation
Use separate workspaces and/or separate tfvars files for different environments:
- terraform workspace new prod
- terraform workspace select prod
- terraform apply -var-file="prod.tfvars"

Alternatively, maintain distinct folders or backends per environment if that better fits your workflow.


## Security notes
- Do not check secrets/keys into version control
- Prefer environment variables or a secrets manager for credentials
- Limit output of sensitive values in outputs.tf (use sensitive = true where appropriate)


## CI/CD
If this repository includes automation (e.g., GitHub Actions under .github/workflows), ensure cloud credentials are provided as encrypted repo secrets. Workflows typically run terraform fmt -check, init, validate, plan, and optionally apply behind manual approvals.


## Troubleshooting
- terraform init errors: verify backend configuration and credentials
- provider auth errors: confirm environment variables or profiles are set correctly
- plan/apply diffs you don’t expect: check for drift, workspace, and variable files


## Destruction
To remove resources created by this configuration:
terraform destroy -var-file="prod.tfvars"

Confirm the plan carefully before approving destruction in production environments.


## License
This project is provided as-is. Add a LICENSE file if you need a specific license.