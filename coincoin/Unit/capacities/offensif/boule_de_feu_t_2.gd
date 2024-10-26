extends Node2D

const ZONE_DE_FEU = preload("res://Unit/capacities/offensif/zone_de_feu.tscn")
var t_pos := Vector2.ZERO

var tier := 2

func _ready() -> void:
	look_at(t_pos)
	$AnimatedSprite2D.play("explosion")


func _physics_process(delta: float) -> void:
	if global_position.distance_to(t_pos) <= 16:
		$AnimatedSprite2D.speed_scale = 1
		$GPUParticles2D.emitting = true
		for i in $Area2D.get_overlapping_bodies():
			if i.is_in_group("Humain"):
				i.take_damage(25)
		
		if tier == 3:
			var zone_feu_i = ZONE_DE_FEU.instantiate()
			zone_feu_i.global_position = global_position + global_position.direction_to(t_pos) * 16
			get_parent().add_child(zone_feu_i)
	else:
		global_position += global_position.direction_to(t_pos) * delta * 600


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
