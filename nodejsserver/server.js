var net = require('net');
    path = require('path');
var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')




app.listen(8080);

function handler(request, response) {
    //console.log('request starting...');
	var filePath = '.' + request.url;
	if (filePath == './')
		filePath = './index.html';
	var extname = path.extname(filePath);
	var contentType = 'text/html';
	switch (extname) {
		case '.js':
			contentType = 'text/javascript';
			break;
		case '.css':
			contentType = 'text/css';
			break;
	}
	
	path.exists(filePath, function(exists) {
	
		if (exists) {
			fs.readFile(filePath, function(error, content) {
				if (error) {
					response.writeHead(500);
					response.end();
				}
				else {
					response.writeHead(200, { 'Content-Type': contentType });
					response.end(content, 'utf-8');
				}
			});
		}
		else {
			response.writeHead(404);
			response.end();
		}
	});
}

var chatsocket = net.createConnection(10002, "futurict.local")


io.sockets.on('connection', function (socket) {
  socket.emit('news', { hello: 'world' });
    //console.log(this.transport)
  setInterval(function() {
      var clients = io.sockets.clients();
      //console.log(clients);
      for(var i=0; i<clients.length; i++) {
	var client = clients[i];
	  //client["id"];
	  //console.log(client.hasOwnProperty("activity"));
	  if(client.hasOwnProperty("activity")){
		  //console.log("send");
	      if(chatsocket != null){

		  chatsocket.write(client["id"]+"\n");
		  chatsocket.write(client["activity"]+"\n");
	      }
	  }
	  //cleint["test"];
      }
      //console.log(socket.id);
},200);
    
  socket.on('my other event', function (data) {
      
      //chatsocket.write(socket.id);
      //chatsocket.write(data);
      //var clients = io.sockets.clients();
      socket["activity"] = data.toString();
      
  });
});

