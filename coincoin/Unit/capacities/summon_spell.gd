extends Node2D

const POTI_SQUELLETTE = preload("res://Unit/poti squellette/poti squellette.tscn")
const SQUELLETTE_ARCHER = preload("res://Unit/squellette archer/squellette_archer.tscn")
const SQUELLETTE_GROS = preload("res://Unit/gros quellette/squellette_gros.tscn")

var tier := 1
var spé := "cac"

var can_summon := true
var looking_for_spot := false

var squellette_number := 0


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("summon_spell") && can_summon:
		can_summon = false
		looking_for_spot = true
		$cd.start()
		squellette_number = 0
		
	if looking_for_spot:
		if $Area2D.get_overlapping_bodies() == []:
			squellette_number += 1
			if tier == 1:
				var poti_squellet = POTI_SQUELLETTE.instantiate()
				poti_squellet.global_position = $Area2D.global_position
				get_parent().get_parent().add_child(poti_squellet)
				if !Globals.night:
					poti_squellet.disabled()
				if squellette_number >= 3:
					looking_for_spot = false
			elif spé == "cac":
				var poti_squellet = SQUELLETTE_GROS.instantiate()
				poti_squellet.global_position = $Area2D.global_position
				get_parent().get_parent().add_child(poti_squellet)
				if !Globals.night:
					poti_squellet.disabled()
				if squellette_number >= (tier - 1) * 5:
					looking_for_spot = false
			elif spé == "range":
				var poti_squellet = SQUELLETTE_ARCHER.instantiate()
				poti_squellet.global_position = $Area2D.global_position
				get_parent().get_parent().add_child(poti_squellet)
				if !Globals.night:
					poti_squellet.disabled()
				if squellette_number >= (tier - 1) * 5:
					looking_for_spot = false
		else:
			$Area2D.global_position = global_position + Vector2(randi()%129 - 64,randi()%129 - 64)

func _on_cd_timeout() -> void:
	can_summon = true
