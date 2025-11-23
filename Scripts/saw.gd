extends Area2D
const ROTATION_DIRECTION = 1.0
const MOVEMENT_SPEED = 75.0
const MOVEMENT_DISTANCE = 30.0
@onready var animated_sprite = $AnimatedSprite2D
var start_y: float = 0.0
var time_elapsed: float = 0.0

func _ready() -> void:
	start_y = position.y
	
func _process(delta):
	animated_sprite.play("Rotate")
	time_elapsed += delta
	var offset_y = sin(time_elapsed * MOVEMENT_SPEED / MOVEMENT_DISTANCE) * MOVEMENT_DISTANCE
	position.y = start_y + offset_y
	



func _on_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			get_tree().reload_current_scene()
