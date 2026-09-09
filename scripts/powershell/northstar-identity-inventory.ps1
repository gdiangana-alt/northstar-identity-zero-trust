$rg = "NorthStar-Azure-RG"

Write-Host "=== NorthStar Managed Identities ==="
Get-AzUserAssignedIdentity -ResourceGroupName $rg |
    Select-Object Name, Location, ResourceGroupName

Write-Host "`n=== NorthStar RBAC Assignments ==="
Get-AzRoleAssignment -ResourceGroupName $rg |
    Where-Object { $_.DisplayName -like "NorthStar-*" } |
    Select-Object DisplayName, RoleDefinitionName, ObjectType, Scope
