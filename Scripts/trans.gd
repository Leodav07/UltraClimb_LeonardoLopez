extends CanvasLayer
@onready var anim = $Control/AnimationPlayer


#func _ready():
	#layer = 1
	#get_node("AnimationPlayer").play("trans")
	#await ($AnimationPlayer. animation_finished)
	
	#layer = -1
	
func change_scene(path : String) -> void:
	#layer es para poner el canvaslayer delante del juego
	layer = 128
	#Reproducir la animacion: trans
	
	anim.play("trans")

	await ($Control/AnimationPlayer. animation_finished)

	#cambiar la escena
	get_tree().change_scene_to_file(path)
	anim.play_backwards("trans")
	
	await ($Control/AnimationPlayer. animation_finished)

	layer = -1
