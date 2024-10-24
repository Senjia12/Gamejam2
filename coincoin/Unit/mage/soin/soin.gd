extends Node2D


@onready var attack_range: Area2D = $"../Attack_range"



func _on_timer_timeout() -> void:
	for i in attack_range.get_overlapping_bodies():
		if i.is_in_group("Humain"):
			if i.max_hp > i.current_hp:
				i.current_hp += 5
