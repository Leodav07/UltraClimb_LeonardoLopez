extends Node2D
@onready var player = $TilemapLayers/CharacterBody2D
@onready var scoreLabel = $CanvasLayer/ScoreLabel
const MUSIC_BACKGROUND_PLAY = preload("res://Music/backgroundmusicforgame.mp3")
const PIXEL_PER_POINT = 40
var start_y = 0
func _ready() -> void:
	GlobalAudio.play_music(MUSIC_BACKGROUND_PLAY)
	if player:
		start_y = player.global_position.y
	
func _process(delta):
	if player:
		var current_height = start_y - player.global_position.y
		var score = floor(current_height / PIXEL_PER_POINT)
		if score < 0: score = 0
		scoreLabel.text = str(score)
	
 
