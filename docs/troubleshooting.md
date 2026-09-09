# NorthStar Identity & Zero Trust — Troubleshooting

This document records issues encountered during the lab using a structured troubleshooting process:

**Failure → Investigation → Root Cause → Remediation → Verification**

## 1. Azure Policy Blocked Resource Changes

### Failure

An update to the `northstaridentity26` storage account was denied with:

`RequestDisallowedByPolicy`

### Investigation

The resource group had an active Azure Policy assignment requiring the following tag:

`DataClassification=Internal`

The attempted change did not include the required classification tag.

### Root Cause

The centrally enforced classification policy rejected a non-compliant resource update.

### Remediation

The required tag was added:

`DataClassification=Internal`

### Verification

The resource update succeeded after the mandatory classification value was applied.

This demonstrated a **MAC-style centralized policy control**, where resource owners cannot bypass organization-defined classification requirements.

---

## 2. Managed Identity Creation Blocked by Policy

### Failure

Creation of the user-assigned managed identity was rejected by Azure Policy.

### Investigation

The managed identity was being created inside `NorthStar-Azure-RG`, where the mandatory `DataClassification=Internal` policy was enforced.

### Root Cause

The new identity resource did not initially include the required classification tag.

### Remediation

The managed identity was recreated with:

`DataClassification=Internal`

### Verification

`NorthStar-App-Identity` was successfully created in Canada Central.

The identity was later assigned the **Reader** role at the `NorthStar-Azure-RG` scope.

---

## 3. Managed Identity Naming Error

### Failure

The managed identity was initially created with an incorrect name.

The Azure portal later returned a generic error when attempting to delete the incorrectly named resource.

### Investigation

The portal deletion operation failed, but the Azure CLI remained available as an alternative management path.

### Root Cause

The original resource had been created with a naming typo, and the portal deletion workflow failed.

### Remediation

The incorrect identity was deleted using Azure CLI.

A correctly named identity was then created:

`NorthStar-App-Identity`

### Verification

PowerShell inventory confirmed that `NorthStar-App-Identity` existed in `NorthStar-Azure-RG`.

This demonstrated the ability to switch between Azure Portal, Azure CLI, and PowerShell when troubleshooting Azure resources.

---

## 4. Entra Sign-In Logs Access Denied

### Failure

Microsoft Entra sign-in logs returned:

`401 - Insufficient privileges to complete the operation`

### Investigation

Other Entra audit functionality remained accessible.

The identity lifecycle event generated when a user was removed from a security group was visible in the audit logs.

### Root Cause

The current lab account did not have sufficient access to view the requested sign-in log data.

### Remediation

The project did not attempt to bypass or unnecessarily elevate privileges.

Entra audit logs were used instead to validate the identity governance event.

### Verification

The `Remove member` audit event showed a successful status.

This constraint was documented rather than misrepresented as a successfully implemented capability.

---

## 5. Identity Lifecycle Offboarding Verification

### Failure

A leaver scenario required confirmation that access had actually been revoked.

### Investigation

The fictional employee account remained active, but membership in the baseline employee security group needed to be removed.

### Root Cause

Organizational access was inherited through group membership.

### Remediation

The user was removed from `NorthStar-Employees` while the identity itself was retained.

### Verification

Microsoft Entra audit logs recorded a successful `Remove member` event.

This demonstrated a controlled offboarding process where access was revoked without immediately deleting the identity.
