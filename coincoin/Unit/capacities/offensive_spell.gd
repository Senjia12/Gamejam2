extends Node2D




var can_cast := true


var tier := 1
var state := "boom"
const BOULE_DE_FEU_T_1 = preload("res://Unit/capacities/offensif/boule_de_feu_t_1.tscn")
const BOULE_DE_FEU_T_2 = preload("res://Unit/capacities/offensif/boule_de_feu_t_2.tscn")


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("offensive_spell") && can_cast:
		if Globals.mana.cost(5):
			can_cast = false
			$cd.start()
			
			if state == "boom":
				if tier == 1:
					var projectile_instance = BOULE_DE_FEU_T_1.instantiate()
					projectile_instance.global_position = global_position
					projectile_instance.t_pos = get_global_mouse_position()
					get_parent().get_parent().add_child(projectile_instance)
				else:
					var projectile_instance = BOULE_DE_FEU_T_2.instantiate()
					projectile_instance.global_position = global_position
					projectile_instance.t_pos = get_global_mouse_position()
					projectile_instance.tier = tier
					get_parent().get_parent().add_child(projectile_instance)
			elif state == "ray":
				look_at(get_global_mouse_position())
				$ray.show()
				if tier == 2:
					$ray.play("t2")
					for i in $"ray t2".get_overlapping_bodies():
						if i.is_in_group("Humain"):
							i.take_damage(25)
				elif tier == 3:
					$ray.scale.x = 5
					$"ray t3".scale.x = 5
					$ray.play("t3")
					for i in $"ray t2".get_overlapping_bodies():
						if i.is_in_group("Humain"):
							i.take_damage(45)

func _on_cd_timeout() -> void:
	can_cast = true


func _on_ray_animation_finished() -> void:
	$ray.hide()
