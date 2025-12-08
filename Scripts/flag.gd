extends Area2D
@onready var flagcolor = $Flag

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flagcolor.play("red_flag")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		GlobalAudio.play_SFX(preload("res://Music/flaggrabbed.mp3"))
		flagcolor.play("green_flag")
		
