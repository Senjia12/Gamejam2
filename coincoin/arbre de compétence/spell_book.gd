extends CanvasLayer

@onready var achat_squellette: VBoxContainer = $"../CanvasLayer/achat squellette"

var point := 0

var page := 0
var summon_tier := "t1"
var shield_tier := "t1"
var control_tier := "t1"
@onready var summoning: TextureRect = $summoning


## summon validé
const S_VALID__BAS_DROITE = preload("res://arbre de compétence/summon/validé bas droite.png")
const S_VALID__BAS_GAUCHE = preload("res://arbre de compétence/summon/validé bas gauche.png")
const S_VALID__HAUT_DROITE = preload("res://arbre de compétence/summon/validé haut droite.png")
const S_VALID__HAUT_GAUCHE = preload("res://arbre de compétence/summon/validé haut gauche.png")

## control et shield validé
const VALID__CAGE_T_2 = preload("res://arbre de compétence/defense + control/validé cage t2.png")
const VALID__CAGE_T_3 = preload("res://arbre de compétence/defense + control/validé cage t3.png")
const VALID__OMBRE_T_2 = preload("res://arbre de compétence/defense + control/validé ombre t2.png")
const VALID__OMBRE_T_3 = preload("res://arbre de compétence/defense + control/validé ombre t3.png")
const VALID__SHIELD_T_2 = preload("res://arbre de compétence/defense + control/validé shield t2.png")
const VALID__SHIELD_T_3 = preload("res://arbre de compétence/defense + control/validé shield t3.png")
const VALID__SLOW_T_2 = preload("res://arbre de compétence/defense + control/validé slow t2.png")
const VALID__SLOW_T_3 = preload("res://arbre de compétence/defense + control/validé slow t3.png")

func add_point(reset):
	if !reset:
		point = 1
	if summon_tier == "t1":
		$"summoning/t2 cac".disabled = reset
		$"summoning/t2 range".disabled = reset
	elif summon_tier == "t2 cac":$"summoning/t3 cac".disabled = reset
	elif summon_tier == "t2 range":$"summoning/t3 range".disabled = reset
	
	if shield_tier == "t1":
		$"defense && control/t2 shield".disabled = reset
		$"defense && control/t2 ombre".disabled = reset
	elif shield_tier == "t2 shield":$"defense && control/t3 shield".disabled = reset
	elif shield_tier == "t2 ombre":$"defense && control/t3 ombre".disabled = reset
	
	if control_tier == "t1":
		$"defense && control/t2 cage".disabled = reset
		$"defense && control/t2 slow".disabled = reset
	elif control_tier == "t2 cage":$"defense && control/t3 cage".disabled = reset
	elif control_tier == "t2 slow":$"defense && control/t3 slow".disabled = reset


func _on_next_pressed() -> void:
	page += 1
	get_child(page).hide()
	get_child(page + 1).show()

func _on_prev_pressed() -> void:
	page -= 1
	get_child(page + 2).hide()
	get_child(page + 1).show()

func _on_open_pressed() -> void:
	_on_next_pressed()

func _on_t_2_cac_pressed() -> void:
	if summon_tier == "t1" && point > 0:
		summon_tier = "t2 cac"
		achat_squellette.get_node("squellette gros").show()
		achat_squellette.get_node("squellette ponnay").show()
		$"summoning/barré range".show()
		$"summoning/t2 range".disabled = true
		$"summoning/t2 cac".texture_normal = S_VALID__HAUT_DROITE
		point = 0
		add_point(true)


func _on_t_3_cac_pressed() -> void:
	if summon_tier == "t2 cac" && point > 0:
		summon_tier = "t3 cac"
		achat_squellette.get_node("squellette énorme").show()
		$"summoning/t3 cac".texture_normal = S_VALID__BAS_DROITE
		point = 0
		add_point(true)


func _on_t_2_range_pressed() -> void:
	if summon_tier == "t1" && point > 0:
		summon_tier = "t2 range"
		achat_squellette.get_node("squellette arché").show()
		$"summoning/barré cac".show()
		$"summoning/t2 cac".disabled = true
		$"summoning/t2 range".texture_normal = S_VALID__HAUT_GAUCHE
		point = 0
		add_point(true)


func _on_t_3_range_pressed() -> void:
	if summon_tier == "t2 range" && point > 0:
		summon_tier = "t3 range"
		achat_squellette.get_node("squellette range").show()
		achat_squellette.get_node("squellette mortier").show()
		$"summoning/t3 range".texture_normal = S_VALID__BAS_GAUCHE
		point = 0
		add_point(true)


func _on_t_2_shield_pressed() -> void:
	if shield_tier == "t1" && point > 0:
		shield_tier = "t2 shield"
		$"defense && control/barré ombre".show()
		$"defense && control/t2 ombre".disabled = true
		$"defense && control/t2 shield".texture_normal = VALID__SHIELD_T_2
		point = 0
		add_point(true)


func _on_t_3_shield_pressed() -> void:
	if shield_tier == "t2 shield" && point > 0:
		shield_tier = "t3 shield"
		$"defense && control/t3 shield".texture_normal = VALID__SHIELD_T_3
		point = 0
		add_point(true)


func _on_t_2_ombre_pressed() -> void:
	if shield_tier == "t1" && point > 0:
		shield_tier = "t2 ombre"
		$"defense && control/barré shield".show()
		$"defense && control/t2 shield".disabled = true
		$"defense && control/t2 ombre".texture_normal = VALID__OMBRE_T_2
		point = 0
		add_point(true)


func _on_t_3_ombre_pressed() -> void:
	if shield_tier == "t2 ombre" && point > 0:
		shield_tier = "t3 ombre"
		$"defense && control/t3 ombre".texture_normal = VALID__OMBRE_T_3
		point = 0
		add_point(true)


func _on_t_2_cage_pressed() -> void:
	if control_tier == "t1" && point > 0:
		control_tier = "t2 cage"
		$"defense && control/barré slow".show()
		$"defense && control/t2 slow".disabled = true
		$"defense && control/t2 cage".texture_normal = VALID__CAGE_T_2
		point = 0
		add_point(true)
		Globals.player.get_node("control_spell").tier = 2


func _on_t_3_cage_pressed() -> void:
	if control_tier == "t2 cage" && point > 0:
		control_tier = "t3 cage"
		$"defense && control/t2 cage".texture_normal = VALID__CAGE_T_3
		point = 0
		add_point(true)
		Globals.player.get_node("control_spell").tier = 3


func _on_t_2_slow_pressed() -> void:
	if control_tier == "t1" && point > 0:
		control_tier = "t2 slow"
		$"defense && control/barré cage".show()
		$"defense && control/t2 cage".disabled = true
		$"defense && control/t2 slow".texture_normal = VALID__SLOW_T_2
		point = 0
		add_point(true)
		Globals.player.get_node("control_spell").tier = 2
		Globals.player.get_node("control_spell").control_type = "zone"


func _on_t_3_slow_pressed() -> void:
	if control_tier == "t2 slow" && point > 0:
		control_tier = "t3 slow"
		$"defense && control/t3 slow".texture_normal = VALID__SLOW_T_3
		point = 0
		add_point(true)
		Globals.player.get_node("control_spell").tier = 3


func _on_back_pressed() -> void:
	hide()
