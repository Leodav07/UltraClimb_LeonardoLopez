extends Button
@onready var audioPlayer = $ButtonClickSettings

func _on_pressed() -> void:
 audioPlayer.play()
 await audioPlayer.finished
 get_tree().change_scene_to_file("res://Scenes/settings_menu.tscn")
 pass
 
