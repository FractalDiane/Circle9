extends Area

signal opened()

export(String, FILE, "*.tscn") var target_scene: String
export(AudioStream) var door_sound: AudioStream

var in_area := false
var player_ref = null
var teleporting := false


func _process(_delta: float) -> void:
	if in_area and Input.is_action_just_pressed("interact"):
		emit_signal("opened")
		$SoundDoor.set_stream(door_sound)
		$SoundDoor.play()
		PlayerUI.show_interact(false, "Enter")
		if player_ref != null:
			player_ref.set_allow_input(false)
		
		PlayerUI.fadeout(true)
		teleporting = true
		$TimerTeleport.start()


func _on_Door_body_entered(body: Node) -> void:
	in_area = true
	player_ref = body
	PlayerUI.show_interact(true, "Enter")


func _on_Door_body_exited(_body: Node) -> void:
	in_area = false
	player_ref = null
	if not teleporting:
		PlayerUI.show_interact(false, "Enter")


func _on_TimerTeleport_timeout() -> void:
	get_tree().change_scene(target_scene)
	PlayerUI.fadeout(false)
