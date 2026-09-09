# NorthStar Identity & Zero Trust Architecture

This project demonstrates an enterprise identity and access model using Microsoft Entra ID and Azure security controls.

## Architecture

```mermaid
flowchart LR

    subgraph Entra["Microsoft Entra ID"]
        USERS["Fictional Users"]
        GROUPS["Security Groups"]
        MFA["Security Defaults<br/>Microsoft Authenticator"]
        AUDIT["Audit Logs"]
    end

    subgraph Azure["Azure Authorization & Resources"]
        RBAC["Azure RBAC"]
        RG["NorthStar-Azure-RG"]
        STORAGE["northstaridentity26"]
        ABAC["ABAC Condition<br/>Container = northstar-app-data"]
        DAC["DAC-style Sharing<br/>Read-only Time-limited SAS"]
        MI["NorthStar-App-Identity"]
        POLICY["Azure Policy<br/>DataClassification = Internal"]
    end

    MFA --> USERS
    USERS --> GROUPS
    GROUPS --> RBAC
    RBAC --> RG

    GROUPS --> ABAC
    ABAC --> STORAGE
    STORAGE --> DAC

    MI -->|"Reader"| RG
    POLICY -->|"Mandatory classification enforcement"| RG
    USERS -->|"Lifecycle changes"| AUDIT
```

## Access Control Model

- **RBAC** — Group-based Azure role assignments with least-privilege scope.
- **ABAC** — Storage access restricted with a condition based on the target container name.
- **DAC-style** — Discretionary object sharing demonstrated with a read-only, time-limited SAS.
- **MAC-style** — Centralized mandatory classification demonstrated through Azure Policy enforcement.

## Zero Trust Controls

- Security Defaults enabled in Microsoft Entra ID.
- Microsoft Authenticator enabled for all users.
- Group-based authorization instead of direct user role assignments.
- Managed identity used for non-human Azure authorization without storing user credentials.
- Audit logging used to verify identity lifecycle changes.
