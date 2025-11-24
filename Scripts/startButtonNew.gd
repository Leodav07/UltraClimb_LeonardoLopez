extends Button
const START_SOUND = preload("res://Music/GameStart.mp3")
func _on_pressed() -> void:
	GlobalAudio.play_SFX(START_SOUND)
	Trans.change_scene("res://Scenes/nivel_1.tscn")
	pass
