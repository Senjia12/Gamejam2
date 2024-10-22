extends Area2D

#var offensive_spell_t2_fireball = false
#var offensive_spell_t3_fireball_flames = false
#var offensive_spell_t2_burning_beam = false
#var offensive_spell_t3_infinite_burning_beam = false

func _ready() -> void:
	pass # Replace with function body.

@onready var player = get_parent()
@onready var cooldown_multiplayer = player.cooldown_multiplier

var can_attack = true
var is_attacking = false

func _process(delta: float) -> void:
	var offensive_spell = "offensive spell"
	var offensive_spell_cd = $offensive_spell_cd.wait_time * cooldown_multiplayer
	
	if Input.is_action_just_pressed("offensive_spell") && can_attack==true:
		can_attack = false
		is_attacking = true
		$offensive_spell_cd.start()

func _on_offensive_spell_cd_timeout(offensive_spell_cd) -> void:
	pass # Replace with function body.
	can_attack = true
	is_attacking = false
