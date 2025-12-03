extends Node

var last_location
var player
func _ready() -> void:
	player = $"../CharacterBody2D"
	last_location = player.global_position
	
