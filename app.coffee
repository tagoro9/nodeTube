#Simple node.js video streamer

PORT = 8080 #Listen port

#Create express app
express = require 'express'
app = express()

#Configure express server
app.configure ->
	app.use require('connect-assets')() #online coffee compiling
	app.use express.static("#{__dirname}/public") #static files (videos)
	app.set 'views', "#{__dirname}/views" #views dir
	app.set 'view engine', 'ejs' #views engine

#Load nodeTube module
nodeTube = require './nodeTube'

app.get '/', (req,res) ->
	res.render "index"

#Get some video
app.get '/video/:id', nodeTube

app.listen PORT
console.log "nodeTube playing on port #{PORT}"