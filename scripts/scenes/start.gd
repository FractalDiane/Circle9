extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	Controller.play_intro_music()


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	get_tree().change_scene("res://scenes/game/outside.tscn")
