extends AnimationPlayer


func _ready() -> void:
	_on_animation_finished("duck")


func _on_day_duration_timeout() -> void:
	Globals.night = true
	print("night")


func _on_animation_finished(anim_name: StringName) -> void:
	Globals.night = false
	print("day")
	$"day duration".start()
	play("day nighy")