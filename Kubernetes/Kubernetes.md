# Azure Kubernetes Service (AKS)

## Crear AKS vía CLI

Nota: Se necesita un RG previo

```bash
az aks create \
-g $RG_NAME \
-n $CLUSTER_NAME \
--enable-managed-identity \
-c 3 \
--ssh-key-value /home/$USER/.ssh/id_rsa.pub \
-k 1.19.7 \
--enable-cluster-autoscaler \
--min-count 3 \
--max-count 5 \
--load-balancer-sku standard
```

## Crear AKS vía Terraform

Ver [Terraform](Kubernetes/Terraform/main.tf)
