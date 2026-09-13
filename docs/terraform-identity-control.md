# Terraform Workload Identity Control

## Objective

Bring the existing NorthStar workload identity and its least-privilege Azure authorization under reproducible Terraform management without recreating or modifying the live resources.

## Managed Configuration

Terraform manages:

- `NorthStar-App-Identity`, an existing user-assigned managed identity
- its existing `Reader` role assignment at `NorthStar-Azure-RG` scope

The shared resource group is referenced through a Terraform data source. It is not owned or managed by this identity repository.

## Import Method

The existing Azure resources were imported into Terraform state rather than recreated.

The import process:

1. identified each live Azure resource by its existing resource ID;
2. declared the matching Terraform configuration;
3. imported the managed identity;
4. imported the Reader role assignment; and
5. ran a refresh-backed Terraform plan.

Terraform returned:

> No changes. Your infrastructure matches the configuration.

This confirms that the imported configuration matches the live Azure resources without requiring infrastructure changes.

## Remote-State Security

Terraform state is stored in the existing NorthStar Azure Blob backend using the dedicated key:

`identity-zero-trust.tfstate`

Security characteristics:

- Microsoft Entra authentication is used for backend access.
- The identity project has an isolated state key.
- Azure Blob leasing provides state locking.
- Local state files and variable files are excluded from Git.
- No subscription, tenant, client, principal, object, credential, or token values are committed.

## Pull-Request Controls

Pull request #1 introduced the Terraform configuration through the repository workflow.

Validation results:

- Format and Validate: passed
- Infrastructure Security Scan: passed
- Merge commit: `eb3f06eb3dacb5c757c4249ab81bc7dd67ee3f81`

The `main` branch now requires both checks with strict synchronization and administrator enforcement. Linear history and conversation resolution are required, while force pushes and branch deletion are disabled.

## Deployment Boundary

This implementation establishes configuration ownership and drift detection. It does not introduce an automated `terraform apply` workflow.

Any future deployment capability would require a separately authorized OIDC identity, explicit approval controls, and narrowly scoped deployment permissions.

## Scope

This is controlled portfolio validation for the fictional NorthStar environment.
