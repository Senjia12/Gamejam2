extends Area2D

#var defensive_spell_t2_explosive_armor = false
#var defensive_spell_t3_regen_explosive_armor = false
#var defensive_spell_t2_shadow_veil = false
#var defensive_spell_t2_extended_shadow_veil = false

func _ready() -> void:
	pass # Replace with function body
	
@onready var player = get_parent()
@onready var cooldown_multiplier = player.cooldown_multiplier

var can_defend = false
var is_defending = false

func _process(delta: float) -> void:
	var defensive_spell = "defense spell"
	var defensive_spell_cd = $defensive_spell_cd.wait_time * cooldown_multiplier

	if Input.is_action_just_pressed("defensive_spell") && can_defend==true:
		can_defend = false
		is_defending = true
		$defensive_spell_cd.start()

func _on_defensive_spell_cd_timeout(defensive_spell_cd) -> void:
	pass # Replace with function body.
	can_defend = true
	is_defending = false
