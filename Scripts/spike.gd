extends Area2D


func _on_body_entered(body: Node2D) -> void:
		# DEBUG: Esto imprimirá en la consola qué objeto tocó el pincho
	print("El pincho tocó a: ", body.name)
	
	# Verificamos si es el jugador por NOMBRE, GRUPO o si tiene el MÉTODO die()
	if body.name == "Player" or body.is_in_group("player") or body.has_method("die"):
		print("¡Es el jugador! Ejecutando muerte...")
		if body.has_method("die"):
			body.die()
		else:
			print("ERROR: El jugador no tiene la función die()")
