#Simple node.js video streamer

PORT = 80 #Listen port

#Create express app
express = require 'express'
app = express()
#Redis
redis = require 'redis'
client = redis.createClient()
#Async
async = require 'async'

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
		async.map ids.reverse(),
		(id,callback) ->
			client.get "videos:#{id}", (err,video) ->
				callback err, JSON.parse(video)
		,(err, videos) ->
			res.render "index", {videos: videos}

#Get some video
app.get '/video/:id', nodeTube

app.listen PORT
console.log "nodeTube playing on port #{PORT}"