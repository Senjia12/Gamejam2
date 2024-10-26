extends Node2D


var unit_from_village := []

var is_raided := false
var maison := []

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

const MAGE_FEU = preload("res://Unit/mage/feu/mage feu.tscn")
const MAGE_GLACE = preload("res://Unit/mage/glace/mage glace.tscn")
const MAGE_SOIN = preload("res://Unit/mage/soin/mage_soin.tscn")



var truc_a_spawn := {
	"assassin" : 0,
	"noob" : 0,
	"bouclier" : 0,
	"lance" : 0,
	"mage_feu" : 0,
	"mage_glace" : 0,
	"mage_soin" : 0
}


var spawn_point := []



func _ready() -> void:
	Globals.village += 1
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
					glise.global_position = next_pos + global_position*2
					get_parent().add_child(glise)
					maison.append(glise)
				else:
					var maison_i = MAISON[randi()%MAISON.size()].instantiate()
					maison_i.global_position = next_pos + global_position*2
					get_parent().add_child(maison_i)
					maison.append(maison_i)
				house_number += 1


func next_wave():
	var budget = difficulty * Globals.infamie
	if budget < 20 or difficulty <= 4:
		truc_a_spawn.noob = budget
	elif budget < 40:
		truc_a_spawn.noob = 20
		truc_a_spawn.bouclier = (budget - 20) / 4
		truc_a_spawn.lance = (budget - 20) / 4
	elif budget < 60:
		truc_a_spawn.assassin = budget / 8
		truc_a_spawn.bouclier = budget / 4
		truc_a_spawn.lance = budget / 4
	else:
		truc_a_spawn.assassin = budget / 8
		truc_a_spawn.bouclier = budget / 4
		truc_a_spawn.lance = budget / 4
		truc_a_spawn.mage_feu = budget / 40
		truc_a_spawn.mage_soin = budget / 40
		truc_a_spawn.mage_glace = budget / 40
	if !is_raided:
		$"spawn delay".start()
	else:
		$spawn.start()




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
		elif truc_a_spawn.mage_feu > 0:
			unit_instance = MAGE_FEU.instantiate()
			truc_a_spawn.mage_feu -= 1
		elif truc_a_spawn.mage_soin > 0:
			unit_instance = MAGE_SOIN.instantiate()
			truc_a_spawn.mage_soin -= 1
		elif truc_a_spawn.mage_glace > 0:
			unit_instance = MAGE_GLACE.instantiate()
			truc_a_spawn.mage_glace -= 1
		else:
			$spawn.stop()
			return
		unit_instance.global_position = spawn_point[i]
		get_parent().add_child(unit_instance)
		unit_from_village.append(unit_instance)
		unit_instance.village = self

func couik(villageois):
	unit_from_village.erase(villageois)
	if unit_from_village == [] && is_raided:
		Globals.bone_counter.add_bones(difficulty * 50)
		Globals.exp.add_exp(difficulty * 10)
		Globals.score += difficulty * 200
		Globals.village -= 1
		if Globals.village == 2:
			Globals.poti_squellette.talk(["Well done you razed a village, but there are still 2 left ^^ and they may not be very happy with the news"])
		elif Globals.village == 1:
			Globals.poti_squellette.talk(["And another to fall, only 1 left..."])
		elif Globals.village == 0:
			Globals.poti_squellette.talk(["And the last one, now nothing stops us from conquering the world", "Mouahahahahahhahahahahahahahahahahahahahahahahahhahahahahahahahahahahaha !!!"])
			Globals.bone_pill.reveale()
			Globals.poti_squellette.talk(["Now everything belongs to us, but without humans, it's difficult to have fun and collect bones, maybe there would be a solution to resurrect some... to be continued"])
			
		Globals.musique.raid_musique(false)
		for i in maison:
			i.burn()
		queue_free()


func _on_decale_timeout() -> void:
	if $"look spawn".get_overlapping_bodies() == []:
		spawn_point.append($"look spawn".global_position)
		if spawn_point.size() > 3:
			$"look spawn".queue_free()
			return
	$"look spawn".global_position = global_position * 2 + Vector2(randi()%(132*difficulty) - 66 * difficulty,randi()%(132*difficulty) - 66 * difficulty)


func _on_spawn_delay_timeout() -> void:
	$spawn.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Unit") && !is_raided:
		Globals.musique.raid_musique(true)
		Globals.poti_squellette.talk(["You started a raid... Try to kill all the humans in this village in the shortest time possible to return to your base afterwards."])
		is_raided = true
		Globals.infamie += 2
		next_wave()
		next_wave()
		next_wave()
		next_wave()
		for i in unit_from_village:
			i.is_raided = true
