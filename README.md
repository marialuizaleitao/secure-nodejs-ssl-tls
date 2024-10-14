# Aplicação Segura com Node.js e SSL/TLS com Autenticação Mútua

## Descrição
Este projeto implementa uma aplicação cliente-servidor utilizando o Node.js, com suporte a comunicação segura via SSL/TLS, além de autenticação mútua (mutual authentication). A comunicação é criptografada utilizando certificados digitais gerados por meio de um shell script que segue boas práticas de segurança.

## Objetivo
O objetivo deste projeto é demonstrar como desenvolver uma aplicação cliente-servidor com:
1. Certificação digital gerada via **OpenSSL**.
2. Comunicação segura utilizando **SSL/TLS**.
3. Implementação de **autenticação mútua** para validação tanto do cliente quanto do servidor.
4. Shell script para automatização do processo de geração de certificados, seguindo boas práticas de segurança.

## Conceitos Utilizados

### SSL/TLS
O SSL (Secure Sockets Layer) e o TLS (Transport Layer Security) são protocolos que fornecem criptografia de ponta a ponta para a comunicação em redes, garantindo a integridade e confidencialidade dos dados trocados entre cliente e servidor. O TLS é a versão mais recente e segura.

### Certificados Digitais
Os certificados digitais são usados para garantir a identidade do servidor e do cliente durante a comunicação segura. Eles são assinados por uma Autoridade Certificadora (CA), que garante sua autenticidade. Neste projeto, uma CA autoassinada foi criada para gerar os certificados do cliente e do servidor.

### Autenticação Mútua (Mutual Authentication)
Na autenticação mútua, tanto o servidor quanto o cliente precisam apresentar e validar os certificados um do outro. Isso garante que ambos os lados da conexão sejam confiáveis. O cliente precisa validar o certificado do servidor, e o servidor, o certificado do cliente.

### OpenSSL
O **OpenSSL** é uma biblioteca robusta de criptografia que permite a criação de certificados digitais. Utilizamos o OpenSSL para gerar certificados autoassinados e chaves privadas para o servidor e o cliente.

## Estrutura do Projeto

```bash
├── certs/                  # Certificados gerados
│   ├── ca.crt              # Certificado da CA
│   ├── ca.key              # Chave privada da CA
│   ├── client.crt          # Certificado do cliente
│   ├── client.key          # Chave privada do cliente
│   ├── server.crt          # Certificado do servidor
│   ├── server.key          # Chave privada do servidor
├── src/
│   ├── client.js           # Implementação do cliente com SSL/TLS e autenticação mútua
│   ├── server.js           # Implementação do servidor com SSL/TLS e autenticação mútua
├── generate_certs.sh       # Script para geração dos certificados
├── README.md               # Explicação do projeto
```
## Como Executar o Projeto

1. Geração de Certificados    
   Execute o script `generate_certs.sh` para gerar os certificados digitais para a CA, o servidor e o cliente.
    ```bash
    chmod +x generate_certs.sh
    ./generate_certs.sh
    ```

2. Iniciando o Servidor    
   Após gerar os certificados, inicie o servidor SSL/TLS com o comando:
    ```bash
    node src/server.js
    ```
    O servidor estará ouvindo na porta 80.

3. Iniciando o Cliente
    Por fim, inicie o cliente SSL/TLS com o comando:
      ```bash
      node src/client.js
      ```
      O cliente fará uma requisição ao servidor, que responderá com uma mensagem criptografada.

# Boas Práticas de Segurança
1. Shell Script Seguro    
   O script `generate_certs.sh` foi desenvolvido com foco em segurança, garantindo:
   - Validação de entradas do usuário para evitar dados incompletos ou inválidos.
   - Utilização de variáveis de ambiente e verificação da presença do OpenSSL.
   - Geração de certificados utilizando chaves seguras (RSA 2048 bits).
   - Exclusão de arquivos temporários após o uso para evitar vazamento de informações sensíveis.

2. Criptografia Forte    
   Foi utilizado o OpenSSL para gerar chaves privadas de 2048 bits, garantindo que a comunicação seja adequadamente criptografada.
   A comunicação entre cliente e servidor é criptografada utilizando TLS, o que garante que os dados trocados não possam ser interceptados ou modificados por terceiros.

3. Autenticação Mútua    
   O projeto utiliza autenticação mútua, onde tanto o cliente quanto o servidor devem apresentar certificados válidos. Isso garante a autenticidade de ambos os lados da comunicação e previne conexões não autorizadas.

# Testes de Segurança
1. Ferramentas de Teste        
   Para garantir que a comunicação está devidamente protegida, pode-se usar ferramentas como:
   - **Wireshark**: Para capturar e analisar pacotes de rede, garantindo que os dados estão sendo transmitidos de forma criptografada.
   - **SSL Labs**: Para testar a robustez das configurações SSL/TLS.
   - **OpenSSL**: Para verificar a validade dos certificados e a configuração da comunicação.
2. Autenticação Mútua          
   Ao utilizar a autenticação mútua, o servidor não aceitará conexões de clientes que não apresentem um certificado válido assinado pela mesma CA. Isso garante um nível adicional de segurança, prevenindo acessos indevidos.

# Autenticação Mútua
A autenticação mútua (mutual authentication) foi implementada tanto no cliente quanto no servidor. Com isso, ambas as partes validam os certificados uma da outra, elevando a segurança da aplicação a um novo nível. Caso um dos certificados não seja válido ou esteja ausente, a conexão será rejeitada.

# Conclusão
Este projeto demonstrou a implementação de uma aplicação cliente-servidor segura utilizando SSL/TLS, com foco na geração segura de certificados via shell script e na utilização de autenticação mútua. Seguindo as boas práticas de segurança, foi garantida uma comunicação criptografada e autenticada entre as partes.



