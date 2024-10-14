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

# Gera o certificado autoassinado e a chave privada
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout certs/server.key -out certs/server.crt -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/CN=$DOMAIN"

echo "Certificado gerado com sucesso e salvo no diretório 'certs/'."
