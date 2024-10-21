extends Node2D


@export var difficulty := 10
var x_diff := 232
var y_diff := 264
var decalage := 64

const MAISON = [preload("res://Level/Village/maison scène/maison.tscn"),preload("res://Level/Village/maison scène/maison2.tscn"),preload("res://Level/Village/maison scène/maison3.tscn"),preload("res://Level/Village/maison scène/maison4.tscn"),preload("res://Level/Village/maison scène/maison5.tscn")]
const _GLISE = preload("res://Level/Village/maison scène/église.tscn")
var house_number := 0

func _ready() -> void:
	$Area2D.scale *= difficulty
	$Area2D.global_position *= 2
	for i in $Area2D.get_overlapping_bodies():
		i.queue_free()
	for x in difficulty:
		for y in difficulty:
			var next_pos := (Vector2(x - (difficulty / 2),y - (difficulty / 2)) * 200) + Vector2(randi()%(decalage * 2 + 1) - decalage,randi()%(decalage * 2 + 1) - decalage)
			if randi()%int(Vector2.ZERO.distance_to(next_pos)) < difficulty * 50 or house_number < 5:
				
				if house_number == 4:
					var glise = _GLISE.instantiate()
					glise.global_position = next_pos + global_position
					add_child(glise)
				else:
					var maison = MAISON[randi()%MAISON.size()].instantiate()
					maison.global_position = next_pos + global_position
					add_child(maison)
				house_number += 1
	


func _on_delay_timeout() -> void:
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("décor"):
			i.get_parent().queue_free()
		elif i.is_in_group("montagne"):
			i.queue_free()
