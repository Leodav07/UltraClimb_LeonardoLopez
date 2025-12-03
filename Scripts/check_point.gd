extends Area2D

var is_active = false

func _on_body_entered(body):
	# Si toca el jugador y no estaba activo
	if not is_active and (body.name == "Player" or body.is_in_group("player")):
		activate_checkpoint()

func activate_checkpoint():
	print("Checkpoint Activado en: ", global_position)
	is_active = true
	
	# --- CORRECCIÓN CLAVE ---
	# Guardamos SOLO la posición (X, Y) en el Global
	GlobalData.spawn_position = global_position
