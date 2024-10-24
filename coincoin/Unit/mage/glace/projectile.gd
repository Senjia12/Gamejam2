extends Node2D

const PROJECTILE_DE_GLACE = preload("res://Unit/mage/glace/projectile_de_glace.tscn")

func launch(target):
	for i in $"../Attack_range".get_overlapping_bodies():
		if i == Globals.player:
			target = i
	var projectile = PROJECTILE_DE_GLACE.instantiate()
	projectile.target = target
	projectile.global_position = global_position
	get_parent().get_parent().add_child(projectile)
