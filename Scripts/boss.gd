extends Area2D
@onready var animated_sprite = $AnimatedSprite2D
var attacking = false
var hp = 3
var attack_timer = 2.0
const PROJECTIL = preload("res://Scenes/fireball.tscn")
func _ready():
	animated_sprite.play("idle")
	GlobalAudio.play_SFX(preload("res://Music/dragon.mp3"))
	var timer = Timer.new()
	timer.wait_time = attack_timer
	timer.autostart = true
	timer.timeout.connect(_on_attack_timer)
	add_child(timer)
	body_entered.connect(_on_body_entered)
			
func take_damage():
	GlobalAudio.play_SFX(preload("res://Music/retro-hurt-1-236672.mp3"))
	hp -= 1
	animated_sprite.play("hurt")
	await get_tree().create_timer(0.1).timeout
	
	if hp <= 0:
		GlobalAudio.play_SFX(preload("res://Music/retro-explode-2-236688.mp3"))
		die()
func die():
	animated_sprite.play("die")
	queue_free()

func _on_attack_timer():
	animated_sprite.play("attack")
	
	var bullet = PROJECTIL.instantiate()
	get_parent().add_child(bullet)
	GlobalAudio.play_SFX(preload("res://Music/fireball.mp3"))
	bullet.global_position = global_position
	bullet.direction = -1
	await animated_sprite. animation_finished
	animated_sprite.play("idle")
	GlobalAudio.play_SFX(preload("res://Music/dragon.mp3"))



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		body.die()
