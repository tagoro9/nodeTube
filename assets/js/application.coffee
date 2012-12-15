$ ->
	$('.tile').click () ->
		$.facebox("""
			<div class="video-play">
				<video class="video-js vjs-default-skin" controls preload=none width=640 height=264 poster="http://video-js.zencoder.com/oceans-clip.jpg">
					<source src="http://video-js.zencoder.com/oceans-clip.mp4" type='video/mp4'/>
					<source src="http://video-js.zencoder.com/oceans-clip.webm" type='video/webm'/>
					<track kind=captions src="/video-js/captions.vtt" srclang=en label=English />
				</video>
			</div>
			""")
	$(document).bind 'afterReveal.facebox', () ->
    	windowHeight = $(window).height()
    	faceboxHeight = $('#facebox').height()
    	if faceboxHeight < windowHeight
	        $('#facebox').css('top', (Math.floor((windowHeight - faceboxHeight) / 2) + $(window).scrollTop()) )

	$(document).bind 'afterClose.facebox', () ->
		$('.video-play').remove()
  