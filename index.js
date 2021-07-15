/*
    SETUP
*/
var express = require('express');
var app = express();
PORT = 9124;

/*
    ROUTES
*/
app.get('/', function(req, res)
    {
        res.sendFile('views/main.html', {root: __dirname })
    });

/*
    LISTENER
*/
app.listen(PORT, function(){
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});
