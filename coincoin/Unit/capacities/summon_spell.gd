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
<<<<<<< Updated upstream
		looking_for_spot = true
		$cd.start()
		squellette_number = 0
=======
		nb_summon_spell += 1
		$summon_spell_cd.start()
>>>>>>> Stashed changes
		
	if looking_for_spot:
		if $Area2D.get_overlapping_bodies() == []:
			squellette_number += 1
			if tier == 1:
				if Globals.bone_counter.cost(2):
					var poti_squellet = POTI_SQUELLETTE.instantiate()
					poti_squellet.global_position = $Area2D.global_position
					get_parent().get_parent().add_child(poti_squellet)
					if !Globals.night:
						poti_squellet.disabled()
				if squellette_number >= 3:
					looking_for_spot = false
			elif spé == "cac":
				if Globals.bone_counter.cost(10):
					var poti_squellet = SQUELLETTE_GROS.instantiate()
					poti_squellet.global_position = $Area2D.global_position
					get_parent().get_parent().add_child(poti_squellet)
					if !Globals.night:
						poti_squellet.disabled()
				if squellette_number >= (tier - 1) * 5:
					looking_for_spot = false
			elif spé == "range":
				if Globals.bone_counter.cost(5):
					var poti_squellet = SQUELLETTE_ARCHER.instantiate()
					poti_squellet.global_position = $Area2D.global_position
					get_parent().get_parent().add_child(poti_squellet)
					if !Globals.night:
						poti_squellet.disabled()
				if squellette_number >= (tier - 1) * 5:
					looking_for_spot = false
		else:
			$Area2D.global_position = global_position + Vector2(randi()%129 - 64,randi()%129 - 64)

<<<<<<< Updated upstream
func _on_cd_timeout() -> void:
=======
## VARIABLES : 
#summon_radius = rayon cercle de spwan autour du player
#angle_gap_between = écart entre chaque spawn
#spawn_angle = pour décaler le spawn de l'écart nécessaire entre chaque spawn
#spawn_position = position sur le rayon, là où l'unité spwan
#spawn_number = nombre d'unités qui spawnent
#dispawn_cd_end = timer pour dispawn les unités summonned

func summon_creature():
	nb_spawn += spawn_number
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		var creature_instance = creature.instantiate()

		creature_instance.global_position = spawn_position + global_position
		parent_node.add_child(creature_instance)
		summoned_creatures.append(creature_instance)
		$dispawn_cd.start()
	
	summon_radius = 100

func summon_update():
	
	if summon_spell == "summon spell":
		summon_cost = 4
		spawn_number = 3
		creature = t1
		
	if summon_spell == "summon spell t2 armed skeleton cac":
		summon_cost = 7
		spawn_number = 5
		creature = cac
		
	if summon_spell == "summon spell t3 armed skeleton cac":
		summon_cost = 11
		spawn_number = 10
		creature = cac
	
	if summon_spell == "summon spell t2 armed skeleton range":
		summon_cost = 7
		spawn_number = 5
		creature = range
		
	if summon_spell == "summon spell t3 armed skeleton range":
		summon_cost = 11
		spawn_number = 10
		creature = range

func _on_summon_spell_cd_timeout() -> void:
>>>>>>> Stashed changes
	can_summon = true
