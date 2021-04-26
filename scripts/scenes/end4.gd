extends Spatial

func fade_music() -> void:
	Controller.fade_end_music()


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	get_tree().quit()
