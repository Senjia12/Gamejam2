extends Node2D


const BOULE_DE_FEU = preload("res://Unit/mage/feu/boule_de_feu.tscn")

func launch(target):
	var projectile = BOULE_DE_FEU.instantiate()
	projectile.target = target
	projectile.global_position = global_position
	get_parent().get_parent().add_child(projectile)
