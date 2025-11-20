extends Node2D

@onready var AudioPlayer = $AudioStreamPlayer
func _ready() -> void:
	AudioPlayer.play()
 
