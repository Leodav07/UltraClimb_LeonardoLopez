extends Area2D

var speed = 300
var direction = 1

func set_direction(dir):
	direction = dir

func _physics_process(delta: float) -> void:
	position.x += speed * direction * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
		queue_free()
	elif not body.is_in_group("player"):
		queue_free()
