extends Control

@onready var control: TextureProgressBar = $spell/control
@onready var d_fense: TextureProgressBar = $"spell/défense"
@onready var attack: TextureProgressBar = $spell/attack
@onready var summon: TextureProgressBar = $spell/summon


var control_cd := 8.0
var defense_cd := 8.0
var attack_cd := 3.0
var summon_cd := 8.0


func _ready() -> void:
	control.max_value = control_cd * 10
	control.value = control.max_value
	d_fense.max_value = defense_cd * 10
	d_fense.value = d_fense.max_value
	attack.max_value = attack_cd * 10
	attack.value = attack.max_value
	summon.max_value = summon_cd * 10
	summon.value = summon.max_value


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("control_spell") && control.value == control_cd * 10:
		control.value = 0
	elif Input.is_action_just_pressed("defensive_spell") && d_fense.value == d_fense.max_value:
		d_fense.value = 0
	elif Input.is_action_just_pressed("offensive_spell") && attack.value == attack.max_value:
		attack.value = 0
	elif Input.is_action_just_pressed("summon_spell") && summon.value == summon.max_value:
		summon.value = 0


func _on_timer_timeout() -> void:
	control.value += 1
	d_fense.value += 1
	attack.value += 1
	summon.value += 1
