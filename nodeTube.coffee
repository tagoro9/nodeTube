#Video streming handler

#Libraries needed
fs = require 'fs'

class nodeTube
	constructor: (req,res) -> #video id in req.param 'id'
		#log file requested
		stat = fs.statSync('./public/videos/truhan.mp4')
		console.log stat
		start = 0
		end = (stat.size) - 1
		range = req.header 'Range'
		console.log range
		res.writeHead 206, {
    		'Connection':'close'
    		'Content-Range':'bytes '+start+'-'+end+'/'+stat.size
    		'Transfer-Encoding':'chunked'
    	}
  		stream = fs.createReadStream './public/videos/truhan.mp4', flags: 'r', start: start, end: end
  		stream.pipe res    	

module.exports = nodeTube