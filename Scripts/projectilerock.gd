extends Area2D

var speed = 450
var direction = 1
func _ready():

	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func set_direction(dir):
	direction = dir

func _physics_process(delta: float) -> void:
	position.x += speed * direction * delta

func _on_body_entered(body: Node2D) -> void:
	
	if not body.is_in_group("player"): 
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage()
		queue_free() 
