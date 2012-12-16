$ ->
	player = _V_ 'video_box'
	$('.tile').click (e) ->
		player.src window.location + $(this).data 'url'

  