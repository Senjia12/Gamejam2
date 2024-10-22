extends Area2D


#var  control_spell_t2_wall = false
#var  control_spell_t2_palisade_turret = false
#var  control_spell_t2_area = false
#var  control_spell_t2_infinite_area = false
#var control_spell_cd_timeout_end = true

func _ready() -> void:
	pass # Replace with function body.

@onready var player = get_parent()
@onready var cooldown_multiplier = player.cooldown_multiplier

var can_control = false
var is_controlling = false

func _process(delta: float) -> void:
	var control_spell = "control spell"
	var control_spell_cd = cooldown_multiplier * $control_spell_cd.wait_time

	if Input.is_action_just_pressed("control_spell") && can_control==true:
		can_control = false
		is_controlling = true
		$control_spell_cd.start()

func _on_control_spell_cd_timeout(control_spell_cd) -> void:
	can_control = true
	is_controlling = false
