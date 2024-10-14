#!/bin/bash

# Verifica se o OpenSSL está instalado
if ! command -v openssl &> /dev/null
then
    echo "OpenSSL não encontrado. Por favor, instale o OpenSSL e tente novamente."
    exit
fi

# Pede as informações ao usuário
echo "Por favor, insira os detalhes para gerar o certificado."
read -p "Nome do domínio ou IP: " DOMAIN
read -p "Nome da organização: " ORGANIZATION
read -p "Cidade: " CITY
read -p "Estado: " STATE
read -p "País (código de dois dígitos): " COUNTRY

# Verifica se todas as entradas foram preenchidas
if [ -z "$DOMAIN" ] || [ -z "$ORGANIZATION" ] || [ -z "$CITY" ] || [ -z "$STATE" ] || [ -z "$COUNTRY" ]; then
    echo "Erro: Todas as entradas devem ser preenchidas."
    exit 1
fi

# Cria diretório para armazenar os certificados
mkdir -p certs

# Gera a chave e o certificado da Autoridade Certificadora (CA)
openssl genrsa -out certs/ca.key 2048
openssl req -x509 -new -nodes -key certs/ca.key -sha256 -days 1024 -out certs/ca.crt -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/CN=MyCA"

# Gera a chave privada e a solicitação de assinatura de certificado (CSR) do servidor
openssl genrsa -out certs/server.key 2048
openssl req -new -key certs/server.key -out certs/server.csr -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/CN=$DOMAIN"
openssl x509 -req -in certs/server.csr -CA certs/ca.crt -CAkey certs/ca.key -CAcreateserial -out certs/server.crt -days 365 -sha256

# Gera a chave privada e a CSR do cliente
openssl genrsa -out certs/client.key 2048
openssl req -new -key certs/client.key -out certs/client.csr -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/CN=Client"
openssl x509 -req -in certs/client.csr -CA certs/ca.crt -CAkey certs/ca.key -CAcreateserial -out certs/client.crt -days 365 -sha256

# Limpa arquivos temporários
rm certs/*.csr
echo "Certificados gerados com sucesso!"