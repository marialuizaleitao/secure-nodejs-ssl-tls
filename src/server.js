const https = require('https');
const fs = require('fs');
const path = require('path');

// Carrega os certificados do servidor e da CA
const options = {
  key: fs.readFileSync(path.resolve(__dirname, '../certs/server.key')),
  cert: fs.readFileSync(path.resolve(__dirname, '../certs/server.crt')),
  ca: fs.readFileSync(path.resolve(__dirname, '../certs/ca.crt')),  // Certificado da CA
  requestCert: true,   // Solicita o certificado do cliente
  rejectUnauthorized: true  // Rejeita clientes sem um certificado válido
};

// Cria o servidor HTTPS com autenticação mútua
https.createServer(options, (req, res) => {
  const clientCert = req.socket.getPeerCertificate();

  // Verifica se o cliente apresentou um certificado válido
  if (req.client.authorized) {
    res.writeHead(200);
    res.end('Conexão segura estabelecida com autenticação mútua!\n');
  } else if (clientCert.subject) {
    res.writeHead(403);
    res.end(`Certificado inválido: ${clientCert.subject.CN}\n`);
  } else {
    res.writeHead(401);
    res.end('Certificado do cliente não fornecido ou inválido.\n');
  }
}).listen(80, () => {
  console.log('Servidor HTTPS com autenticação mútua rodando na porta 80');
});
