extends HSlider
var music_bus : int

func _ready() -> void:
	music_bus = AudioServer.get_bus_index("SFX")
	value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	value_changed.connect(_on_value_changed)
	
func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(new_value))
	GlobalData.save_game()
