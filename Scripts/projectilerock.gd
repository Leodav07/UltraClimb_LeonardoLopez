extends Area2D

var speed = 450
var direction = 1

func set_direction(dir):
	direction = dir

func _physics_process(delta: float) -> void:
	position.x += speed * direction * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()
	else:
		queue_free()
