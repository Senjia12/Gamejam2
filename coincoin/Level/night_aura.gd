extends ColorRect




func _physics_process(delta: float) -> void:
	global_position = Globals.player.global_position - Vector2(126,126)
	if Input.is_action_just_pressed("shift"):
		$spawn.play("spawn")
		$GPUParticles2D.emitting = true
	elif Input.is_action_just_released("shift"):
		$GPUParticles2D.emitting = false
		$spawn.play_backwards("spawn")
