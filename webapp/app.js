var express = require('express')
const path = require('path')
var bodyParser = require('body-parser')
var fs =  require('fs')
const https = require("http") //https

require('dotenv').config({ path: path.join(__dirname, '../../.env') });

console.log(`path: `, path.join(__dirname, '../../.env'));
process.env.TZ = 'UTC';
const port = process.env.PORT || 8088;

var app = express()

app.use('/', express.static(path.join(__dirname, 'public')))
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views')
app.use(bodyParser.urlencoded({ extended: false }))

var facebookRouter = require('./facebook_routes.js')
app.use('/', facebookRouter)
app.set('trust proxy', true);

hostURL = process.env.HOST_URL || '127.0.0.1'

const server = app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});

process.on('SIGINT', () => {
    server.close(() => {
        console.log('Server shut down gracefully');
        process.exit(0);
    });
});

server.setTimeout(300000); // 5 min
server.keepAliveTimeout = 60000; // 1 min
server.headersTimeout = 300000;  // 5 min