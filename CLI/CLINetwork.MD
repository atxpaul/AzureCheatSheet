# Gestión de redes

## Crear una vnet

```bash
az network vnet create -g MyResourceGroup -n MyVnet --address-prefix 10.0.0.0/16 \
    --subnet-name MySubnet --subnet-prefix 10.0.0.0/24
```

## Crear una subnet

Asociada a una routetable

```bash
az network vnet subnet create -g MyResourceGroup --vnet-name MyVnet -n MySubnet \
    --address-prefixes 10.0.0.0/24 --network-security-group MyNsg --route-table MyRouteTable
```

## Crear NIC

```bash
az network nic create -g MyResourceGroup --vnet-name MyVnet --subnet MySubnet -n MyNic
```

## Crear NIC en un NSG y ASG

```bash
az network nic create -g MyResourceGroup --vnet-name MyVnet --subnet MySubnet -n MyNic \
    --network-security-group MyNsg --application-security-groups Web App
```

## Asociada a una nat

```bash
az network vnet subnet create -n MySubnet --vnet-name MyVnet -g MyResourceGroup --nat-gateway MyNatGateway --address-prefixes "10.0.0.0/21"
```

## Reglas efectivas de un NSG

![Presentación NSG Effective rules](https://github.com/atxpaul/AzureCheatSheet/blob/main/assets/NSGEffectiveRules.png?raw=true)

## Crear un NSG

```bash
az network nsg create -g MyResourceGroup -n MyNsg --tags super_secure no_80 no_22
```

## Añadir regla a NSG

Regla básica de NSG "Permitir" con la prioridad más alta.

```bash
az network nsg rule create -g MyResourceGroup --nsg-name MyNsg -n MyNsgRule --priority 100
```

Regla "Denegar" sobre TCP para un intervalo de direcciones IP específico con la prioridad más baja.

```bash
az network nsg rule create -g MyResourceGroup --nsg-name MyNsg -n MyNsgRule --priority 4096 \
    --source-address-prefixes 208.130.28/24 --source-port-ranges 80 \
    --destination-address-prefixes '*' --destination-port-ranges 80 8080 --access Deny \
    --protocol Tcp --description "Deny from specific IP address ranges on 80 and 8080."
```

Regla de seguridad mediante etiquetas de servicio.

```bash
az network nsg rule create -g MyResourceGroup --nsg-name MyNsg -n MyNsgRuleWithTags \
    --priority 400 --source-address-prefixes VirtualNetwork --destination-address-prefixes Storage \
    --destination-port-ranges '*' --direction Outbound --access Allow --protocol Tcp --description "Allow VirtualNetwork to Storage."
```

Regla de seguridad mediante grupos de seguridad de aplicaciones.

```bash
az network nsg rule create -g MyResourceGroup --nsg-name MyNsg -n MyNsgRuleWithAsg \
    --priority 500 --source-address-prefixes Internet --destination-port-ranges 80 8080 \
    --destination-asgs Web --access Allow --protocol Tcp --description "Allow Internet to Web ASG on ports 80,8080."
```

## Añadir ASG (grupo de seguridad de aplicaciones)

```bash
az network asg create -g MyResourceGroup -n MyAsg --tags MyWebApp
```

## Añadir NIC a ASG

```bash
az network nic update -g MyResourceGroup -n MyNic --network-security-group MyAsg
```

## Hacer peering entre 2 VNET

```bash
az network vnet peering create -g MyResourceGroup -n MyVnet1ToMyVnet2 --vnet-name MyVnet1 \
    --remote-vnet MyVnet2Id --allow-vnet-access
```

Si tenemos 3 VNET conectadas tipo A<->B y B<->C, A y C no están conectadas. Necesitaremos una NVA y UDR definidas para que se enrute desde la A la C o viceversa si se necesita.
Más información [aqui](https://docs.microsoft.com/en-us/azure/virtual-network/tutorial-create-route-table-portal)

## Crear private dns zone

```bash
az network private-dns zone delete -g MyResourceGroup -n www.mysite.com
```

## Enlazar private dns zone a vnet

```bash
az network private-dns link vnet create --name MyLinkName --registration-enabled true --resource-group MyResourceGroup --subscription MySubscription --tags CostCenter=Marketing --virtual-network MyVirtualNetworkId --zone-name www.mysite.com
```

## Load balancer

Los LB tienen 2 tipos de SKUs: Basic (gratis) y Standard. Los Standard permiten balancear a través de diferentes Availability Zones.

Creamos LB

```bash
az network lb create -g MyResourceGroup -n MyLb --sku Standard --frontend-ip-zone 1 --vnet-name MyVnet --subnet MySubnet
```

Añadimos backend pools

```bash
az network lb address-pool create -g MyResourceGroup --lb-name MyLb -n MyAddressPool --vnet {VnetResourceId} --backend-address name=addr1 ip-address=10.0.0.1 --backend-address name=addr2 ip-address=10.0.0.3
```

Creamos reglas de balanceo

```bash
az network lb rule create -g MyResourceGroup --lb-name MyLb -n MyLbRule --protocol Tcp \
    --frontend-ip-name MyFrontEndIp --frontend-port 80 \
    --backend-pool-name MyAddressPool --backend-port 80
```

Además se pueden añadir reglas NAT para enrutar directamente a través de puertos del LB a puertos de máquinas concretas para, por ejemplo, conectarse por SSH o RDP a una máquina concreta

```bash
az network lb inbound-nat-rule create -g MyResourceGroup --lb-name MyLb -n MyNatRule --protocol Tcp \
    --frontend-port 5432 --backend-port 3389 --frontend-ip-name MyFrontendIp --floating-ip true
```

El Load balancer realiza el balanceo a mediante el uso de la capa 4. Si se quiere hacer un balanceo robusto y basado en la capa 7 (con posibilidad de habilitar firewall incluso), se puede utlizar una [Application Gateway](https://docs.microsoft.com/es-es/cli/azure/network/application-gateway?view=azure-cli-latest)
