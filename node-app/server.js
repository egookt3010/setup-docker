const express = require('express');
const redis = require('redis');
const app = express();

app.get('/', function(req, res) {
    res.send('Hello World');
});

app.listen(5000, function() {
    console.log('Web application is listening on port 5000');
});