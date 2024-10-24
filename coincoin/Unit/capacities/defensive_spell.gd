extends Area2D

#var defensive_spell_t2_explosive_armor = false
#var defensive_spell_t3_regen_explosive_armor = false
#var defensive_spell_t2_shadow_veil = false
#var defensive_spell_t3_extended_shadow_veil = false


@onready var player = get_parent()
@onready var cooldown_multiplier = player.cooldown_multiplier

const shield_scene = preload("res://Unit/capacities/shield/shield.tscn")

var defensive_spell = "defense spell"
var can_defend = false
var is_defending = false
var summon_cost = 4

func _ready() -> void:
	pass # Replace with function body

#scores
var nb_shields = 0
var nb_explosion_kills = 0

func _process(delta: float) -> void:
	var defensive_spell_cd = $defensive_spell_cd.wait_time * cooldown_multiplier

	if Input.is_action_just_pressed("defensive_spell") && can_defend==true && Globals.mana.cost(summon_cost)==true:
		can_defend = false
		is_defending = true
		$defensive_spell_cd.start()
		
		if defensive_spell == "defense spell":
			can_defend = true
			is_defending = false

func shield_or_shadow():
	if defensive_spell == "defensive spell t3 extended shadow veil" or defensive_spell == "defensive spell t2 shadow veil":
		shadow_veil()
	
	else:
		get_node("res://Unit/capacities/shield/shield.tscn").shield_tier()

############  VEIL = VOILE

func shadow_veil():

	if is_defending == true:
		get_parent().set_modulate("274cac79")
		get_parent().speed *= 1.20
			
		if defensive_spell == "defensive spell t3 extended shadow veil":
			for i in get_overlapping_bodies():
				i.set_modulate("274cac79")
				i.speed *= 1.20
				
func defensive_update():
	return
	#if summon_spell == "summon spell":
		#defense_cost = 4
		#
	#if summon_spell == "summon spell t2 armed skeleton cac":
		#defense_cost = 7
		#
	#if summon_spell == "summon spell t3 armed skeleton cac":
		#defense_cost = 11
	#
	#if summon_spell == "summon spell t2 armed skeleton range":
		#defense_cost = 7
		#
	#if summon_spell == "summon spell t3 armed skeleton range":
		#defense_cost = 11

func _on_defensive_spell_cd_timeout(defensive_spell_cd) -> void:
	pass # Replace with function body.
	can_defend = true
	is_defending = false
