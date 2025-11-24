extends Area2D

@onready var coin = $coinAnimation


func _ready() -> void:
	coin.play()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		body.countCoins += 1
		self.queue_free()
	
	
