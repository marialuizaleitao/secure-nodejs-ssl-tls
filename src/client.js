const https = require('https');
const fs = require('fs');
const path = require('path');

// Configurações de conexão segura com autenticação mútua
const options = {
  hostname: 'localhost',
  port: 80,
  path: '/',
  method: 'GET',
  key: fs.readFileSync(path.resolve(__dirname, '../certs/client.key')),  // Chave privada do cliente
  cert: fs.readFileSync(path.resolve(__dirname, '../certs/client.crt')), // Certificado do cliente
  ca: fs.readFileSync(path.resolve(__dirname, '../certs/ca.crt')),  // Certificado da CA para verificar o servidor
  rejectUnauthorized: true  // Verifica o certificado do servidor
};

// Conecta-se ao servidor
const req = https.request(options, (res) => {
  res.on('data', (data) => {
    console.log('Resposta do servidor:', data.toString());
  });
});

req.on('error', (e) => {
  console.error('Erro na conexão segura:', e.message);
});

req.end();
