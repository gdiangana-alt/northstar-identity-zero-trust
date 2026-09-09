#!/usr/bin/env bash
set -euo pipefail

RG="NorthStar-Azure-RG"
LOCATION="canadacentral"
IDENTITY="NorthStar-App-Identity"

if ! az identity show \
  --name "$IDENTITY" \
  --resource-group "$RG" >/dev/null 2>&1; then

  az identity create \
    --name "$IDENTITY" \
    --resource-group "$RG" \
    --location "$LOCATION" \
    --tags DataClassification=Internal
fi

PRINCIPAL_ID=$(az identity show \
  --name "$IDENTITY" \
  --resource-group "$RG" \
  --query principalId \
  -o tsv)

SCOPE=$(az group show \
  --name "$RG" \
  --query id \
  -o tsv)

az role assignment create \
  --assignee-object-id "$PRINCIPAL_ID" \
  --assignee-principal-type ServicePrincipal \
  --role Reader \
  --scope "$SCOPE"
