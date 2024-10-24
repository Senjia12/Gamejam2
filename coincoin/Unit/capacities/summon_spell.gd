extends Area2D

#var summon_spell_t2_skeleton = false
#var summon_spell_t3_explosive_skeleton = false
#var summon_spell_t2_golem = false
#var summon_spell_t3_ice_storm_golem = false
#var on_summon_spell_cd_duration = false

@onready var player = get_parent()
@onready var cooldown_multiplier = player.cooldown_multiplier


const poti_squelette_preload = preload("res://Unit/poti squellette/poti squellette.tscn")
var summon_radius = 100
var can_summon = true
var spawn_number = 3
var summoned_creatures = []
var parent_node
var summon_spell = "summon spell"
var summon_cost = 4

#scores
var nb_spawn = 0
var nb_summon_spell = 0
var nb_squelettes_t1 = 0
var nb_t2_cac = 0
var nb_t3_cac = 0
var nb_t2_range = 0
var nb_t3_range = 0

func _ready() -> void:
	parent_node = get_parent().get_parent()

func _process(delta: float) -> void:
	$summon_spell_cd.wait_time = cooldown_multiplier * $summon_spell_cd.wait_time #opti avec calcul quand amélio cd ?
	#summon_cost à recalculer ?
	
	if Input.is_action_just_pressed("summon_spell") && can_summon==true && Globals.mana.cost(summon_cost)==true:
		can_summon = false
		nb_summon_spell += 1
		$summon_spell_cd.start()
		
		if summon_spell == "summon spell":
			summon_t1()
		
		if summon_spell == "summon spell t2 armed skeleton cac":
			summon_t2_cac()
		
		if summon_spell == "summon spell t3 armed skeleton cac":
			summon_t3_cac()
			
		if summon_spell == "summon spell t2 armed skeleton range":
			summon_t2_range()
		
		if summon_spell == "summon spell t3 armed skeleton range":
			summon_t3_range()

## VARIABLES : 
#summon_radius = rayon cercle de spwan autour du player
#angle_gap_between = écart entre chaque spawn
#spawn_angle = pour décaler le spawn de l'écart nécessaire entre chaque spawn
#spawn_position = position sur le rayon, là où l'unité spwan
#spawn_number = nombre d'unités qui spawnent
#dispawn_cd_end = timer pour dispawn les unités summonned

func summon_t1():
	spawn_number = 3
	nb_spawn += spawn_number
	nb_squelettes_t1 += spawn_number
	summon_radius = 100
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		var poti_squellette_instance = poti_squelette_preload.instantiate()

		poti_squellette_instance.global_position = spawn_position + global_position
		parent_node.add_child(poti_squellette_instance)
		summoned_creatures.append(poti_squellette_instance)


func summon_t2_cac():
	spawn_number = 5
	nb_spawn += spawn_number
	nb_t2_cac += spawn_number
	summon_radius = 150
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		var poti_squellette_instance = poti_squelette_preload.instantiate()

		poti_squellette_instance.global_position = spawn_position + global_position
		parent_node.add_child(poti_squellette_instance)
		summoned_creatures.append(poti_squellette_instance)

func summon_t3_cac():
	spawn_number = 10
	nb_spawn += spawn_number
	nb_t3_cac += spawn_number
	summon_radius = 200
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		var poti_squellette_instance = poti_squelette_preload.instantiate()

		poti_squellette_instance.global_position = spawn_position + global_position
		parent_node.add_child(poti_squellette_instance)
		summoned_creatures.append(poti_squellette_instance)

func summon_t2_range():
	spawn_number = 1
	nb_spawn += spawn_number
	nb_t2_range += spawn_number
	summon_radius = 150
	var angle_gap_between = TAU / spawn_number

	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		var poti_squellette_instance = poti_squelette_preload.instantiate()

		poti_squellette_instance.global_position = spawn_position + global_position
		parent_node.add_child(poti_squellette_instance)
		summoned_creatures.append(poti_squellette_instance)


func summon_t3_range():
	spawn_number = 1
	nb_spawn += spawn_number
	nb_t3_range += spawn_number
	summon_radius = 200
	var angle_gap_between = TAU / spawn_number
	var poti_squellette_instance = poti_squelette_preload.instantiate()

	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		
		poti_squellette_instance.global_position = spawn_position + global_position
		parent_node.add_child(poti_squellette_instance)
		summoned_creatures.append(poti_squellette_instance)

func summon_update():
	
	if summon_spell == "summon spell":
		summon_cost = 4
		spawn_number = 3
		
	if summon_spell == "summon spell t2 armed skeleton cac":
		summon_cost = 7
		spawn_number = 5
		
	if summon_spell == "summon spell t3 armed skeleton cac":
		summon_cost = 11
		spawn_number = 10
	
	if summon_spell == "summon spell t2 armed skeleton range":
		summon_cost = 7
		spawn_number = 5
		
	if summon_spell == "summon spell t3 armed skeleton range":
		summon_cost = 11
		spawn_number = 10

func _on_summon_spell_cd_timeout() -> void:
	can_summon = true

func _on_dispawn_cd_timeout() -> void:
	summoned_creatures.queue_free()
