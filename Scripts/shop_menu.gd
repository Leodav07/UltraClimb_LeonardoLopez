extends Node2D
@onready var labelCoin = $CanvasLayer/HUD/GridContainer/coinLabel
const COST_JUMP = 10
const COST_SHIELD = 20
const COST_MAGNET = 30
@onready var btn_jump = $CanvasLayer/HUD/Panel/triple
@onready var btn_shield = $CanvasLayer/HUD/Panel/triple/shield
@onready var btn_magnet = $CanvasLayer/HUD/Panel/triple/shield/iman

func _ready() -> void:
	update_ui()


func update_ui():
	if labelCoin:
		labelCoin.text = str(GlobalData.total_coins)
	if GlobalData.boost_triple_jump:
		btn_jump.disabled = true
		btn_jump.text = "BOUGHT" 
	else:
		btn_jump.disabled = false
		btn_jump.text = "BUY " + str(COST_JUMP) + ""
	
	if GlobalData.boost_shield:
		btn_shield.disabled = true
		btn_shield.text = "BOUGHT"
	else:
		btn_shield.disabled = false
		btn_shield.text = "BUY " + str(COST_SHIELD) + ""

	if GlobalData.boost_magnet:
		btn_magnet.disabled = true
		btn_magnet.text = "BOUGHT"
	else:
		btn_magnet.disabled = false
		btn_magnet.text = "BUY " + str(COST_MAGNET) + ""

func _on_triple_pressed() -> void:
	if GlobalData.total_coins >= COST_JUMP and not GlobalData.boost_triple_jump:
		GlobalData.total_coins -= COST_JUMP
		GlobalData.boost_triple_jump = true
		GlobalAudio.play_SFX(preload("res://Music/coin-collect-retro-8-bit-sound-effect-145251.mp3"))
		update_ui()

func _on_shield_pressed() -> void:
	if GlobalData.total_coins >= COST_SHIELD and not GlobalData.boost_shield:
		GlobalData.total_coins -= COST_SHIELD
		GlobalData.boost_shield = true
		GlobalAudio.play_SFX(preload("res://Music/coin-collect-retro-8-bit-sound-effect-145251.mp3"))
		update_ui()

func _on_iman_pressed() -> void:
	if GlobalData.total_coins >= COST_MAGNET and not GlobalData.boost_magnet:
		GlobalData.total_coins -= COST_MAGNET
		GlobalData.boost_magnet = true
		GlobalAudio.play_SFX(preload("res://Music/coin-collect-retro-8-bit-sound-effect-145251.mp3"))
		update_ui()
