extends Node2D


@export var difficulty := 10
var x_diff := 232
var y_diff := 264
var decalage := 64

const MAISON = [preload("res://Level/Village/maison scène/maison.tscn"),preload("res://Level/Village/maison scène/maison2.tscn"),preload("res://Level/Village/maison scène/maison3.tscn"),preload("res://Level/Village/maison scène/maison4.tscn"),preload("res://Level/Village/maison scène/maison5.tscn")]
const _GLISE = preload("res://Level/Village/maison scène/église.tscn")
var house_number := 0

const HUMAIN_NULLE = preload("res://Unit/humain nulle/humain_nulle.tscn")
const HUMAIN_ASSASSIN = preload("res://Unit/humain assassin/humain_assassin.tscn")
const HUMAIN_BOUCLIER = preload("res://Unit/humain bouclier/humain_bouclier.tscn")
const HUMAIN_A_LANCE = preload("res://Unit/humain a lance/humain_a_lance.tscn")


var truc_a_spawn := {
	"assassin" : 0,
	"noob" : 0,
	"bouclier" : 0,
	"lance" : 0,
}


var spawn_point := []



func _ready() -> void:
	$Area2D.scale *= difficulty
	$Area2D.global_position *= 2
	$"look spawn".global_position = global_position * 2
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


func next_wave():
	var budget = difficulty * Globals.infamie
	if budget < 20 or difficulty <= 4:
		truc_a_spawn.noob = budget
	elif budget < 40:
		truc_a_spawn.noob = 20
		truc_a_spawn.bouclier = (budget - 20) / 4
		truc_a_spawn.lance = (budget - 20) / 4
	else:
		truc_a_spawn.assassin = budget / 8
		truc_a_spawn.bouclier = budget / 4
		truc_a_spawn.lance = budget / 4
	
	$"spawn delay".start()




func _on_delay_timeout() -> void:
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("décor"):
			i.get_parent().queue_free()
		elif i.is_in_group("montagne"):
			i.queue_free()


func _on_spawn_timeout() -> void:
	for i in 4:
		var unit_instance
		if truc_a_spawn.assassin > 0:
			unit_instance = HUMAIN_ASSASSIN.instantiate()
			truc_a_spawn.assassin -= 1
		elif truc_a_spawn.noob > 0:
			unit_instance = HUMAIN_NULLE.instantiate()
			truc_a_spawn.noob -= 1
		elif truc_a_spawn.bouclier > 0:
			unit_instance = HUMAIN_BOUCLIER.instantiate()
			truc_a_spawn.bouclier -= 1
		elif truc_a_spawn.lance > 0:
			unit_instance = HUMAIN_A_LANCE.instantiate()
			truc_a_spawn.lance -= 1
		else:
			$spawn.stop()
			return
		unit_instance.global_position = spawn_point[i]
		get_parent().add_child(unit_instance)


func _on_decale_timeout() -> void:
	if $"look spawn".get_overlapping_bodies() == []:
		spawn_point.append($"look spawn".global_position)
		if spawn_point.size() > 3:
			$"look spawn".queue_free()
			print(spawn_point)
			return
	$"look spawn".global_position = global_position * 2 + Vector2(randi()%(132*difficulty) - 66 * difficulty,randi()%(132*difficulty) - 66 * difficulty)


func _on_spawn_delay_timeout() -> void:
	$spawn.start()
