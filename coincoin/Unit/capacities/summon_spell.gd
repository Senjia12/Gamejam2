extends Area2D

#var summon_spell_t2_skeleton = false
#var summon_spell_t3_explosive_skeleton = false
#var summon_spell_t2_golem = false
#var summon_spell_t3_ice_storm_golem = false
#var on_summon_spell_cd_duration = false

@onready var player = get_parent()
@onready var cooldown_multiplier = player.cooldown_multiplier

const poti_squelette_preload = preload("res://Unit/poti squellette/poti squellette.tscn")
var poti_squellette_instance = poti_squelette_preload.instantiate()
var summon_radius = 100
var can_summon = true
var spawn_number = 3

var parent_node


func _ready() -> void:
	parent_node = get_parent().spawn_node

func _process(delta: float) -> void:
	var summon_spell = "summon spell"
	var summon_spell_cd = cooldown_multiplier * $summon_spell_cd.wait_time
	
	if Input.is_action_just_pressed("summon_spell") && can_summon==true:
		can_summon = false
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

func summon_t1():
	
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		
		poti_squellette_instance.global_position = spawn_position + global_position
		add_child(poti_squellette_instance)
		
func summon_t2_skeleton():
	spawn_number = 5
	summon_radius = 150
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		
		poti_squellette_instance.global_position = spawn_position + global_position
		add_child(poti_squellette_instance)


func summon_t3_skeleton():
	spawn_number = 10
	summon_radius = 200
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		
		poti_squellette_instance.global_position = spawn_position + global_position
		add_child(poti_squellette_instance)


func summon_t2_golem():
	spawn_number = 1
	summon_radius = 150
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		
		poti_squellette_instance.global_position = spawn_position + global_position
		add_child(poti_squellette_instance)


func summon_t3_golem():
	spawn_number = 1
	summon_radius = 200
	var angle_gap_between = TAU / spawn_number
	
	for i in range (spawn_number):
		var spawn_angle = i * angle_gap_between
		var spawn_position = Vector2(cos(spawn_angle) * summon_radius, sin(spawn_angle) * summon_radius)
		
		poti_squellette_instance.global_position = spawn_position + global_position
		add_child(poti_squellette_instance)

func _on_summon_spell_cd_timeout(summon_spell_cd) -> void:
	can_summon = true
