# LEIAME

## Conexão aks

az account set --subscription 2783b349-a076-405b-b47a-90095f330d7c
az aks get-credentials --resource-group rg-desafio-gov-br --name aks-desafio-gov-br --overwrite-existing

## Login no ACR

```bash
az acr login --name acrdesafiogovb
```

## Criar a imagem(build) e enviar para o acr(push)

**Docker build**

```bash
docker build -t acrdesafiogovbr.azurecr.io/meu-website:v0.1 .

**Docker push**

docker push acrdesafiogovbr.azurecr.io/meu-website:v0.5
```

## Atualização do AKS para permitir o mesmo realizar push no ACR

```bash
az aks update \
  --resource-group rg-desafio-gov-br \
  --name aks-desafio-gov-br \
  --attach-acr acrdesafiogovbr
```

## Criar service principal para acessar o acr

```bash
az ad sp create-for-rbac --name "my-github-actions-sp" --role acrpush --scopes /subscriptions/2783b349-a076-405b-b47a-90095f330d7c/resourceGroups/rg-desafio-gov-br/providers/Microsoft.ContainerRegistry/registries/acrdesafiogovbr
```

## Atualização do service principal já existente

- Caso já exista um service principal criado você pode atualizar com o comando abaixo

```bash
az role assignment create \
  --assignee a4068654-5b21-4a09-9094-86794732ed5c \
  --role acrpush \
  --scope /subscriptions/2783b349-a076-405b-b47a-90095f330d7c/resourceGroups/rg-desafio-gov-br/providers/Microsoft.ContainerRegistry/registries/acrdesafiogovbr
```
