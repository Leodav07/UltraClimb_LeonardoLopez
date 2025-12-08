extends AnimatableBody2D

@export var distancia_viaje : Vector2 = Vector2(0, -200) 
@export var duracion : float = 2.0

func _ready():
	mover_plataforma()

func mover_plataforma():
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	
	tween.tween_property(self, "position", position + distancia_viaje, duracion)
	tween.tween_property(self, "position", position, duracion)
	
	tween.set_loops()
