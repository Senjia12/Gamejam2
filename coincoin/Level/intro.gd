extends AnimationPlayer



func  _ready() -> void:
	if Globals.first_game:
		$ColorRect.show()
		$TextureRect.show()
		Globals.first_game = false
	else:
		queue_free()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		play("intro")


func _on_animation_finished(anim_name: StringName) -> void:
	queue_free()
