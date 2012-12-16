#Video streming handler
#Libraries needed
fs = require 'fs'

isNumber = (n) ->
	!isNaN(parseFloat(n)) && isFinite(n)

class nodeTube
	constructor: (@req,@res) -> #video id in req.param 'id'	
		@info = {}
		console.log @req.param 'id'
		if @req.param('id') == '1'
			@info.path = './public/videos/truhan.mp4'
		else
			@info.path = './public/videos/basura.mp4'
		stat = fs.statSync @info.path

		@info.start = 0
		@info.end = stat.size - 1 
		@info.size = stat.size
		@info.modified = stat.mtime

		range = @req.headers.range
		if range?
			range = range.match(/bytes=(.+)-(.+)?/)
			@info.start = parseInt(range[1]) if range[1] >= 0 && range[1] < @info.end && isNumber(range[1])
			@info.end = parseInt(range[2]) if range[2] > @info.start && range[2] <= @info.end && isNumber(range[2])
			@info.length = @info.end - @info.start + 1

		res.writeHead 206, {
  			'Connection': 'close'
  			"Status" : "206 Partial Content"
  			"Accept-Ranges": "bytes"
  			'Content-Range':'bytes '+@info.start+'-'+@info.end+'/'+@info.size
  			"Last-Modified" : @info.modified.toUTCString()
  			"Content-Transfer-Encoding": "binary"
  			"Content.length": @info.length
  			'Transfer-Encoding':'chunked'
  		}
  		console.log "Start: #{@info.start} #### End: #{@info.end}"
		stream = fs.createReadStream @info.path, flags: 'r', start: @info.start, end: @info.end
		stream.pipe @res  	
		return true	

module.exports = nodeTube