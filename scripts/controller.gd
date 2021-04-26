extends Node

const PAUSE_MENU = preload("res://prefabs/pause_menu.tscn")

var menu_open := false
var player_ref = null

var person_talking := false
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
		
	if player_ref != null:
		if not menu_open and player_ref.allow_input and not person_talking and Input.is_action_just_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			var menu := PAUSE_MENU.instance() as Control
			get_tree().get_root().add_child(menu)
			menu_open = true
			player_ref.set_allow_input(false)
			
			yield(menu, "menu_closed")
			
			player_ref.set_allow_input(true)
			menu_open = false
			
			
func fetch_player_ref() -> void:
	player_ref = get_tree().current_scene.get_node("Player")
		
		
func change_scene(scene: String, position: Vector3) -> void:
	get_tree().change_scene(scene)
	yield(get_tree(), "idle_frame")
	fetch_player_ref()
	if position != Vector3.ZERO:
		player_ref.set_translation(position)


func play_intro_music() -> void:
	$TimerIntroMusic.start()


func play_end_music() -> void:
	$MusicEnding.play()
	
	
func fade_end_music() -> void:
	var tween := $TweenEndMusicFade as Tween
	tween.interpolate_property($MusicEnding, "volume_db", -8, -60, 3.0)
	tween.start()
