extends Area2D
@onready var animated_sprite = $AnimatedSprite2D
var attacking = false
var max_hp = 8
var hp = 8
var attack_timer = 2.5
var timer_node = null
var battle_started
const PROJECTIL = preload("res://Scenes/fireball.tscn")
signal health_changed(new_value)

func _ready():
		animated_sprite.play("idle")
		
		body_entered.connect(_on_body_entered)


func start_battle():
	if battle_started: return 
	battle_started = true
	
	GlobalAudio.play_SFX(preload("res://Music/dragon.mp3"))
	
	timer_node = Timer.new()
	timer_node.wait_time = attack_timer
	timer_node.autostart = true
	timer_node.timeout.connect(_on_attack_timer)
	add_child(timer_node)
	
func take_damage():
	if not battle_started: return
	GlobalAudio.play_SFX(preload("res://Music/retro-hurt-1-236672.mp3"))
	hp -= 1
	health_changed.emit(hp)
	animated_sprite.play("hurt")
	await get_tree().create_timer(0.1).timeout
	
	if hp <= 0:
		GlobalAudio.play_SFX(preload("res://Music/retro-explode-2-236688.mp3"))
		die()
func die():
	attacking = true
	if timer_node != null:
		timer_node.stop()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	animated_sprite.play("die")
	await animated_sprite. animation_finished
	queue_free()
	

func _on_attack_timer():
	if hp <= 0:
		return
	animated_sprite.play("attack")
	
	var bullet = PROJECTIL.instantiate()
	get_parent().add_child(bullet)
	GlobalAudio.play_SFX(preload("res://Music/fireball.mp3"))
	bullet.global_position = global_position
	bullet.direction = -1
	await animated_sprite. animation_finished
	if hp > 0:
		animated_sprite.play("idle")
		GlobalAudio.play_SFX(preload("res://Music/dragon.mp3"))



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		body.die()
