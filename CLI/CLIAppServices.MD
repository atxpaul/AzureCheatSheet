# Azure CLI APP Services Plan

Con az appservice sólo se gestionan los planes, no los appservices en sí.

## Crear APP Service plan

```bash
az appservice plan create -g WebAPP -n MyApp --is-linux --sku F1 --no-wait
```

## Listar APP Services

```bash
az appservice plan list
```

Se puede filtrar con -g NombreGrupo

## Mostrar APP Service

```bash
az appservice plan show --name MyApp --resource-group WebAPP
```

## Borrar APP Service

```bash
az appservice plan delete --name MyApp --resource-group WebAPP
```

# Azure CLI APP Services webapp

# Listar WebApps

```bash
az webapp list
```

## Crear WebApp

Este es un ejemplo para levantar un nginx. Se puede establecer el runtime, el repositorio o incluso la imagen docker

```bash
az webapp create -p MyApp -g WebAPP -n randomNameTestATX -i nginx
az webapp create -p MyApp -g WebAPP -n Test-TDD --runtime "NODE|14-lts"
```

## Desplegar

```bash
az webapp deployment source config --name Test-TDD --resource-group WebAPP --repo-url https://github.com/atxpaul/test-tdd --branch main --manual-integration
```

## Ver despliegue con logs

```bash
az webapp browse -l --name Test-TDD --resource-group WebAPP
```

# Parar Webapp

```bash
az webapp stop -n Test-TDD -g WebAPP
```

# Borrar WebApp

```bash
az webapp delete -n Test-TDD -g WebAPP
```
