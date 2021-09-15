# Requisitos

- Acceso a aks via [service principal](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest). Solicítalo a tu administrador.
- Cliente [azure](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)
- [Terraform](https://www.terraform.io/downloads.html)
- Acceso a aks vault, más info [terraform-backend](https://docs.microsoft.com/en-us/azure/terraform/terraform-backend), [vault](https://docs.microsoft.com/en-us/azure/key-vault/quick-create-cli) para poder recuperar el access key.

# Deploy infra

```sh
terraform init -backend-config=backend-config.hcl
terraform plan -var "client_id=APP_ID" -var "client_secret=PASSWORD"
terraform apply -var "client_id=APP_ID" -var "client_secret=PASSWORD"
```
