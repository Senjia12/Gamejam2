extends Area2D

#var summon_spell_t2_skeleton = false
#var summon_spell_t3_explosive_skeleton = false
#var summon_spell_t2_golem = false
#var summon_spell_t3_ice_storm_golem = false
#var on_summon_spell_cd_duration = false

@onready var player = get_parent()
@onready var cooldown_multiplier = player.cooldown_multiplier
@onready var spell_cost = get_parent().get_parent().get_node("Spell cost")
@onready var summon_cost = spell_cost.summon_cost
@onready var summon_spell = spell_cost.summon_spell


const poti_squelette_preload = preload("res://Unit/poti squellette/poti squellette.tscn")
var summon_radius = 100
var can_summon = true
var spawn_number = 3
var summoned_creatures = []
var parent_node

#scores
var nb_spawn = 0
var nb_summon_spell = 0
var nb_squelettes_t1 = 0
var nb_squelettes_t2 = 0
var nb_squelettes_t3 = 0
var nb_golem = 0
var nb_golem_icestorm = 0

func _ready() -> void:
	parent_node = get_parent().get_parent().get_node("Terrain").get_node("NavigationRegion2D")

func _process(delta: float) -> void:
	$summon_spell_cd.wait_time = cooldown_multiplier * $summon_spell_cd.wait_time #opti avec calcul quand amélio cd ?
	#summon_cost à recalculer ?
	
	if Input.is_action_just_pressed("summon_spell") && can_summon==true && Globals.mana.cost(summon_cost)==true:
		can_summon = false
		nb_summon_spell += 1
		$summon_spell_cd.start()
		
		if summon_spell == "summon spell":
			summon_t1()
		
		if summon_spell == "summon spell t2 armed skeleton":
			summon_t2_skeleton()
		
		if summon_spell == "summon spell t3 explosive armed skeleton":
			summon_t3_skeleton()
			
		if summon_spell == "summon spell t2 golem":
			summon_t2_golem()
		
		if summon_spell == "summon spell t3 ice storm golem":
			summon_t3_golem()

## VARIABLES : 
#summon_radius = rayon cercle de spwan autour du player
#angle_gap_between = écart entre chaque spawn
#spawn_angle = pour décaler le spawn de l'écart nécessaire entre chaque spawn
#spawn_position = position sur le rayon, là où l'unité spwan
#spawn_number = nombre d'unités qui spawnent
#dispawn_cd_end = timer pour dispawn les unités summonned

func summon_t1():
	nb_spawn += spawn_number
	nb_squelettes_t1 += spawn_number
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		var poti_squellette_instance = poti_squelette_preload.instantiate()

		poti_squellette_instance.global_position = spawn_position + global_position
		parent_node.add_child(poti_squellette_instance)
		
		
func summon_t2_skeleton():
	spawn_number = 5
	nb_spawn += spawn_number
	nb_squelettes_t2 += spawn_number
	summon_radius = 150
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		var poti_squellette_instance = poti_squelette_preload.instantiate()

		parent_node.add_child(poti_squellette_instance)
		parent_node.add_child(poti_squellette_instance)
		

func summon_t3_skeleton():
	spawn_number = 10
	nb_spawn += spawn_number
	nb_squelettes_t3 += spawn_number
	summon_radius = 200
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		var poti_squellette_instance = poti_squelette_preload.instantiate()

		poti_squellette_instance.global_position = spawn_position + global_position
		parent_node.add_child(poti_squellette_instance)
		summoned_creatures.append(poti_squellette_instance)

func summon_t2_golem():
	spawn_number = 1
	nb_spawn += spawn_number
	nb_golem += spawn_number
	summon_radius = 150
	var angle_gap_between = TAU / spawn_number

	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		var poti_squellette_instance = poti_squelette_preload.instantiate()

		poti_squellette_instance.global_position = spawn_position + global_position
		parent_node.add_child(poti_squellette_instance)
		summoned_creatures.append(poti_squellette_instance)


func summon_t3_golem():
	spawn_number = 1
	nb_spawn += spawn_number
	nb_golem_icestorm += spawn_number
	summon_radius = 200
	var angle_gap_between = TAU / spawn_number
	var poti_squellette_instance = poti_squelette_preload.instantiate()

	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		
		poti_squellette_instance.global_position = spawn_position + global_position
		parent_node.add_child(poti_squellette_instance)
		summoned_creatures.append(poti_squellette_instance)

func _on_summon_spell_cd_timeout() -> void:
	can_summon = true

func _on_dispawn_cd_timeout() -> void:
	summoned_creatures.queue_free()
