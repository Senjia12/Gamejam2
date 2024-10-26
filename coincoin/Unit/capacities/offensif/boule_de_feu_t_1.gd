extends Node2D

var t_pos := Vector2.ZERO

func _ready() -> void:
	look_at(t_pos)
	$AnimatedSprite2D.play("explosion")


func _physics_process(delta: float) -> void:
	if global_position.distance_to(t_pos) <= 16:
		$AnimatedSprite2D.speed_scale = 1
		$GPUParticles2D.emitting = true
	else:
		global_position += global_position.direction_to(t_pos) * delta * 600


func _on_animated_sprite_2d_animation_finished() -> void:
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("Humain"):
			i.take_damage(15)
	queue_free()
