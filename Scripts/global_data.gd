extends Node

var score = 0
var jumps = 0
var total_coins : int
var highscore = 0
var owned_skins = ["default"]
var current_skin = "default"
var boost_triple_jump = false
var boost_shield = false
var boost_magnet = false

const SAVE_PATH = "user://gameprogress.json"

func _ready() -> void:
	load_game()

func reset_boosts():
	boost_triple_jump = false
	boost_shield = false
	boost_magnet = false

func save_game():
	var master_idx = AudioServer.get_bus_index("Master")
	var music_idx = AudioServer.get_bus_index("Music")
	var sfx_idx = AudioServer.get_bus_index("SFX")
	
	var master_volumen = AudioServer.get_bus_volume_db(master_idx)
	var music_volumen = AudioServer.get_bus_volume_db(music_idx)
	var sfx_volumen = AudioServer.get_bus_volume_db(sfx_idx)
	
	var data = {"total_coins": total_coins, "highscore": highscore, "master_volumen": master_volumen, "music_volumen": music_volumen, "sfx_volumen": sfx_volumen, "owned_skins": owned_skins, "current_skin": current_skin}
	var json_string = JSON.stringify(data)
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(json_string)
	file.close()

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(json_string)
	
	if data == null or not (data is Dictionary):
		print("Error al leer el archivo")
		return
		
	
	total_coins = data.get("total_coins", 0)
	highscore = data.get("highscore", 0)
	var master_idx = AudioServer.get_bus_index("Master")
	var music_idx = AudioServer.get_bus_index("Music")
	var sfx_idx = AudioServer.get_bus_index("SFX")
	if data.has("master_volumen"):
		AudioServer.set_bus_volume_db(master_idx, data["master_volumen"])
	
	if data.has("music_volumen"):
		AudioServer.set_bus_volume_db(music_idx, data["music_volumen"])
	
	if data.has("sfx_volumen"):
		AudioServer.set_bus_volume_db(sfx_idx, data["sfx_volumen"])
	
	if "owned_skins" in data: owned_skins = data["owned_skins"]
	if "current_skin" in data: current_skin = data["current_skin"]
	
