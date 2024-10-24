extends Node2D

var target
var t_pos := Vector2.ZERO

func _ready() -> void:
	look_at(target.global_position)
	t_pos = target.global_position


func _physics_process(delta: float) -> void:
	if global_position.distance_to(t_pos) <= 16:
		$AnimatedSprite2D.play("explode")
	else:
		global_position += global_position.direction_to(t_pos) * delta * 800


func _on_animated_sprite_2d_animation_finished() -> void:
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("Humain"):
			i.take_damage(10 * Globals.squ_dmg_mult)
	queue_free()
