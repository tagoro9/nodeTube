#Video streming handler

#Libraries needed
fs = require 'fs'

mimeTypes = {
".swf": "application/x-shockwave-flash",
	".flv": "video/x-flv",
	".mp4": "video/mp4",
	".avi": "video/x-msvideo",
	".mpa": "video/mpeg",
	".mpe": "video/mpeg",
	".mpeg": "video/mpeg",
	".mpg": "video/mpeg",
	".mpv2": "video/mpeg",
	".mov": "video/quicktime",
	".movie": "video/x-sgi-movie",
	".mp2": "video/mpeg",
	".qt": "video/quicktime",
}


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