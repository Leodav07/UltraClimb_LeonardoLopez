extends CharacterBody2D

const GRAVITY = 980.0
const RUN_SPEED = 150.0
const JUMP_SPEED = 250.0 
const WALL_SLIDE_SPEED = 30.0
const WALL_JUMP_OFF = 300.0 
var jump_count = 0
const BOOST_EFFECT = preload("res://boostFX.tscn")

@onready var JUMP_SOUND = $AudioStreamPlayer

@onready var animated_sprite = $AnimatedSprite

var direction = 1
var is_wall_sliding = false



func _ready():
	animated_sprite.flip_h = (direction < 0)

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var on_wall = is_on_wall() and not is_on_floor()
	is_wall_sliding = on_wall and velocity.y > 0

	if Input.is_action_just_pressed("jump_touch"):
		
		if is_on_floor():
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
			#dust_instance.z_index = -1
			dust_instance.get_node("AnimatedSprite2D").play("boost")
			JUMP_SOUND.play()
			velocity.y = -JUMP_SPEED * 1.1 
			direction *= -1 
			velocity.x = direction * WALL_JUMP_OFF 
			jump_count = 0
			
		
			
	if is_wall_sliding:
		velocity.y = min(velocity.y, WALL_SLIDE_SPEED)
		velocity.x = 0
	elif not (Input.is_action_just_pressed("jump_touch") and on_wall):
	
		var target_vx = RUN_SPEED * direction
		velocity.x = lerp(velocity.x, target_vx, 0.1)

	
	animated_sprite.flip_h = (direction < 0)

	update_animations()

	move_and_slide()

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
