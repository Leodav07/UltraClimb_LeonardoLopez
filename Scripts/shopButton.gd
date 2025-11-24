extends Button
const CLICK_SOUND = preload("res://Music/tapClick.mp3")

func _on_pressed() -> void:
 GlobalAudio.play_SFX(CLICK_SOUND)
 pass
