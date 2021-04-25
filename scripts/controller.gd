extends Node

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
		
		
func change_scene(scene: String, position: Vector3) -> void:
	get_tree().change_scene(scene)
	yield(get_tree(), "idle_frame")
	if position != Vector3.ZERO:
		get_tree().current_scene.get_node("Player").set_translation(position)


func play_intro_music() -> void:
	$TimerIntroMusic.start()
