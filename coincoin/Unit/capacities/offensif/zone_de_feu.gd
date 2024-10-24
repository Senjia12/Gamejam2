extends Node2D


func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_timer_timeout() -> void:
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("Humain"):
			i.take_damage(5)


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
