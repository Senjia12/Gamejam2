extends Node2D


var target


func _ready() -> void:
	look_at(target.global_position)


func _physics_process(delta: float) -> void:
	global_position += global_position.direction_to(target.global_position) * delta * 1000
	if global_position.distance_to(target.global_position) <= 16:
		target.take_damage(15)
		queue_free()
