extends Node2D


var target
var t_pos := Vector2.ZERO

func _ready() -> void:
	look_at(target.global_position)
	t_pos = target.global_position


func _physics_process(delta: float) -> void:
	global_position += global_position.direction_to(t_pos) * delta * 1000
	if global_position.distance_to(t_pos) <= 16:
		if target != null:
			target.take_damage(15 * Globals.squ_dmg_mult)
		queue_free()
