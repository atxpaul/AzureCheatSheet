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
az group create --name StorageRG --location westeurope
```

## Borrar un grupo de recursos

```bash
az group delete --name StorageRG
```

## Crear una cuenta de almacenamiento

```bash
az storage account create --name testblob123 --resource-group StorageRG --location westeurope --sku Standard_LRS --kind StorageV2
```

## Borrar cuenta de almacenamiento

```bash
az storage account delete --name testblob123 --resource-group StorageRG
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
