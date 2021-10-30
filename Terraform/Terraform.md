## Terraform

En este subconjunto de carpetas hay varios ejemplos para Terraform

Comandos

```bash
terraform init #inicia terraform y carga los providers
terraform plan #planifica la creación de recursos, no deja de ser un "whatif". Se puede utilizar -out para guardar el plan
terraform apply #ejecuta el plan
terrafor destroy #elimina los elementos creados en el plan
```

Se puede usar la opción -auto-approve para que no pida confirmación.

# ResoureGroup

[Creación de un grupo de recursos con terraform](/Terraform/ResourceGroup/main.tf)

# VNET

[Creación de una VNET interpolando variables](/Terraform/Interpolation-Vnet/main.tf)

# Storage Acount

[Creación de una Storage Account](/Terraform/StorageAccount/main.tf)

# Utilizar un tfstate remoto con una Storage Account

[Storage remoto para crear una subnet en una vnet con 2 main.tf diferentes](/Terraform/RemoteState/main.tf)
