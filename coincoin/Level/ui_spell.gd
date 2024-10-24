extends Control

@onready var control: TextureProgressBar = $spell/control
@onready var d_fense: TextureProgressBar = $"spell/défense"
@onready var attack: TextureProgressBar = $spell/attack
@onready var summon: TextureProgressBar = $spell/summon


var control_cd := 8.0
var defense_cd := 8.0
var attack_cd := 8.0
var summon_cd := 8.0


func _ready() -> void:
	control.max_value = control_cd * 10
	d_fense.max_value = defense_cd * 10
	attack.max_value = attack_cd * 10
	summon.max_value = summon_cd * 10


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("control_spell") && control.value == control_cd * 10:
		control.value = 0
	elif Input.is_action_just_pressed("defensive_spell") && d_fense.value == control_cd * 10:
		d_fense.value = 0
	elif Input.is_action_just_pressed("offensive_spell") && attack.value == control_cd * 10:
		attack.value = 0
	elif Input.is_action_just_pressed("summon_spell") && summon.value == control_cd * 10:
		summon.value = 0


func _on_timer_timeout() -> void:
	control.value += 1
	d_fense.value += 1
	attack.value += 1
	summon.value += 1
