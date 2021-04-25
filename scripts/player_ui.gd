extends CanvasLayer

onready var crosshair := $Control/CenterContainer/Crosshair as TextureRect


func fadeout(out: bool) -> void:
	var tween := $TweenFade as Tween
	tween.interpolate_property($Control/Fade, "color", Color(0, 0, 0, 0 if out else 1), Color(0, 0, 0, 1 if out else 0), 1, Tween.TRANS_CUBIC)
	tween.start()


func show_crosshair(show: bool) -> void:
	crosshair.set_visible(show)


func show_interact(show: bool, text: String) -> void:
	var tween := $Tween as Tween
	$TextInteract2/TextInteract.set_text(text)
	tween.interpolate_property($TextInteract2, "modulate", Color(1, 1, 1, 0 if show else 1), Color(1, 1, 1, 1 if show else 0), 0.5, Tween.TRANS_CUBIC)
	tween.start()
