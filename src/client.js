const https = require('https');
const fs = require('fs');
const path = require('path');

// Configurações de conexão segura
const options = {
  hostname: 'localhost',
  port: 80,
  path: '/',
  method: 'GET',
  rejectUnauthorized: false // aceita certificados autoassinados
};

// Conecta no servidor
const req = https.request(options, (res) => {
  res.on('data', (data) => {
    console.log('Resposta do servidor:', data.toString());
  });
});

req.on('error', (e) => {
  console.error(e);
});

req.end();
