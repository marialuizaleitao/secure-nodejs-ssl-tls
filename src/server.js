const https = require('https');
const fs = require('fs');
const path = require('path');

// Carrega os certificados
const options = {
  key: fs.readFileSync(path.resolve(__dirname, '../certs/server.key')),
  cert: fs.readFileSync(path.resolve(__dirname, '../certs/server.crt'))
};

// Cria o servidor HTTPS
https.createServer(options, (req, res) => {
  res.writeHead(200);
  res.end('Conexão segura estabelecida!\n');
}).listen(80, () => {
  console.log('Servidor HTTPS rodando na porta 80');
});
