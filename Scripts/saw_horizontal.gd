extends Area2D
@export_group("Configuración de Rotación") 
@export var rotation_speed: float = 360.0 
@export var rotation_direction: int = 1 

@export_group("Configuración de Movimiento")
@export var move_speed: float = 75.0
@export var move_distance: float = 150.0
@onready var animated_sprite = $AnimatedSprite2D

var start_x: float = 0.0
var time_elapsed: float = 0.0

func _ready() -> void:
	start_x = position.x
	
func _process(delta):
	animated_sprite.play("Rotate")
	time_elapsed += delta
	var offset_x = sin(time_elapsed * move_speed / move_distance) * move_distance
	position.x = start_x + offset_x
	

func _on_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			get_tree().reload_current_scene()
