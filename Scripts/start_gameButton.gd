extends Button
@onready var AudioPlayer = $ButtonClickStart
func _on_pressed() -> void:
	AudioPlayer.play()
	Trans.change_scene("res://Scenes/nivel_1.tscn")
	pass
