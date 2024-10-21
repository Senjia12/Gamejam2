extends ColorRect

const CURSEUR_BASE = preload("res://UI/curseur base.png")
const EPEE = preload("res://UI/épée.png")
const BOTTE = preload("res://UI/botte.png")


func _physics_process(delta: float) -> void:
	global_position = Globals.player.global_position - Vector2(126,126)
	if Input.is_action_just_pressed("shift"):
		$spawn.play("spawn")
		$GPUParticles2D.emitting = true
		show()
		for i in $Area2D.get_overlapping_bodies():
			_on_area_2d_body_entered(i)
	elif Input.is_action_just_released("shift"):
		$GPUParticles2D.emitting = false
		$spawn.play_backwards("spawn")
		for i in $Area2D.get_overlapping_bodies():
			_on_area_2d_body_exited(i)
		Input.set_custom_mouse_cursor(CURSEUR_BASE)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Unit"):
		if is_visible_in_tree():
			body.in_night_arura = true
			Globals.unit_select.append(body)
			body.enabled()
			Input.set_custom_mouse_cursor(BOTTE,0,Vector2(16,16))

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Unit"):
		body.in_night_arura = false
		Globals.unit_select.erase(body)
		body.disabled()
		if Globals.unit_select != [body] and Globals.unit_select != []:
			Input.set_custom_mouse_cursor(CURSEUR_BASE)
