# Azure_terraform

Creează în Azure un VM Windows Server 2022 (acces RDP doar de la IP-ul tău,
oprire automată zilnic la 22:00) și un share Azure Files.

## Starea Terraform (o singură dată)

Starea e ținută într-un Storage Account separat, creat manual, ca să nu se
piardă între rulări și să poată fi blocată:

```sh
az group create -n tfstate-rg -l westeurope
az storage account create -n <nume-unic>tfstate -g tfstate-rg --sku Standard_LRS --min-tls-version TLS1_2
az storage container create -n tfstate --account-name <nume-unic>tfstate
```

## GitHub Actions

Workflow-ul (`.github/workflows/terraform.yml`) face `plan` pe PR-uri și
`apply` la push pe `main`, autentificat prin OIDC.

Repository variables (Settings → Secrets and variables → Actions → Variables):

| Nume | Valoare |
| --- | --- |
| `AZURE_CLIENT_ID` | client ID-ul aplicației cu federated credential |
| `AZURE_TENANT_ID` | tenant ID |
| `AZURE_SUBSCRIPTION_ID` | subscription ID |
| `TFSTATE_RESOURCE_GROUP` | ex: `tfstate-rg` |
| `TFSTATE_STORAGE_ACCOUNT` | ex: `<nume-unic>tfstate` |
| `TFSTATE_CONTAINER` | ex: `tfstate` |

Repository secrets: `TF_VAR_admin_password`, `TF_VAR_my_ip`.

## Rulare locală

```sh
cp terraform.tfvars.example terraform.tfvars   # și completează valorile
az login
terraform init \
  -backend-config="resource_group_name=tfstate-rg" \
  -backend-config="storage_account_name=<nume-unic>tfstate" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=azure_terraform.tfstate"
terraform plan
```

După `apply`, conectează-te prin RDP la `vm_public_ip` (output) cu
`admin_username` / `admin_password`.
