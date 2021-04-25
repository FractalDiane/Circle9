extends Spatial

export(Array, String, MULTILINE) var dialogue_subtitles := []
export(Array, AudioStream) var dialogue_audio := []

var in_area := false
var talking := false

var dialogue_page := 0

onready var dialogue_player := $SoundDialogue as AudioStreamPlayer
onready var dialogue_text := $UI/Control/DialogueText as Label


func _process(_delta: float) -> void:
	if in_area and not talking and Input.is_action_just_pressed("interact"):
		talking = true
		$SoundInteract.play()
		$UI/AnimationPlayer.play("fadein")
		PlayerUI.show_interact(false, "Listen")
		$TimerDialogue.start()
		
		
func play_dialogue() -> void:
	var clip := dialogue_audio[dialogue_page] as AudioStream
	dialogue_text.set_text(dialogue_subtitles[dialogue_page])
	dialogue_text.show()
	dialogue_player.set_stream(clip)
	dialogue_player.play()


func _on_Area_body_entered(_body: Node) -> void:
	in_area = true
	PlayerUI.show_interact(true, "Listen")


func _on_Area_body_exited(_body: Node) -> void:
	in_area = false
	if not talking:
		PlayerUI.show_interact(false, "Listen")


func _on_SoundDialogue_finished() -> void:
	if dialogue_page < len(dialogue_audio) - 1:
		dialogue_page += 1
		play_dialogue()
	else:
		talking = false
		dialogue_page = 0
		dialogue_text.hide()
		$UI/AnimationPlayer.play_backwards("fadein")
		if in_area:
			PlayerUI.show_interact(true, "Listen")


func _on_TimerDialogue_timeout() -> void:
	play_dialogue()
