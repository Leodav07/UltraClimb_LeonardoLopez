extends Button

@onready var AudioPlayer = $ButtonClickExit

func _on_pressed() -> void:
	AudioPlayer.play()
	
