extends Area2D
var checkpoint_manager
var player
func _ready() -> void:
	checkpoint_manager = $"../CheckPointManager"
	player = $"../CharacterBody2D"
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player"): #or body.has_method("die"):
		player.position = checkpoint_manager.last_location
		#if body.has_method("die"):
			#body.die()
