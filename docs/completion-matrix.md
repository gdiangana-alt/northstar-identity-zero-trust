# NorthStar Identity & Zero Trust — Completion Matrix

This matrix distinguishes controls that were implemented hands-on from capabilities documented as enterprise progression because of lab licensing or access constraints.

| Capability | Status | Implementation / Evidence |
|---|---|---|
| Entra users | ✅ Implemented | Four fictional NorthStar identities created |
| Security groups | ✅ Implemented | Cloud Admins, Security Analysts, App Developers, and Employees groups |
| Group-based RBAC | ✅ Implemented | Azure roles assigned to security groups rather than individual users |
| Least-privilege RBAC | ✅ Implemented | Contributor, Security Reader, and scoped data-access roles |
| ABAC | ✅ Implemented | Blob operations conditioned on container name `northstar-app-data` |
| DAC-style access | ✅ Demonstrated | Read-only, HTTPS-only, time-limited SAS for a specific blob |
| MAC-style control | ✅ Demonstrated | Azure Policy enforced mandatory `DataClassification=Internal` classification |
| Policy enforcement testing | ✅ Verified | Non-compliant resource change denied; compliant change succeeded |
| Security Defaults | ✅ Implemented | Enabled at the Microsoft Entra tenant level |
| Microsoft Authenticator | ✅ Implemented | Authentication method enabled for all users |
| Conditional Access | 📘 Documented | Enterprise Zero Trust progression; not deployed in the Entra Free lab |
| Managed Identity | ✅ Implemented | `NorthStar-App-Identity` created as a user-assigned managed identity |
| Workload RBAC | ✅ Implemented | Managed identity assigned Reader at resource-group scope |
| Identity lifecycle | ✅ Demonstrated | Employee group membership removed during leaver simulation |
| Entra audit logging | ✅ Verified | Successful `Remove member` lifecycle event observed |
| Sign-in log analysis | ⚠️ Access constrained | Attempt returned 401 insufficient privileges; constraint documented |
| Lifecycle Workflows | 📘 Documented | Enterprise governance progression; not deployed in current lab |
| Access Reviews | 📘 Documented | Enterprise governance progression; not deployed in current lab |
| Privileged Identity Management | 📘 Documented | Enterprise privileged-access progression; not deployed in current lab |
| Azure CLI automation | ✅ Implemented | Managed identity creation and RBAC workflow |
| PowerShell automation | ✅ Implemented | Managed identity and RBAC inventory |
| Troubleshooting | ✅ Documented | Policy, managed identity, permissions, and lifecycle scenarios recorded |

## Status Definitions

- **Implemented** — Configured directly in the Azure or Microsoft Entra environment.
- **Demonstrated** — Validated through a controlled hands-on scenario.
- **Verified** — Result confirmed through Azure/Entra output, logs, or enforcement behavior.
- **Documented** — Architecturally understood but intentionally not claimed as deployed.
- **Access constrained** — Attempted in the lab but unavailable with the current permissions or environment.

## Project Integrity

Capabilities unavailable in the current lab environment are explicitly identified rather than represented as deployed controls. This keeps the portfolio technically accurate while demonstrating awareness of enterprise identity and Zero Trust capabilities.
