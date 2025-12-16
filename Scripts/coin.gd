extends Area2D

@onready var coin = $coinAnimation
var target_player = null
var magnet_speed = 400

func _ready() -> void:
	coin.play()
	
func _process(delta):

	if target_player:
		global_position = global_position.move_toward(target_player.global_position, magnet_speed * delta)
		
func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		body.countCoins += 100
		GlobalAudio.play_SFX(preload("res://Music/coin-collect-retro-8-bit-sound-effect-145251.mp3"))
		self.queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	if area.name == "MagnetArea":
		target_player = area.get_parent()
