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
var has_shield = false
var max_jump_count = 1
const BOOST_EFFECT = preload("res://Scenes/boostFX.tscn")
const GAME_OVER_SCENE = preload("res://Scenes/game_over.tscn")
const GAME_WIN_SCENE = preload("res://Scenes/winUI.tscn")
@export var throw_cooldown = 1
var current_scale_base = Vector2(1, 1)
var can_throw = true
var is_boss_mode = false
var win = false
const SKIN_RESOURCES = {
	"default": preload("res://Resources/SkinDefault.tres"),
	"pink": preload("res://Resources/SkinPinkMonster.tres"),
	"dude": preload("res://Resources/SkinDudeMonster.tres")
}
const PROJECTILE = preload("res://Scenes/projectilerock.tscn")
@onready var animated_coin = $"../../CanvasLayer/Coin"
@onready var JUMP_SOUND = $AudioStreamPlayer

@onready var animated_sprite = $AnimatedSprite

var direction = 1
var is_wall_sliding = false



func _ready():
	animated_sprite.flip_h = (direction < 0)
	floor_snap_length = 32.0
	load_current_skin()
	if GlobalData.boost_triple_jump:
		max_jump_count = 2 
	

	if GlobalData.boost_shield:
		has_shield = true
		modulate = Color(0.5, 0.5, 1, 1) 
		

	if GlobalData.boost_magnet:
		var area = Area2D.new()
		var shape = CollisionShape2D.new()
		var circle = CircleShape2D.new()
		circle.radius = 150 
		shape.shape = circle
		area.add_child(shape)
		area.name = "MagnetArea" 
		add_child(area)
		
	
func _physics_process(delta):
	if not is_boss_mode:
		if isdead or win:
			velocity = Vector2.ZERO
			return
			
			
		if not is_on_floor():
			velocity.y += GRAVITY * delta

		var on_wall = is_on_wall() and not is_on_floor()
		is_wall_sliding = on_wall and velocity.y > 0
		var pegado_a_muro_movil = false
		
		if on_wall:
			for i in get_slide_collision_count():
				var colision = get_slide_collision(i)
				var collider = colision.get_collider()
				
				if collider is AnimatableBody2D:
					
					velocity.y = colision.get_collider_velocity().y
				
					pegado_a_muro_movil = true
					break 


		if not pegado_a_muro_movil:
			is_wall_sliding = on_wall and velocity.y > 0
		else:
			is_wall_sliding = false
	
		if is_on_floor() or is_on_wall():
			jump_count = 0 
				
		if Input.is_action_just_pressed("jump_touch"):
			GlobalData.jumps += 1
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
			
			elif jump_count <= max_jump_count:
				var dust_instance = BOOST_EFFECT.instantiate()
				get_parent().add_child(dust_instance)
				dust_instance.global_position = global_position;
				dust_instance.get_node("AnimatedSprite2D").play("boost")
				JUMP_SOUND.play()
				velocity.y = -JUMP_SPEED * 1.1 
				direction *= -1 
				velocity.x = direction * WALL_JUMP_OFF 
				jump_count += 1
				
		if Input.is_action_just_released("jump_touch") and velocity.y < 0:
			velocity.y *= JUMP_CUT_MAGNITUDE
			GlobalData.jumps += 1
		
			
				
		if is_wall_sliding:
			velocity.y = min(velocity.y, WALL_SLIDE_SPEED)
			velocity.x = direction * 10
		elif not (Input.is_action_just_pressed("jump_touch") and on_wall):
		
			var target_vx = RUN_SPEED * direction
			velocity.x = lerp(velocity.x, target_vx, 0.1)

		
		animated_sprite.flip_h = (direction < 0)
	else:
		if isdead or win:
			velocity = Vector2.ZERO
			return
		move_classic(delta)

	update_animations()

	move_and_slide()

