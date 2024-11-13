var express = require('express')
var mongoose = require('mongoose')
var path = require('path')
var bodyParser = require('body-parser')
var fs =  require('fs')
const https = require("http") //https

require('dotenv').config();

mongoose.connect("mongodb://localhost/polidashboard")
mongoose.connection.once('open', function() {
    var port = 8000; //443;

    // you need to provide these files for the  ssl certificate if you use https/port:443
    // const options = {
    //     key: fs.readFileSync("./ssl-key.pem"),
    //     cert: fs.readFileSync("./ssl-cert.pem")
    // };

    var app = express()

    app.use('/', express.static(path.join(__dirname, 'public')))
    app.set('view engine', 'ejs');
    app.set('views', __dirname + '/views')
    app.use(bodyParser.urlencoded({ extended: false }))
	
    var facebookRouter = require('./facebook_routes.js')
    app.use('/', facebookRouter)
    
    var httpsServer = https.createServer(app); //options, app);
    httpsServer.listen(port)

    console.log(`listening on ${port}`)
})
