extends ColorRect









func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		if !is_visible_in_tree():
			show()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false


func _on_resume_pressed() -> void:
	hide()
	get_tree().paused = false
