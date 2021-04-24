extends Node

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen


func play_intro_music() -> void:
	$TimerIntroMusic.start()
