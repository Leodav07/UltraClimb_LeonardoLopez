extends Node2D
@onready var player = $CharacterBody2D
@onready var scoreLabel = $CanvasLayer/Control/ScoreLabel
@onready var coinLabel = $CanvasLayer/Control/coinLabel
@onready var recordLabel = $CanvasLayer/Control/recordLabel
const MUSIC_BACKGROUND_PLAY = preload("res://Music/backgroundmusicforgame.mp3")
const PIXEL_PER_POINT = 50
var start_y = 0
var record = 0
var score = 0
func _ready() -> void:
	GlobalAudio.play_music(MUSIC_BACKGROUND_PLAY)
	if player:
		start_y = player.global_position.y
	
func _process(delta):
	if player:
		var current_height = start_y - player.global_position.y
		score = floor(current_height / PIXEL_PER_POINT)
		if score < 0: score = 0
		scoreLabel.text = str(score)
		coinLabel.text = str(player.countCoins)
		
	if(record<score):
		record = score
	recordLabel.text = str(record)
		
			

	
 
