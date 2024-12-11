var express = require('express')
var mongoose = require('mongoose')
var path = require('path')
var bodyParser = require('body-parser')
var fs =  require('fs')
const https = require("http") //https

require('dotenv').config();

mongoose.connect("mongodb://localhost:27017/polidashboard");

mongoose.connection.once('open', function() {
    var port = 8080; // Or set to any open port of your choice;

    var app = express()

    app.use('/', express.static(path.join(__dirname, 'public')))
    app.set('view engine', 'ejs');
    app.set('views', __dirname + '/views')
    app.use(bodyParser.urlencoded({ extended: false }))
	
    var facebookRouter = require('./facebook_routes.js')
    app.use('/', facebookRouter)
    
    app.listen(port, '127.0.0.1', () => {
        console.log('Node.js app is running on port ' + port); // DEBUG
    });
})