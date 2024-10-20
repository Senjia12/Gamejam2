extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var player = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var summon_spell = true
var summon_spell_t2_skeleton = false
var summon_spell_t3_explosive_skeleton = false
var summon_spell_t2_golem = false
var summon_spell_t3_ice_storm_golem = false


func _on_summon_spell_cd_timeout() -> void:
	pass # Replace with function body.
