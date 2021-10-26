# Azure CLI Active Directory

## Ver usuarios disponibles

```bash
az ad user list
```

## Crear usuario

```bash
az ad user create --display-name 'nombre apellido apellido' --password P@ssword --user-principal-name nombre@dominio.com
```

Se puede añadir --force-change-password-next-login para que fuerce al usuario a cambiar de password al iniciar sesión

## Eliminar usuario

```bash
az ad user delete --id nombre@dominio.com
```

## Listar grupos

```bash
az ad group list
```

## Ver detalle de grupo

```bash
az ad group show --group MyGroupDisplayName
```

## Crear grupo

```bash
az ad group create --display-name MyGroupDisplayName --mail-nickname MyGroupDisplayName
```

## Gestionar usuarios en grupos

```bash
az ad group member list -g MyGroupDisplayName
az ad group member add -g MyGroupDisplayName --member-id 48d12666-6bd9-4da6-ac78-666e3ba5c7d7
az ad group member check -g MyGroupDisplayName --member-id 48d12666-6bd9-4da6-ac78-666e3ba5c7d7
az ad group member remove -g MyGroupDisplayName --member-id 48d12666-6bd9-4da6-ac78-666e3ba5c7d7
```

## Gestionar propietarios de grupos

```bash
az ad group owner add -g MyGroupDisplayName --member-id 48d12666-6bd9-4da6-ac78-666e3ba5c7d7
```
