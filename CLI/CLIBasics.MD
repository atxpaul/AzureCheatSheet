#Básicos de Azure CLI

## Crear un grupo de recursos

```bash
az group create --name StorageRG --location westeu
```

## Crear una cuenta de almacenamiento

```bash
az storage account create --name testblob123 --resource-group StorageRG --location westeu --sku Standard_GRS --kind StorageV2
```

## Borrar cuenta de almacenamiento

```bash
az storage account delete --name testblob123 --resource-group StorageRG
```

## Crear una VM

```bash
az vm create --resource-group StorageRG --name VM1 --image UbuntuLTS
```
