const http = require('http')
const WebSocket = require('ws')
const colors = require('colors');


process.title = 'motion-tracker';

const WebSocketServerPort = '8080'
const ServerIP = '192.168.1.151'

const server = http.createServer(function(req, res) {
    console.log(`${(new Date().toLocaleString()).gray} ${'[Server]'.red}: Received request for ${req.url}`)
    res.writeHead(404)
    res.end()
})

server.listen(WebSocketServerPort, ServerIP, function() {
    console.log(`${(new Date().toLocaleString()).gray} ${'[Server]'.red} Listening on ${`${ServerIP}:${WebSocketServerPort}`.green}`)
})

function noop() {}

function heartbeat() {
  this.isAlive = true;
}

const wsServer = new WebSocket.Server({ server })

wsServer.on('connection', function connection(ws, req, client) {
    const ip = req.socket.remoteAddress

    ws.isAlive = true;
    ws.on('pong', heartbeat);

    console.log(`${(new Date().toLocaleString()).gray} ${'[Server]'.red} ${client} ${`connected`.green} with IP: ${ip}`)

    ws.on('close', function close() {
        console.log(`${(new Date().toLocaleString()).gray} ${'[Server]'.red} ${client} ${`disconnected`.red} with IP: ${ip}`)
    })

    ws.on('message', function incoming(message) {
        console.log(`${'[Server]'.red} ${'Recived message'.blue}: ${message}`)

        wsServer.clients.forEach(function each(client) {
            if (client != ws && client.readyState === WebSocket.OPEN) {
                client.send(message)
            }
        })
    })
})

const interval = setInterval(function ping() {
    wsServer.clients.forEach(function each(ws) {
      if (ws.isAlive === false) return ws.terminate();
  
      ws.isAlive = false;
      ws.ping(noop);
    });
  }, 30000);


wsServer.on('close', function close() {
    clearInterval(interval);
});
