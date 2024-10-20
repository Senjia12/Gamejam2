extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var player = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var offensive_spell = true
var offensive_spell_t2_fireball = false
var offensive_spell_t3_fireball_flames = false
var offensive_spell_t2_burning_beam = false
var offensive_spell_t3_infinite_burning_beam = false


func _on_offensive_spell_cd_timeout() -> void:
	pass # Replace with function body.
