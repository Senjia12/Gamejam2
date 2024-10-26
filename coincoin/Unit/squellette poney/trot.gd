extends AudioStreamPlayer2D


func _physics_process(delta: float) -> void:
	if get_parent().velocity != Vector2.ZERO:
		play()
