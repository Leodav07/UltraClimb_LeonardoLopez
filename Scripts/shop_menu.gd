extends Node2D
@onready var labelCoin = $CanvasLayer/HUD/GridContainer/coinLabel

func _ready() -> void:
	labelCoin.text = str(GlobalData.total_coins)
