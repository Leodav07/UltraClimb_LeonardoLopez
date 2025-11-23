extends Node2D
@onready var player = $TilemapLayers/CharacterBody2D
@onready var scoreLabel = $CanvasLayer/Control/ScoreLabel
@onready var AudioPlayer = $AudioStreamPlayer
const PIXEL_PER_POINT = 50
var start_y = 0
func _ready() -> void:
	AudioPlayer.play()
	if player:
		start_y = player.global_position.y
	
func _process(delta):
	if player:
		var current_height = start_y - player.global_position.y
		var score = floor(current_height / PIXEL_PER_POINT)
		if score < 0: score = 0
		scoreLabel.text = str(score)
	
 
