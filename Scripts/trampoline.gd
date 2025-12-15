extends Area2D
@export var bounce_force = 450.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		body.velocity.y = -bounce_force
		GlobalAudio.play_SFX(preload("res://Music/boing.mp3"))
		
