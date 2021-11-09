# Básicos de Azure CLI

## Loggearse en Azure

```bash
az login
```

## Ver datos de la cuenta

```bash
az account show
```

## Ver suscripciones

```bash
az account list
```

## Crear un grupo de recursos

```bash
az group create --name StorageRG --location westeurope --suscription --tags "test" --manage-by "atxpaul@pablo.com"
```

## Listar grupos de recursos

```bash
az group list
```

Podemos buscar con --query cualquiera de sus parámetros

```bash
az group list --query "[?location=='westeurope']"
```

## Comprobar si existe un grupo de recursos

```bash
az group exists --name StorageRG
```

```bash
az group show --resource-group StorageRG
```

## Borrar un grupo de recursos

--yes y --no-wait son opcionales.

```bash
az group delete --name StorageRG --yes --no-wait
```

## Gestionar locks

```bash
az group lock list -g StorageRG
az group lock create --lock-type ReadOnly -n SoloLectura -g StorageRG
az group lock create --lock-type CanNotDelete -n NoBorrar -g StorageRG
az group lock delete --name NoBorrar -g StorageRG
```

## Gestionar recursos en un grupo

```bash
az resource list
az resource list -l westeurope
az resource list -g StorageRG
az resource list --tag 'test*'
az resource list --name nombredelrecurso
az resource list --resource-type Microsoft.Compute/virtualMachines
```

## Crear un recurso en un grupo

```bash
az resource create -g StorageRG -n myWebApp --resource-type Microsoft.web/sites
```

## Crear una cuenta de almacenamiento

```bash
az storage account create --name testblob123 --resource-group StorageRG --location westeurope --sku Standard_LRS --kind StorageV2
```

## Borrar cuenta de almacenamiento

```bash
az storage account delete --name testblob123 --resource-group StorageRG
```

## Crear contenedor de almacenamiento

Con --public-access blob se da acceso a los blobs. Con --fail-on-exist muestra un error si el contenedor ya existe

```bash
az storage container create --name packtpubbs --public-access container --account-name packtpubsacliaz storage blob upload --file C:\test.txt --container-name packtpubbs --name blobcli --account-name packtpubsacli
```

## Crear una VM

```bash
az vm create --resource-group StorageRG --name VM1 --image UbuntuLTS
```

## Lista de regiones disponibles en Azure

```bash
centralus,eastasia,southeastasia,eastus,eastus2,westus,westus2,northcentralus,southcentralus,westcentralus,northeurope,westeurope,japaneast,japanwest,brazilsouth,australiasoutheast,australiaeast,westindia,southindia,centralindia,canadacentral,canadaeast,uksouth,ukwest,koreacentral,francecentral,southafricanorth,uaenorth,australiacentral,switzerlandnorth,germanywestcentral,norwayeast,jioindiawest,westus3,australiacentral2
```

## Formatos de salida de datos en azure

A aplicar por ejemplo después de az account list

```bash
-o table
-o jsonc
-o yaml
-o tsv
```
