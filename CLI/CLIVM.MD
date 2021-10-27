# Azure Gestión Máquinas Virtuales

## Listar máquinas virtuales

Se puede filtrar por -g para buscar por grupo y más parámetros. Con -d indica las máquinas que están corriendo

```bash
az vm list
```

## Arrancar máquina virtual

```bash
az vm start --name VMCLI01 --resource-group TestVM-rg
```

## Detener máquina virtual

Al hacer stop, se para el sistema operativo

```bash
az vm stop --name VMCLI01 --resource-group TestVM-rg
```

## Desasignar máquina virtual

Al desasignar, se para completamente la máquina virtual y deja de facturarse.

```bash
az vm deallocate --name VMCLI01 --resource-group TestVM-rg
```

## Gestión de imágenes

```bash
az vm image list-skus -l westeurope -f WindowsServer -p MicrosoftWindowsServer
```

## Ver tamaños disponibles por ubicación

```bash
az vm list-sizes -l westeurope
```

## Creación máquina virtual

Básica

```bash
az vm create --resource-group TestVM-rg --name VMCLI01 --image 'Canonical:UbuntuServer:18.04-LTS:latest' --admin-username admin --admin-password 'P@ssword1234'
az vm create --resource-group TestVM-rg --name VMCLI01 --image 'Canonical:UbuntuServer:18.04-LTS:latest' --admin-username admin --admin-password 'P@ssword1234' --size 'Standard_B1ls' --data-disk-size-gb 128
```

Con parámetros de red

```bash
az vm create --resource-group TestVM-rg --name VMCLI01 --image 'Canonical:UbuntuServer:18.04-LTS:latest' --admin-username admin --admin-password 'P@ssword1234' \
--size 'Standard_B1ls' --data-disk-size-gb 128 \
--nsg 'VMCLI01-nsg' --private-ip-address 10.2.0.26 --vnet-name 'VLAN01-vnet' --vnet-address-prefix 10.2.0.0/16 --subnet 'subnet-VLAN01' --subnet-address-prefix 10.2.0.0/16
```

Generando clave SSH

```bash
az vm create --resource-group TestVM-rg --name VMCLI01 --image 'Canonical:UbuntuServer:18.04-LTS:latest' --admin-username admin --generate-ssh-keys \
--size 'Standard_B1ls' --data-disk-size-gb 128 \
--nsg 'VMCLI01-nsg' --private-ip-address 10.2.0.26 --vnet-name 'VLAN01-vnet' --vnet-address-prefix 10.2.0.0/16 --subnet 'subnet-VLAN01' --subnet-address-prefix 10.2.0.0/16 --open-port '80'
```

Usando clave SSH ya existente

```bash
az vm create --resource-group TestVM-rg --name VMCLI01 --image 'Canonical:UbuntuServer:18.04-LTS:latest' --admin-username admin --ssh-key-values 'C:\MiDirectorio\.ssh\id_rsa.pub' \
--size 'Standard_B1ls' --data-disk-size-gb 128 \
--nsg 'VMCLI01-nsg' --private-ip-address 10.2.0.26 --vnet-name 'VLAN01-vnet' --vnet-address-prefix 10.2.0.0/16 --subnet 'subnet-VLAN01' --subnet-address-prefix 10.2.0.0/16
```

# Cambiar tamaño de VM

Ver las posibilidades sobre una VM concreta

```bash
az vm list-vm-resize-options -g TestVM-rg -n VMCLI01
```

Cambio de tamaño

```bash
az vm resize -g TestVM-rg -n VMCLI01 --size Standard_D2_v2
```

# Capturar imagen de VM & crear VM con ella

Primero debemos desasignar la VM

```bash
az vm generalize -g TestVM-rg -n VMCLI01
```

Crear la imagen

```bash
az image create -g TestVM-rg -n nombreImagen --source VMCLI01
```

Crear la VM

```bash
az vm create -g TestVM-rg --name VMCLI02 -image nombreImagen --admin-username admin --admin-password 'P@ssword1234'
```

# Ver IPs de las VM

```bash
az vm list-ip-addresses -g TestVM-rg -n VMCLI01
```

# Abrir puertos VM

```bash
az vm open-port -g TestVM-rg -n VMCLI01 --port '80'
```

# Eliminar VM

```bash
az vm delete --name VMCLI01 --resource-group TestVM-rg
```
