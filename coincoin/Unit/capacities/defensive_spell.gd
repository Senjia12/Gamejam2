extends Area2D

#var defensive_spell_t2_explosive_armor = false
#var defensive_spell_t3_regen_explosive_armor = false
#var defensive_spell_t2_shadow_veil = false
#var defensive_spell_t3_extended_shadow_veil = false


@onready var player = get_parent()
@onready var cooldown_multiplier = player.cooldown_multiplier


const shield_scene = preload("res://Unit/capacities/shield/shield.tscn")
var defensive_spell = "defense spell"
var shield_scene_instance

#var début game :
var can_defend = false
var is_defending = false
var defensive_cost = 4

#scores
var nb_shields = 0
var nb_explosion_kills = 0

func _ready() -> void:
	shield_scene_instance = shield_scene.instantiate()
	connect("body_exited", self, "_on_body_exited")

func _process(delta: float) -> void:
	var defensive_spell_cd = $defensive_spell_cd.wait_time * cooldown_multiplier

	if Input.is_action_just_pressed("defensive_spell") && is_defending == false && can_defend==true && Globals.mana.cost(defensive_cost)==true:
		can_defend = false
		is_defending = true
		$defensive_spell_cd.start()
		shield_or_shadow()
	shield_destroyed()

func shield_or_shadow():
	if defensive_spell == "defensive spell t3 extended shadow veil" or defensive_spell == "defensive spell t2 shadow veil":
		shadow_veil()
	elif defensive_spell == "defense spell":
		shield_scene_instance = shield_scene.instantiate()
		player.add_child(shield_scene_instance)
		shield_scene_instance.global_position = player.global_position
		player.shield += 25
		#if i in get_overlapping_areas():
			#
		

	else:
		for i in get_overlapping_bodies():
			if i.is_in_group("Unit"):
				shield_scene_instance = shield_scene.instantiate()
				i.add_child(shield_scene_instance)
				shield_scene_instance.global_position = i.global_position
				i.shield += 25 #player sans shield
				shield_scene_instance._ready()
				shield_scene_instance = shield_scene.instantiate()
		player.add_child(shield_scene_instance)
		shield_scene_instance.global_position = player.global_position
		player.shield += 25

############  VEIL = UN VOILE

func shadow_veil():

	get_parent().set_modulate("274cac79")
	get_parent().speed *= 1.20
			
	if defensive_spell == "defensive spell t3 extended shadow veil":
		for i in get_overlapping_bodies():
			i.set_modulate("274cac79")
			i.real_speed *= 1.20
			i.insensible = true


func defensive_update():
	shield_scene_instance.tier = defensive_spell

	if defensive_spell == "defensive spell t2 explosive armor":
		defensive_cost = 7
		
	if defensive_spell == "defensive spell t3 regen explosive armor":
		defensive_cost = 11
	
	if defensive_spell == "defensive spell t2 shadow veil":
		defensive_cost = 7
	
	if defensive_spell == "defensive spell t3 extended shadow veil":
		defensive_cost = 11
		
func shield_destroyed():
	if player.shield <= 0:
		var player_shield = player.get_node_or_null("shield")
		if player_shield:
			player_shield.queue_free()

func _on_defensive_spell_cd_timeout(defensive_spell_cd) -> void:
	can_defend = true
	is_defending = false
	get_parent().set_modulate("ffffff")
	get_parent().speed = 100
	get_parent().insensible = false
	for i in get_overlapping_bodies():
			i.set_modulate("ffffff")
			i.real_speed = i.speed
			i.insensible = false


func _on_body_exited(body: Node2D) -> void:
	
