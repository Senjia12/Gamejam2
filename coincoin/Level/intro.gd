extends AnimationPlayer



func  _ready() -> void:
	if Globals.first_game:
		$ColorRect.show()
		$TextureRect.show()
		play("intro")
		Globals.first_game = false
	else:
		queue_free()
