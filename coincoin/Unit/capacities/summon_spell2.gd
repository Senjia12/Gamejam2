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

var can_summon = true

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	var summon_spell = "summon spell"
	var summon_spell_cd = cooldown_multiplier * $summon_spell_cd.wait_time
	
	if Input.is_action_just_pressed("summon_spell") && can_summon==true:
		can_summon = false
		$summon_spell_cd.start()
		
		if summon_spell == "summon spell":
			summon_t1()

func summon_t1():
	poti_squellette_instance.position = Vector2(randi(), randi())

func _on_summon_spell_cd_timeout(summon_spell_cd) -> void:
	can_summon = true
