extends Node2D
@onready var playMusic = $BackgroundMusic

func _ready() -> void:
	playMusic.play()
