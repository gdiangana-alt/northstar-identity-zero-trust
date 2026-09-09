# NorthStar Identity & Zero Trust

**Enterprise Identity & Zero Trust — Microsoft Entra ID and Azure Security Portfolio Project**

![Microsoft Entra ID](https://img.shields.io/badge/Microsoft%20Entra-ID-blue)
![Azure](https://img.shields.io/badge/Microsoft-Azure-blue)
![Zero Trust](https://img.shields.io/badge/Security-Zero%20Trust-success)
![Status](https://img.shields.io/badge/Project-Complete-brightgreen)

## Project Overview

This project demonstrates the design and implementation of an enterprise identity and Zero Trust security model for the fictional NorthStar organization.

The lab focuses on identity lifecycle, least-privilege authorization, Microsoft Entra authentication controls, Azure RBAC and ABAC, managed identities, centralized policy enforcement, auditability, automation, and troubleshooting.

The environment was intentionally designed to reflect real enterprise identity-security responsibilities rather than isolated portal exercises.

## Objectives

The project demonstrates:

- Microsoft Entra user and group administration
- Group-based Azure RBAC
- Least-privilege access design
- Azure ABAC conditions
- DAC-style resource sharing
- MAC-style centralized classification enforcement
- Security Defaults and Microsoft Authenticator
- Managed identities for non-human access
- Identity lifecycle and offboarding
- Microsoft Entra audit validation
- Azure Policy enforcement
- Azure CLI and PowerShell automation
- Identity and authorization troubleshooting

## Environment

| Component | Configuration |
|---|---|
| Identity platform | Microsoft Entra ID |
| Entra license | Microsoft Entra ID Free |
| Azure resource group | `NorthStar-Azure-RG` |
| Region | Canada Central |
| Storage account | `northstaridentity26` |
| Blob container | `northstar-app-data` |
| Managed identity | `NorthStar-App-Identity` |

No tenant IDs, subscription IDs, object IDs, principal IDs, credentials, tokens, or reusable authentication material are published in this repository.

## Identity Personas

Four fictional identities were created to model enterprise job functions.

| User | Persona | Access Scenario |
|---|---|---|
| Alex Morgan | Standard Employee | Baseline organizational access and lifecycle scenario |
| Jamie Chen | Application Developer | Application data access and ABAC |
| Taylor Brooks | Security Analyst | Security monitoring and least-privilege RBAC |
| Jordan Lee | Cloud Administrator | Azure administration through group-based RBAC |

## Security Groups

The following Microsoft Entra security groups were created:

- `NorthStar-Cloud-Admins`
- `NorthStar-Security-Analysts`
- `NorthStar-App-Developers`
- `NorthStar-Employees`

Access was assigned primarily through groups rather than directly to individual users.

This supports centralized administration, easier lifecycle management, and least-privilege authorization.

## Azure RBAC

Azure RBAC was implemented at appropriate scopes.

| Principal | Role | Scope |
|---|---|---|
| NorthStar-Cloud-Admins | Contributor | `NorthStar-Azure-RG` |
| NorthStar-Security-Analysts | Security Reader | `NorthStar-Azure-RG` |
| NorthStar-App-Developers | Storage Blob Data Contributor | `northstaridentity26` |
| NorthStar-App-Identity | Reader | `NorthStar-Azure-RG` |

### Least-Privilege Design

The lab avoids unnecessary subscription-wide administrative access for fictional personas.

Examples:

- Cloud administrators receive Contributor at resource-group scope.
- Security analysts receive Security Reader rather than administrative control.
- Application developers receive data-plane access only to the required storage service.
- The managed identity receives Reader rather than Contributor.

## Azure ABAC

Azure Attribute-Based Access Control was layered onto an existing RBAC assignment.

The `NorthStar-App-Developers` group received:

`Storage Blob Data Contributor`

An ABAC condition was added for selected blob operations using the resource attribute:

`Container name = northstar-app-data`

This demonstrates how authorization can be refined beyond role and scope by evaluating attributes of the target resource.

## DAC-Style Access Control

A discretionary access-sharing scenario was demonstrated using:

`employee-access-demo.txt`

A Shared Access Signature was generated with:

- Read-only permission
- HTTPS-only access
- Limited expiration
- Access to a specific object

This represents a **DAC-style** scenario because controlled access to a specific resource was delegated at the resource level.

The SAS token and URL are not stored in this repository.

## MAC-Style Centralized Enforcement

A built-in Azure Policy was assigned to `NorthStar-Azure-RG` requiring:

`DataClassification=Internal`

The policy was actively tested.

A resource update without the required classification was denied with:

`RequestDisallowedByPolicy`

After the required tag was applied, the operation succeeded.

This demonstrates a **MAC-style centralized enforcement model**, where centrally defined classification requirements cannot be bypassed by an individual resource owner.

## Zero Trust Authentication

The project applies the principle that identity should be explicitly verified before access is trusted.

### Security Defaults

Microsoft Entra Security Defaults were enabled.

This provides baseline tenant-level identity protection in the Entra Free environment.

### Microsoft Authenticator

Microsoft Authenticator was enabled as an authentication method for all users.

### Conditional Access

Conditional Access was not represented as deployed because the project used Microsoft Entra ID Free.

In an enterprise environment, Conditional Access would extend this architecture with controls such as:

- MFA based on risk or context
- Device compliance requirements
- Location-aware access decisions
- Application-specific policies
- Session restrictions
- Privileged-user protection

The capability is documented as enterprise progression rather than falsely represented as implemented.

## Managed Identity

A user-assigned managed identity was created:

`NorthStar-App-Identity`

The identity was assigned:

`Reader → NorthStar-Azure-RG`

This demonstrates workload authorization using an Azure-managed service principal without storing user credentials or application passwords.

The project demonstrates identity creation and RBAC authorization. It does not claim that a production application was attached to or authenticated through this identity.

## Identity Governance and Lifecycle

A manual leaver scenario was performed using the fictional employee Alex Morgan.

The identity itself was retained while membership in:

`NorthStar-Employees`

was removed.

This demonstrates a controlled offboarding process where organizational access is revoked before identity deletion.

### Enterprise Governance Progression

The following capabilities were evaluated conceptually but not represented as deployed in the current lab:

- Lifecycle Workflows
- Access Reviews
- Privileged Identity Management
- Automated joiner/mover/leaver workflows

These capabilities represent the enterprise evolution of the manual lifecycle control demonstrated in the lab.

## Auditing

Microsoft Entra audit logs were used to verify identity lifecycle activity.

The user-removal action generated:

`Remove member → Success`

This provided evidence that the access change was recorded and auditable.

An attempt to access Microsoft Entra sign-in logs returned:

`401 - Insufficient privileges to complete the operation`

The limitation was documented rather than bypassed or falsely represented as successful sign-in-log analysis.

## Azure Policy

Azure Policy was used as a centralized governance control.

Policy:

`NorthStar-Require-DataClassification`

Required value:

`DataClassification=Internal`

The project demonstrated both:

- Non-compliant operation denied
- Compliant operation accepted

This provided direct evidence that governance policy was being enforced rather than merely configured.

## Automation

### PowerShell

PowerShell was used to inventory:

- User-assigned managed identities
- Azure RBAC assignments
- Role names
- Principal types
- Authorization scopes

Script:

[`scripts/powershell/northstar-identity-inventory.ps1`](scripts/powershell/northstar-identity-inventory.ps1)

### Azure CLI

Azure CLI was used to:

- Delete an incorrectly named managed identity
- Create the correctly named managed identity
- Apply the mandatory classification tag
- Resolve the managed identity principal dynamically
- Assign Reader at resource-group scope

Reusable script:

[`scripts/azure-cli/managed-identity.sh`](scripts/azure-cli/managed-identity.sh)

The automation files intentionally avoid hardcoded tenant IDs, subscription IDs, principal IDs, and credentials.

## Troubleshooting

The project records real implementation problems using:

**Failure → Investigation → Root Cause → Remediation → Verification**

Examples include:

- Azure Policy denying non-compliant resource changes
- Managed identity creation blocked by mandatory classification policy
- Managed identity naming error
- Portal deletion failure resolved through Azure CLI
- Microsoft Entra sign-in log access returning insufficient privileges
- Identity lifecycle verification through audit logs

Full documentation:

[`docs/troubleshooting.md`](docs/troubleshooting.md)

## Architecture

The project architecture shows the relationship between:

- Microsoft Entra users
- Security groups
- Authentication controls
- Azure RBAC
- Azure ABAC
- Azure resources
- Managed identities
- Azure Policy
- DAC-style resource sharing
- Audit logging

Architecture documentation:

[`docs/architecture.md`](docs/architecture.md)

## Access-Control Models Demonstrated

| Model | Project Implementation |
|---|---|
| RBAC | Azure roles assigned through security groups and managed identity |
| ABAC | Storage role condition based on container name |
| DAC | Time-limited, read-only SAS for a specific object |
| MAC | Centralized mandatory classification enforced through Azure Policy |

The project distinguishes native Azure authorization mechanisms from broader access-control models rather than treating them as interchangeable services.

## Security Considerations

The repository intentionally excludes:

- Subscription IDs
- Tenant IDs
- Object IDs
- Principal IDs
- Client IDs
- Personal UPNs
- SAS tokens
- SAS URLs
- Authentication secrets
- Session IDs
- Portal URLs containing embedded identifiers

Evidence should be cropped or sanitized before publication.

See:

[`evidence/README.md`](evidence/README.md)

## Licensing and Lab Constraints

The project used Microsoft Entra ID Free.

As a result, some enterprise identity-governance and Zero Trust features were documented rather than deployed.

The portfolio explicitly distinguishes between:

- Implemented controls
- Demonstrated scenarios
- Verified results
- Documented enterprise progression
- Access-constrained functionality

See:

[`docs/completion-matrix.md`](docs/completion-matrix.md)

## Repository Structure

```text
northstar-identity-zero-trust/
├── README.md
├── docs/
│   ├── architecture.md
│   ├── completion-matrix.md
│   └── troubleshooting.md
├── evidence/
│   └── README.md
└── scripts/
    ├── azure-cli/
    │   └── managed-identity.sh
    └── powershell/
        └── northstar-identity-inventory.ps1
```

## Skills Demonstrated

- Microsoft Entra ID
- Identity and Access Management
- Zero Trust
- Azure RBAC
- Azure ABAC
- Least Privilege
- Microsoft Authenticator
- Managed Identities
- Azure Policy
- Identity Governance
- Identity Lifecycle Management
- Audit Logging
- Azure Storage Authorization
- PowerShell
- Azure CLI
- Security Troubleshooting
- Cloud Security Architecture

## Project Outcome

The NorthStar Identity & Zero Trust project demonstrates the progression from basic identity administration to enterprise-oriented cloud identity security.

The completed environment shows how identities, groups, authentication controls, authorization, workload identities, policy enforcement, lifecycle governance, auditing, automation, and troubleshooting work together as part of a coherent Azure security architecture.

**Project Status: Complete**
