$ ->
	$('.tile').click () ->
		$.facebox("""
			<div class="video-play">
				<video id="video_box" class="video-js vjs-default-skin" controls
  					preload="auto" width="640" height="360" poster="my_video_poster.png">
						<source src="/video/1" type='video/mp4'/>
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
		_V_.players = {}
		$('.video-play').remove()
  