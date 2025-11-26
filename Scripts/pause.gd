extends Node2D

func _on_ready() -> void:
	get_tree().paused = false
	
func _on_continue_pressed() -> void:
	GlobalAudio.play_SFX(preload("res://Music/tapClick.mp3"))
	get_tree().paused = false
	queue_free()

func _on_restart_pressed() -> void:
	GlobalAudio.play_SFX(preload("res://Music/tapClick.mp3"))
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free()

func _on_home_2_pressed() -> void:
	GlobalAudio.play_SFX(preload("res://Music/tapClick.mp3"))
	Trans.change_scene("res://Scenes/MenuV.tscn")
	
	get_tree().paused = false
	queue_free()
