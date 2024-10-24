extends Node2D

const ARROW = preload("res://Unit/arrow/arrow.tscn")

func launch(target):
	var projectile = ARROW.instantiate()
	projectile.target = target
	projectile.global_position = global_position
	print(global_position)
	get_parent().get_parent().add_child(projectile)
