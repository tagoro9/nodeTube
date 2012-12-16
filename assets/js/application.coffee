$ ->
	$('.tile').click () ->
		$.facebox("""
			<div class="video-play">
				<video id="video_box" class="video-js vjs-default-skin" controls
  					preload="auto" width="640" height="264" poster="my_video_poster.png">
						<source src="http://video-js.zencoder.com/oceans-clip.mp4" type='video/mp4'/>
					<source src="http://video-js.zencoder.com/oceans-clip.webm" type='video/webm'/>
				</video>
			</div>
			""")
	$(document).bind 'afterReveal.facebox', () ->
		_V_ "video_box", {}, () ->
    	windowHeight = $(window).height()
    	faceboxHeight = $('#facebox').height()
    	if faceboxHeight < windowHeight
	        $('#facebox').css('top', (Math.floor((windowHeight - faceboxHeight) / 2) + $(window).scrollTop()) )

	$(document).bind 'afterClose.facebox', () ->
		$('.video-play').remove()
  