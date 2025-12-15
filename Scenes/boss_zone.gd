extends Area2D
@onready var collision = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		body.activate_boss_mode()
		$"../CanvasLayer/BossControls".visible=true
		GlobalAudio.play_music(preload("res://Music/boss_final.mp3"))
		collision.global_position = Vector2(272.57, -115.868)
