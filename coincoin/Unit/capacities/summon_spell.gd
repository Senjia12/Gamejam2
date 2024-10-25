extends Area2D

#var summon_spell_t2_skeleton = false
#var summon_spell_t3_explosive_skeleton = false
#var summon_spell_t2_golem = false
#var summon_spell_t3_ice_storm_golem = false
#var on_summon_spell_cd_duration = false

@onready var player = get_parent()
@onready var cooldown_multiplier = player.cooldown_multiplier


const t1 = preload("res://Unit/poti squellette/poti squellette.tscn")
@warning_ignore("shadowed_global_identifier")
const range = preload("res://Unit/squellette archer/squellette_archer.tscn")
const cac = preload("res://Unit/gros quellette/squellette_gros.tscn")

var summon_radius = 100
var can_summon = true
var summoned_creatures = []
var parent_node

#summon de base
var summon_spell = "summon spell"
var summon_cost = 4
var spawn_number = 3
var creature = t1

#scores
var nb_spawn = 0
var nb_summon_spell = 0
var nb_squelettes_t1 = 0
var nb_cac_summoned = 0
var nb_range_summoned = 0

func _ready() -> void:
	parent_node = get_parent().get_parent()

func _process(delta: float) -> void:
	$summon_spell_cd.wait_time = cooldown_multiplier * $summon_spell_cd.wait_time #opti avec calcul quand amélio cd ?

	if Input.is_action_just_pressed("summon_spell") && can_summon==true && Globals.mana.cost(summon_cost)==true && get_overlapping_bodies()== [get_parent()]:
		can_summon = false
		nb_summon_spell += 1
		$summon_spell_cd.start()
		$dispawn_cd.start()
		
		if summon_spell == "summon spell":
			nb_squelettes_t1 += spawn_number
			summon_radius = 60
			summon_creature()
		
		if summon_spell == "summon spell t2 armed skeleton cac":
			nb_cac_summoned += spawn_number
			summon_creature()
		
		if summon_spell == "summon spell t3 armed skeleton cac":
			nb_cac_summoned += spawn_number
			summon_creature()
			
		if summon_spell == "summon spell t2 armed skeleton range":
			nb_range_summoned += spawn_number
			summon_creature()
		
		if summon_spell == "summon spell t3 armed skeleton range":
			nb_range_summoned += spawn_number
			summon_creature()
	else:
		print(can_summon)
		print(get_overlapping_bodies())
		print(summon_cost)

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
	can_summon = true

func _on_dispawn_cd_timeout() -> void:
	for i in summoned_creatures:
		i.queue_free()
