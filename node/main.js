//let : variable, const : constant

const PORT = 3000;
const http = require('http');
const fs = require('fs');
const app = http.createServer(function(request,response){
    const url = request.url;
    if(request.url == '/'){
      url = '/index.html';
    }
    if(request.url == '/favicon.ico'){
        response.writeHead(404);
        response.end();
        return;
    }
    response.writeHead(200);
    response.end(fs.readFileSync(__dirname + url));
 
});
app.listen(PORT);