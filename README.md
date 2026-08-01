# Modular Terraform Infrastructure-as-Code practice on Azure 

A modular Terraform project that deploys a complete Azure infrastructure using reusable modules. Designed for real-world Azure IaC practices with environment-based deployment.

---

## 🌟 Project Overview

This project provisions a secure, production-ready Azure infrastructure using a modular Terraform approach. Each resource is encapsulated in its own reusable module. Credentials are managed via Key Vault — never hardcoded. The Windows VM receives its credentials directly from Key Vault at deploy time, with a Managed Identity attached for secure Azure resource access.

---

## 🏗️ Architecture

```
Resource Group
      ↓
Network (VNet + VM Subnet + PE Subnet)
      ↓
NSG + Subnet Association
      ↓
Storage Account + Blob Container
      ↓
Private Endpoint + DNS Zone + DNS Link + A Record
      ↓
Managed Identity
      ↓
Key Vault + Secrets (VM username + password)
      ↓
RBAC Assignment (Contributor → Managed Identity)
      ↓
Windows VM ← credentials from Key Vault
           ← Managed Identity attached
           ← RBAC Contributor role
```

---

## ✨ Features

- ✅ Fully modular structure — each resource in its own reusable module
- ✅ Environment-based deployment — `dev` and `prod` via separate tfvars
- ✅ Credentials managed via Azure Key Vault — no hardcoded secrets
- ✅ Windows VM with User Assigned Managed Identity
- ✅ Storage Account secured with Private Endpoint + Private DNS Zone
- ✅ NSG with RDP and WinRM rules attached to VM subnet
- ✅ RBAC Contributor role assigned to Managed Identity

---

## 📁 Project Structure

```
modular-arch/
├── provider.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── env/
│   ├── dev.tfvars           # dev environment values (gitignored)
│   └── terraform.tfvars.exanple       # reference only — copy and fill in values
└── modules/
    ├── resource-group/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── network/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── nsg/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── storage-account/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── private-endpoint/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── managed-identity/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── key-vault/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── rbac/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── windows-vm/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## 🧩 Modules

| Module | Resources |
|--------|----------|
| `resource-group` | `azurerm_resource_group` |
| `network` | `azurerm_virtual_network`, `azurerm_subnet` (x2) |
| `nsg` | `azurerm_network_security_group`, `azurerm_subnet_network_security_group_association` |
| `storage-account` | `azurerm_storage_account`, `azurerm_storage_container` |
| `private-endpoint` | `azurerm_private_endpoint`, `azurerm_private_dns_zone`, `azurerm_private_dns_zone_virtual_network_link`, `azurerm_private_dns_a_record` |
| `managed-identity` | `azurerm_user_assigned_identity` |
| `key-vault` | `azurerm_key_vault`, `azurerm_key_vault_secret` (x2) |
| `rbac` | `azurerm_role_assignment` |
| `windows-vm` | `azurerm_public_ip`, `azurerm_network_interface`, `azurerm_windows_virtual_machine` |

---

## ✅ Prerequisites

- Terraform >= 1.3.0
- Azure CLI installed and logged in
- Azure subscription

```bash
az login
```

---

## 🚀 Usage

### 🔧 Setup

```bash
# Clone the repo
git clone https://github.com/SharifMahin/terraform-azure-modular-full-architecture.git
cd modular-arch

# Copy example and fill in your values
cp env/terraform.tfvars.example env/dev.tfvars
```

### ▶️ Deploy

```bash
terraform init
terraform plan  -var-file="env/dev.tfvars"
terraform apply -var-file="env/dev.tfvars"
```

### 🗑️ Destroy

```bash
terraform destroy -var-file="env/dev.tfvars"
```

---

## 🌍 Environments

Currently configured for `dev` environment only.

| Environment | File | Status |
|-------------|------|--------|
| dev | `env/dev.tfvars` | ✅ Active |

---

## 💡 Key Concepts

| Concept | Where |
|---------|-------|
| Module output chaining | `module.key_vault.vm_username → module.windows_vm` |
| KV credentials for VM | `modules/key-vault` + `modules/windows-vm` |
| Managed Identity on VM | `identity {}` block in `modules/windows-vm` |
| Private Endpoint + DNS | `modules/private-endpoint` |
| Environment-based tfvars | `env/dev.tfvars` |
| Data source | `data "azurerm_client_config" "current"` in `modules/key-vault` |

---

## ⚠️ Cautions

### 1. 🚫 Never delete resources from Azure Portal

This project manages infrastructure via Terraform state. **Deleting resources manually from the Azure Portal will cause state mismatch and deployment errors.**

Always use Terraform to manage resources:

```bash
# ✅ Correct
terraform destroy -var-file="env/dev.tfvars"

# ❌ Never do this
# Manually deleting resources from Azure Portal
```

**If you accidentally delete from the Portal:**

Key Vault has soft delete enabled. Deleting from Portal will leave it in soft deleted state — re-applying will fail with:

```
Error: a resource with the ID "https://<kv-name>.vault.azure.net/secrets/..." already exists
```

Fix:
```bash
# Purge the soft-deleted Key Vault
az keyvault purge --name <your-kv-name> --location japaneast

# Then re-apply
terraform apply -var-file="env/dev.tfvars"
```

For other resources — destroy all and re-apply:
```bash
terraform destroy -var-file="env/dev.tfvars"
terraform apply  -var-file="env/dev.tfvars"
```

### 2. 🔒 Never commit `env/dev.tfvars`

This file contains sensitive values like VM passwords. It is excluded via `.gitignore`.

Only `env/terraform.tfvars.example` is committed as a reference.

```
# .gitignore
env/*.tfvars
!env/example.tfvars
```

### 3. 💸 Always destroy when done (dev)

This project deploys billable resources including Windows VM and Private Endpoint. Always destroy when not in use:

```bash
terraform destroy -var-file="env/dev.tfvars"
```

### 4. 🔑 Key Vault soft delete — dev vs prod

Current settings are optimized for dev:

```hcl
purge_protection_enabled   = false
soft_delete_retention_days = 7
```

For production, change to:

```hcl
purge_protection_enabled   = true
soft_delete_retention_days = 90
```

---

## 🛠️ Tech Stack

- Terraform ~> 1.3.0
- AzureRM Provider ~> 4.0
- Azure (japaneast)
- Azure CLI

---

## 👤 Author

**MD SHARIF MULLA MAHIN**  
Cloud Lead Engineer  
Tokyo, Japan 🇯🇵
