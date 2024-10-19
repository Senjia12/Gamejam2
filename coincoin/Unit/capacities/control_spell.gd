extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var control_spell = false
var  control_spell_t2_wall = false
var  control_spell_t2_palisade_turret = false
var  control_spell_t2_area = false
var  control_spell_t2_infinite_area = false


func _on_control_spell_cd_timeout() -> void:
	pass # Replace with function body.
