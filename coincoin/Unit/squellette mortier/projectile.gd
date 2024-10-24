extends Node2D


const MORTIER = preload("res://Unit/squellette mortier/mortier.tscn")


func launch(target):
	var projectile = MORTIER.instantiate()
	projectile.target = target
	projectile.global_position = global_position
	get_parent().get_parent().add_child(projectile)
