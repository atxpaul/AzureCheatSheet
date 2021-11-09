# Roles

## Listar roles disponibles

Es recomendable usar el formato -o table

```bash
az role definition list
```

## Ver definición de un rol concreto

```bash
az role definition list --name "Contributor"
```

## Crear un rol personalizado

Se necesita de un json con los datos del rol:

```bash
{
  "Name": "Virtual Machine Operator",
  "IsCustom": true,
  "Description": "Can monitor and restart virtual machines.",
  "Actions": [
    "Microsoft.Storage/*/read",
    "Microsoft.Network/*/read",
    "Microsoft.Compute/*/read",
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/restart/action",
    "Microsoft.Authorization/*/read",
    "Microsoft.ResourceHealth/availabilityStatuses/read",
    "Microsoft.Resources/subscriptions/resourceGroups/read",
    "Microsoft.Insights/alertRules/*",
    "Microsoft.Support/*"
  ],
  "NotActions": [

  ],
  "AssignableScopes": [
    "/subscriptions/{subscriptionId1}",
    "/subscriptions/{subscriptionId2}"
  ]
}
```

Se crea usando el json

```bash
az role definition create --role-definition ~/roles/vmoperator.json
```

## Eliminar rol personalizado

```bash
az role definition delete --name "Virtual Machine Operator"
```
