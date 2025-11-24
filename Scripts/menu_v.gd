extends Node2D
const MUSIC_BACKGROUND = preload("res://Music/adventures-loop-music-226836.mp3")

func _ready() -> void:
	GlobalAudio.play_music(MUSIC_BACKGROUND)
	
