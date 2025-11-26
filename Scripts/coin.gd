extends Area2D

@onready var coin = $coinAnimation


func _ready() -> void:
	coin.play()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		body.countCoins += 1
		GlobalAudio.play_SFX(preload("res://Music/coin-collect-retro-8-bit-sound-effect-145251.mp3"))
		self.queue_free()
	
	
