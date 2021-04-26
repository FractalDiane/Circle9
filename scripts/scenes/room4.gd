extends Spatial

func ending() -> void:
	Controller.player_ref.set_allow_input(false)
	$Sound.play()
	$AnimationPlayer.play("animation")


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	Controller.change_scene("res://scenes/game/end1.tscn", Vector3.ZERO)
	Controller.play_end_music()
