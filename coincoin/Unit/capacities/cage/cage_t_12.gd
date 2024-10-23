extends StaticBody2D


var hp := 75
var t = 1

func _ready() -> void:
	hp *= t


func take_damage(dmg):
	hp -= dmg
	if hp <= 0:
		queue_free()
