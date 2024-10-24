extends ColorRect

const CURSEUR_BASE = preload("res://UI/curseur base.png")
const EPEE = preload("res://UI/épée.png")
const BOTTE = preload("res://UI/botte.png")
@onready var area_2d: Area2D = $"../Area2D"

var activate := false

var tier := ""


func scale_up(scale_mult):
	scale *= scale_mult
	$"../Area2D".scale *= scale_mult
	


func _physics_process(delta: float) -> void:
	area_2d.global_position = Globals.player.global_position
	$"../humain detect".global_position = area_2d.global_position
	global_position = Globals.player.global_position - Vector2(126,126) * scale.x
	if Input.is_action_just_pressed("shift"):
		if !activate && !Globals.night:
			activate = true
			$spawn.play("spawn")
			$GPUParticles2D.emitting = true
			show()
			for i in $"../Area2D".get_overlapping_bodies():
				_on_area_2d_body_entered(i)
		elif activate:
			activate = false
			$GPUParticles2D.emitting = false
			$spawn.play_backwards("spawn")
			for i in $"../Area2D".get_overlapping_bodies():
				_on_area_2d_body_exited(i)
			Input.set_custom_mouse_cursor(CURSEUR_BASE)


func disable():
	activate = false
	$GPUParticles2D.emitting = false
	$spawn.play_backwards("spawn")
	for i in $"../Area2D".get_overlapping_bodies():
		_on_area_2d_body_exited(i)
	Input.set_custom_mouse_cursor(CURSEUR_BASE)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Unit"):
		if is_visible_in_tree():
			body.show_marqueur()
			body.in_night_arura = true
			Globals.unit_select.append(body)
			body.enabled()
			Input.set_custom_mouse_cursor(BOTTE,0,Vector2(16,16))

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Unit") && !Globals.night:
		body.hide_marqueur()
		body.in_night_arura = false
		Globals.unit_select.erase(body)
		body.disabled()
		if Globals.unit_select != [body] and Globals.unit_select != []:
			Input.set_custom_mouse_cursor(CURSEUR_BASE)


func _on_timer_timeout() -> void:
	if tier == "regen":
		for i in $"../Area2D".get_overlapping_bodies():
			if i.is_in_group("Unit"):
				if i.max_hp < i.current_hp:
					i.current_hp += 1
	else:
		if tier == "slow":
			for i in $"../humain detect".get_overlapping_bodies():
				if i.is_in_group("Humain"):
					i.real_speed = i.speed / 2
		if tier == "dmg":
			for i in $"../humain detect".get_overlapping_bodies():
				if i.is_in_group("Humain"):
					i.take_damage(5)
