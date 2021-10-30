#Create RG for storing State Files
az group create --location westeurope --name rg-terraformstate

#Create Storage Account
az storage account create --name atxterrastatestorage --resource-group rg-terraformstate --location westeurope --sku Standard_LRS

#Create Storage Container
az storage container create --name terraformdemo --account-name atxterrastatestorage

#Enable versioning on Storage Account1
az storage account blob-service-properties update --account-name atxterrastatestorage --enable-change-feed --enable-versioning true