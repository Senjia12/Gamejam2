extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body
	
var player = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var defensive_spell = false
var defensive_spell_t2_explosive_armor = false
var defensive_spell_t3_regen_explosive_armor = false
var defensive_spell_t2_shadow_veil = false
var defensive_spell_t2_extended_shadow_veil = false


func _on_defensive_spell_cd_timeout() -> void:
	pass # Replace with function body.