func move_classic(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * RUN_SPEED
		$AnimatedSprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, RUN_SPEED)
	
	if Input.is_action_just_pressed("jump_classic") and is_on_floor():
		GlobalData.jumps += 1
		velocity.y = -JUMP_SPEED
		GlobalAudio.play_SFX(preload("res://Music/cartoon-jump-6462.mp3"))
	
	if Input.is_action_just_pressed("throw_rock") and can_throw:
		throw_object()

func throw_object():
	can_throw = false

	var rock = PROJECTILE.instantiate()
	get_parent().add_child(rock)
	var dir = -1 if $AnimatedSprite.flip_h else 1
	rock.global_position = global_position + Vector2(20 * dir, 0)
	rock.set_direction(dir)
	GlobalAudio.play_SFX(preload("res://Music/throwstone.mp3"))
	await get_tree().create_timer(throw_cooldown).timeout
	can_throw = true

func activate_boss_mode():
	is_boss_mode = true
	velocity = Vector2.ZERO
	var player_camera = get_node_or_null("Camera2D")
	if player_camera:
		player_camera.enabled = false


	
func die():
	if has_shield:
		has_shield = false 
		GlobalData.boost_shield = false 
		modulate = Color(1, 1, 1, 1)
		GlobalAudio.play_SFX(preload("res://Music/boing.mp3")) 
		
		velocity.y = -300
		velocity.x = -200 * direction
		return
		
	if isdead:
		return
	isdead = true
	
	GlobalData.reset_boosts()
	velocity = Vector2.ZERO
	animated_sprite.play("die") 
	GlobalAudio.play_SFX(preload("res://Music/pixel-explosion-319166.mp3"))
	await animated_sprite. animation_finished
	show_gameover()
	
func winner():
	if win:
		return
	win = true
	
	velocity = Vector2.ZERO
	GlobalAudio.play_music(preload("res://Music/win.mp3"))
	show_win()
	
	
func show_gameover():
	GlobalData.total_coins += countCoins
	
	if GlobalData.score > GlobalData.highscore:
		GlobalData.highscore = GlobalData.score
	
	GlobalData.save_game()
	var game_overs = GAME_OVER_SCENE.instantiate()
	get_tree().root.add_child(game_overs)
	game_overs.show_stats(countCoins, GlobalData.score)
	
	get_tree().paused = true

func show_win():
	GlobalData.total_coins += countCoins
	
	if GlobalData.score > GlobalData.highscore:
		GlobalData.highscore = GlobalData.score
	
	GlobalData.save_game()
	var game_win = GAME_WIN_SCENE.instantiate()
	get_tree().root.add_child(game_win)
	game_win.show_stats(countCoins, GlobalData.score, GlobalData.jumps)
	
	#get_tree().paused = true

func update_animations():
	if(is_on_wall()):
		animated_sprite.play("slide") 
		if GlobalData.current_skin == "dude" or GlobalData.current_skin == "pink":
			animated_sprite.scale = current_scale_base * 0.15
		else:
			animated_sprite.scale = current_scale_base
			
		return
		
	animated_sprite.scale = current_scale_base
	
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")

		else:
				
			animated_sprite.play("fall")
		return
			
	
	if abs(velocity.x) > 0:
		animated_sprite.play("run")
	else:
		if not can_throw:
			animated_sprite.play("throw")
		else:
			animated_sprite.play("idle")

func load_current_skin():
	var skin_name = GlobalData.current_skin
	
	if SKIN_RESOURCES.has(skin_name):
		animated_sprite.sprite_frames = SKIN_RESOURCES[skin_name]
		animated_sprite.play("idle")
		if skin_name == "pink":
			current_scale_base = Vector2(1, 1)
			animated_sprite.position.y = 0
		elif skin_name == "dude":
			current_scale_base = Vector2(1, 1)
			animated_sprite.position.y = 0
		else:
			current_scale_base = Vector2(1, 1)
			animated_sprite.position.y = 0
			
		animated_sprite.scale = current_scale_base 
	else:
		print("No se encontro skin")
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			global_position = get_global_mouse_position()
			
			velocity = Vector2.ZERO
			
			jump_count = 0
			
			print("Debug: Teletransportado a ", global_position)
