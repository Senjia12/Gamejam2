extends Node2D


const PROJECTILE_SQUELLETTE_RANGE = preload("res://Unit/squellette distance/projectile_squellette_range.tscn")

func launch(target):
	var projectile = PROJECTILE_SQUELLETTE_RANGE.instantiate()
	projectile.target = target
	projectile.global_position = global_position
	print(global_position)
	get_parent().get_parent().add_child(projectile)
