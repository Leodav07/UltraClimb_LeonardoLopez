extends Button
const CLICK_SOUND = preload("res://Music/tapClick.mp3")

func _on_pressed() -> void:
 GlobalAudio.play_SFX(CLICK_SOUND)
 get_tree().change_scene_to_file("res://Scenes/settings_menu.tscn")
 pass
 
