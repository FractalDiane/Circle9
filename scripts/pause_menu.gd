extends Control

signal menu_closed()

var close := false
var quit := false


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if close:
		emit_signal("menu_closed")
		queue_free()
	elif quit:
		get_tree().quit()
	else:
		$CanvasLayer/CenterContainer/VBoxContainer/ButtonResume.disabled = false
		$CanvasLayer/CenterContainer/VBoxContainer/ButtonExit.disabled = false


func _on_ButtonResume_pressed() -> void:
	$CanvasLayer/CenterContainer/VBoxContainer/ButtonResume.disabled = true
	$CanvasLayer/CenterContainer/VBoxContainer/ButtonExit.disabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	close = true
	$AnimationPlayer.play_backwards("fadein")


func _on_ButtonExit_pressed() -> void:
	$CanvasLayer/CenterContainer/VBoxContainer/ButtonResume.disabled = true
	$CanvasLayer/CenterContainer/VBoxContainer/ButtonExit.disabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	quit = true
	$AnimationPlayer.play_backwards("fadein")
