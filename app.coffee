#Simple node.js video streamer

PORT = 8080 #Listen port

#Create express app
express = require 'express'
app = express()
#Redis
redis = require 'redis'
client = redis.createClient()

#Configure express server
app.configure ->
	app.use require('connect-assets')() #online coffee compiling
	app.use express.static("#{__dirname}/public") #static files (videos)
	app.set 'views', "#{__dirname}/views" #views dir
	app.set 'view engine', 'ejs' #views engine

#Load nodeTube module
nodeTube = require('./nodeTube')

app.get '/', (req,res) ->
	client.lrange "ids",0,-1,(err,ids) ->
		videos = {}
		times = 1
		for id in ids
			client.get "videos:#{id}", (err,video) ->
				videos[id] = JSON.parse video
				if times == ids.length
					res.render "index", { videos: videos }
				times++

#Get some video
app.get '/video/:id', nodeTube

app.listen PORT
console.log "nodeTube playing on port #{PORT}"