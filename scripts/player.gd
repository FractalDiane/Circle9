extends KinematicBody

const NINETY_RAD := deg2rad(90)

export(float) var speed := 5.0
export(bool) var allow_input := true

var motion := Vector3()


onready var camera := $Camera as Camera


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.set_rotation(Vector3(0, 0, 0))
	
	if allow_input:
		PlayerUI.show_crosshair(true)


func _physics_process(delta: float) -> void:
	if allow_input:
		var cam_xform := camera.get_global_transform()
		var motion_target := Vector3()
		motion_target += -cam_xform.basis[2] * Input.get_action_strength("move_forward")
		motion_target += cam_xform.basis[2] * Input.get_action_strength("move_back")
		motion_target += -cam_xform.basis[0] * Input.get_action_strength("move_left")
		motion_target += cam_xform.basis[0] * Input.get_action_strength("move_right")
		
		motion_target.y = 0
		motion = motion.linear_interpolate(motion_target, 8 * delta)
	else:
		motion = Vector3.ZERO
	
	move_and_slide(motion * speed, Vector3.UP)
	

func _input(event: InputEvent) -> void:
	if allow_input and event is InputEventMouseMotion:
		rotate_camera(event.get_relative() * get_physics_process_delta_time() * 0.12)
		
		
func rotate_camera(move: Vector2) -> void:
	var rot := camera.get_rotation()
	rot.x = clamp(rot.x - move.y, -NINETY_RAD, NINETY_RAD)
	rot.y -= move.x
	rot.z = 0
	camera.set_rotation(rot)
	
	
func set_allow_input(value: bool) -> void:
	allow_input = value
	PlayerUI.show_crosshair(value)
