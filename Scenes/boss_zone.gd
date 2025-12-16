extends Area2D
@onready var collision = $CollisionShape2D
@export var boss_camera : Camera2D
@export var boss_node : Area2D
@export var health_bar : ProgressBar
@export var playerNode : CharacterBody2D
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		body.activate_boss_mode()
		$"../CanvasLayer/BossControls".visible=true
		GlobalAudio.play_music(preload("res://Music/boss_final.mp3"))
		collision.global_position = Vector2(272.57, -115.868)
		if boss_camera:
			boss_camera.enabled = true
			boss_camera.make_current()
		if boss_node and boss_node.has_method("start_battle"):
			boss_node.start_battle()
			if health_bar:
				health_bar.visible = true
				health_bar.max_value = boss_node.max_hp 
				health_bar.value = boss_node.hp
				boss_node.health_changed.connect(_on_boss_health_changed)
func _on_boss_health_changed(new_hp):
	if health_bar:
		health_bar.value = new_hp
		if health_bar.value == 0:
			if playerNode and playerNode.has_method("winner"):
				playerNode.winner()
