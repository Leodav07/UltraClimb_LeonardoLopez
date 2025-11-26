extends Node2D
@onready var coin_label = $CanvasLayer/Control/Panel/Panel/coin
@onready var record_label = $CanvasLayer/Control/Panel/Panel/record



func _on_ready() -> void:
	get_tree().paused = false
	
func show_stats(coins, record):
	coin_label.text = str(coins)
	record_label.text = str(record)

func _on_tryagain_pressed() -> void:
	GlobalAudio.play_SFX(preload("res://Music/tapClick.mp3"))
	get_tree().paused = false
	get_tree().reload_current_scene()
	self.queue_free()
	

func _on_home_pressed() -> void:
	GlobalAudio.play_SFX(preload("res://Music/tapClick.mp3"))
	get_tree().paused = false
	Trans.change_scene("res://Scenes/MenuV.tscn")
	self.queue_free()
