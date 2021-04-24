extends CanvasLayer


onready var crosshair := $Control/CenterContainer/Crosshair as TextureRect

func show_crosshair(show: bool) -> void:
	crosshair.set_visible(show)
