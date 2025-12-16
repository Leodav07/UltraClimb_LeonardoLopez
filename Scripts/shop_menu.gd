extends Node2D
@onready var labelCoin = $CanvasLayer/HUD/GridContainer/coinLabel
const COST_JUMP = 10
const COST_SHIELD = 20
const COST_MAGNET = 30
@onready var btn_jump = $CanvasLayer/HUD/Panel/triple
@onready var btn_shield = $CanvasLayer/HUD/Panel/triple/shield
@onready var btn_magnet = $CanvasLayer/HUD/Panel/triple/shield/iman
@onready var btn_owlet = $CanvasLayer/HUD/Panel2/default
@onready var btn_pink = $CanvasLayer/HUD/Panel2/default/pink
@onready var btn_dude = $CanvasLayer/HUD/Panel2/default/pink/dude
const COST_PINK = 35
const COST_DUDE = 50
func _ready() -> void:
	update_ui()


func update_ui():
	update_skin_button("pink", btn_pink, COST_PINK)
	update_skin_button("dude", btn_dude, COST_DUDE)
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
		
	if GlobalData.current_skin == "default":
		btn_owlet.text = "EQUIPPED"
		btn_owlet.disabled = true 
	else:
		btn_owlet.text = "EQUIP"
		btn_owlet.disabled = false

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

func update_skin_button(skin_name, button, cost):
	if skin_name == GlobalData.current_skin:
		button.text = "EQUIPPED"
		button.disabled = true
	elif skin_name in GlobalData.owned_skins:
		button.text = "EQUIP"
		button.disabled = false
	else:
		button.text = "BUY " + str(cost)
		if GlobalData.total_coins >= cost:
			button.disabled = false
		else:
			button.disabled = true


func _on_pink_pressed() -> void:
	var skin_name = "pink"

	if skin_name in GlobalData.owned_skins:
		GlobalAudio.play_SFX(preload("res://Music/tapClick.mp3"))
		GlobalData.current_skin = skin_name
		GlobalData.save_game()
		update_ui()
	elif GlobalData.total_coins >= COST_PINK:
		GlobalData.total_coins -= COST_PINK
		GlobalData.owned_skins.append(skin_name) 
		GlobalData.current_skin = skin_name
		GlobalAudio.play_SFX(preload("res://Music/coin-collect-retro-8-bit-sound-effect-145251.mp3"))
		GlobalData.save_game() 
		update_ui()

func _on_default_pressed() -> void:
	GlobalData.current_skin = "default"
	GlobalAudio.play_SFX(preload("res://Music/tapClick.mp3"))
	GlobalData.save_game() 
	update_ui()




func _on_dude_pressed() -> void:
	var skin_name = "dude"

	if skin_name in GlobalData.owned_skins:
		GlobalAudio.play_SFX(preload("res://Music/tapClick.mp3"))
		GlobalData.current_skin = skin_name
		GlobalData.save_game()
		update_ui()
	elif GlobalData.total_coins >= COST_DUDE:
		GlobalData.total_coins -= COST_DUDE
		GlobalData.owned_skins.append(skin_name) 
		GlobalData.current_skin = skin_name
		GlobalAudio.play_SFX(preload("res://Music/coin-collect-retro-8-bit-sound-effect-145251.mp3"))
		GlobalData.save_game() 
		update_ui()
