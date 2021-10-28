## Terraform

En este subconjunto de carpetas hay varios ejemplos para Terraform

# ResoureGroup

[Creación de un grupo de recursos con terraform](/Terraform/ResourceGroup/main.tf)

Comandos

```bash
terraform init #inicia terraform y carga los providers
terraform plan #planifica la creación de recursos, no deja de ser un "whatif". Se puede utilizar -out para guardar el plan
terraform apply #ejecuta el plan
terrafor destroy #elimina los elementos creados en el plan
```

Se puede usar la opción -no-approve para que no pida confirmación.
