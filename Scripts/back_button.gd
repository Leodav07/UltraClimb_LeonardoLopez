extends Button

@onready var audioButton = $ButtonClickBack

func _on_pressed() -> void:
	audioButton.play()
	get_tree().change_scene_to_file("res://Scenes/MenuV.tscn")
