extends StaticBody2D


var hp := 250


func take_damage(dmg):
	hp -= dmg
	if hp <= 0:
		queue_free()