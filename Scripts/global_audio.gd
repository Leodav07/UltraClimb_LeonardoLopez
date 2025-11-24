extends Node
@onready var musicPlayer = $Music
@onready var sfxPlayer = $SFX

func play_music(audio_stream):
	musicPlayer.stop()
	musicPlayer.stream = audio_stream
	musicPlayer.play()

func play_SFX(audio_stream):
	sfxPlayer.stop()
	sfxPlayer.stream = audio_stream
	sfxPlayer.play()
