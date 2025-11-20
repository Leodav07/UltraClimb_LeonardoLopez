extends Button

@onready var AudioPlayer = $ButtonClickSettings
func _on_pressed() -> void:
	AudioPlayer.play()
	Trans.change_scene("res://Scenes/settings_menu.tscn")
