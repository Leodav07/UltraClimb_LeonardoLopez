extends CharacterBody2D

const GRAVITY = 500.0
const RUN_SPEED = 105.0
const JUMP_SPEED = 220.0 
const WALL_SLIDE_SPEED = 8.0
const WALL_JUMP_OFF = 150.0 
const JUMP_CUT_MAGNITUDE = 0.4
var jump_count = 0
var countCoins = 0
var isdead = false
const BOOST_EFFECT = preload("res://Scenes/boostFX.tscn")
const GAME_OVER_SCENE = preload("res://Scenes/game_over.tscn")

@onready var animated_coin = $"../../CanvasLayer/Coin"
@onready var JUMP_SOUND = $AudioStreamPlayer

@onready var animated_sprite = $AnimatedSprite

var direction = 1
var is_wall_sliding = false



func _ready():
	animated_sprite.flip_h = (direction < 0)
	
func _physics_process(delta):
	if isdead:
			velocity = Vector2.ZERO
			return
			
			
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var on_wall = is_on_wall() and not is_on_floor()
	is_wall_sliding = on_wall and velocity.y > 0

	if Input.is_action_just_pressed("jump_touch"):
		
		if is_on_floor():
			if is_on_wall():
				JUMP_SOUND.play()
				velocity.y = -JUMP_SPEED * 1.1 
				direction *= -1 
				velocity.x = direction * WALL_JUMP_OFF 
				jump_count+=1
			else:
				JUMP_SOUND.play()
				velocity.y = -JUMP_SPEED
				jump_count+=1
			
		elif on_wall:
			JUMP_SOUND.play()
			velocity.y = -JUMP_SPEED * 1.1 
			direction *= -1 
			velocity.x = direction * WALL_JUMP_OFF 
			is_wall_sliding = false 
			jump_count+=1
		
		elif jump_count >= 1:
			var dust_instance = BOOST_EFFECT.instantiate()
			get_parent().add_child(dust_instance)
			dust_instance.global_position = global_position;
			dust_instance.get_node("AnimatedSprite2D").play("boost")
			JUMP_SOUND.play()
			velocity.y = -JUMP_SPEED * 1.1 
			direction *= -1 
			velocity.x = direction * WALL_JUMP_OFF 
			jump_count = 0
			
	if Input.is_action_just_released("jump_touch") and velocity.y < 0:
		velocity.y *= JUMP_CUT_MAGNITUDE
	
		
			
	if is_wall_sliding:
		velocity.y = min(velocity.y, WALL_SLIDE_SPEED)
		velocity.x = direction * 10
	elif not (Input.is_action_just_pressed("jump_touch") and on_wall):
	
		var target_vx = RUN_SPEED * direction
		velocity.x = lerp(velocity.x, target_vx, 0.1)

	
	animated_sprite.flip_h = (direction < 0)

	update_animations()

	move_and_slide()

func die():
	if isdead:
		return
	isdead = true
	
	velocity = Vector2.ZERO
	animated_sprite.play("die") 
	GlobalAudio.play_SFX(preload("res://Music/pixel-explosion-319166.mp3"))
	await animated_sprite. animation_finished
	show_gameover()
	

func show_gameover():
	var game_overs = GAME_OVER_SCENE.instantiate()
	get_tree().root.add_child(game_overs)
	game_overs.show_stats(countCoins, GlobalData.score)
	
	get_tree().paused = true
	

func update_animations():
	if(is_on_wall()):
		animated_sprite.play("slide") 
		return

	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")

		else:
				
			animated_sprite.play("fall")
		return
			
	
	if abs(velocity.x) > 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			global_position = get_global_mouse_position()
			
			velocity = Vector2.ZERO
			
			jump_count = 0
			
			print("Debug: Teletransportado a ", global_position)
