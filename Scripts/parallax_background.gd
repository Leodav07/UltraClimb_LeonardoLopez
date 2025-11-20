extends ParallaxBackground


func _process(delta):
	
	var velocity = 80
	scroll_offset.x -= velocity * delta
	
