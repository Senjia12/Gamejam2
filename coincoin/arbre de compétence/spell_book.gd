extends CanvasLayer

@onready var achat_squellette: VBoxContainer = $"../CanvasLayer/achat squellette"

var point := 0

var page := 0
var summon_tier := "t1"
var shield_tier := "disabled"
var control_tier := "t1"
var attack_tier := "t1"
var trans_tier := "t1"
var boom_tier := "t1"
var res_tier := "t1"
var sa_tier := "t1"
var nzo_tier := "t1"
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

## attack validé
const BAS_DROITE_AA = preload("res://arbre de compétence/offensif/bas droite aa.png")
const BAS_GAUCHE_AA = preload("res://arbre de compétence/offensif/bas gauche aa.png")
const HAUT_GAUCHE_AA = preload("res://arbre de compétence/offensif/haut gauche aa.png")
const HAUT_DROITE_AA = preload("res://arbre de compétence/offensif/haut droite aa.png")

## trans validé
const ASSI_BDAA = preload("res://arbre de compétence/trans/assi bdaa.png")
const ASSI_BGAA = preload("res://arbre de compétence/trans/assi bgaa.png")
const ASSI_TDAA = preload("res://arbre de compétence/trans/assi tdaa.png")
const ASSI_TGAA = preload("res://arbre de compétence/trans/assi tgaa.png")

const B_CHO_BDAA = preload("res://arbre de compétence/trans/b cho bdaa.png")
const B_CHO_BGAA = preload("res://arbre de compétence/trans/b cho bgaa.png")
const B_CHO_TDAA = preload("res://arbre de compétence/trans/b cho tdaa.png")
const B_CHO_TGAA = preload("res://arbre de compétence/trans/b cho tgaa.png")

const R_CHO_BDAA = preload("res://arbre de compétence/trans/r cho bdaa.png")
const R_CHO_BGAA = preload("res://arbre de compétence/trans/r cho bgaa.png")
const R_CHO_TDAA = preload("res://arbre de compétence/trans/r cho tdaa.png")
const R_CHO_TGAA = preload("res://arbre de compétence/trans/r cho tgaa.png")

## summon validé
const D_BAS_DROITE_AA = preload("res://arbre de compétence/summon spell/bas droite aa.png")
const D_BAS_GAUCHE_AA = preload("res://arbre de compétence/summon spell/bas gauche aa.png")
const D_HAUT_DROITE_AA = preload("res://arbre de compétence/summon spell/haut droite aa.png")
const D_HAUT_GAUCHE_AA = preload("res://arbre de compétence/summon spell/haut gauche aa.png")

const _2_BAS_DROITE_AA = preload("res://arbre de compétence/summon spell/2 bas droite aa.png")
const _2_BAS_GAUCHE_AA = preload("res://arbre de compétence/summon spell/2 bas gauche aa.png")
const _2_HAUT_DROITE_AA = preload("res://arbre de compétence/summon spell/2 haut droite aa.png")
const _2_HAUT_GAUCHE_AA = preload("res://arbre de compétence/summon spell/2 haut gauche aa.png")

func add_point(reset):
	if !reset:
		point = 1
	if summon_tier == "t1":
		$"summoning/t2 cac".disabled = reset
		$"summoning/t2 range".disabled = reset
	elif summon_tier == "t2 cac":$"summoning/t3 cac".disabled = reset
	elif summon_tier == "t2 range":$"summoning/t3 range".disabled = reset
	
#	if shield_tier == "t1":
#		$"defense && control/t2 shield".disabled = reset
#		$"defense && control/t2 ombre".disabled = reset
#	elif shield_tier == "t2 shield":$"defense && control/t3 shield".disabled = reset
#	elif shield_tier == "t2 ombre":$"defense && control/t3 ombre".disabled = reset
	
	if control_tier == "t1":
		$"defense && control/t2 cage".disabled = reset
		$"defense && control/t2 slow".disabled = reset
	elif control_tier == "t2 cage":$"defense && control/t3 cage".disabled = reset
	elif control_tier == "t2 slow":$"defense && control/t3 slow".disabled = reset
	
	if attack_tier == "t1":
		$"attack/t2 boom".disabled = reset
		$"attack/t2 trai".disabled = reset
	elif attack_tier == "t2 boom":$"attack/t3 boom".disabled = reset
	elif attack_tier == "t2 trai":$"attack/t3 trai".disabled = reset
	
	if trans_tier == "t1":
		$"trans/t2 resi".disabled = reset
		$"trans/t2 smo".disabled = reset
	elif trans_tier == "t2 resi":$"trans/t3 resi".disabled = reset
	elif trans_tier == "t2 smo":$"trans/t3 smo".disabled = reset
	
	if boom_tier == "t1":
		$"trans/t2 gc".disabled = reset
		$"trans/t2 dmg".disabled = reset
	elif boom_tier == "t2 gc":$"trans/t3 gc".disabled = reset
	elif boom_tier == "t2 dmg":$"trans/t3 dmg".disabled = reset
	
	if res_tier == "t1":
		$"trans/t2 fas".disabled = reset
		$"trans/t2 hp".disabled = reset
	elif res_tier == "t2 fas":$"trans/t3 fas".disabled = reset
	elif res_tier == "t2 hp":$"trans/t3 hp".disabled = reset
	
	if sa_tier == "t1":
		$"summon/t2 sca".disabled = reset
		$"summon/t2 sra".disabled = reset
	elif res_tier == "t2 sra":$"summon/t3 sra".disabled = reset
	elif res_tier == "t2 sca":$"summon/t3 sca".disabled = reset
	
	if nzo_tier == "t1":
		$"summon/t2 bau".disabled = reset
		$"summon/t2 slau".disabled = reset
	elif nzo_tier == "t2 bau":$"summon/t3 bau".disabled = reset
	elif nzo_tier == "t2 slau":$"summon/t3 slau".disabled = reset



func _on_next_pressed() -> void:
	page += 1
	get_child(page).hide()
	get_child(page + 1).show()
	$flip.play()

func _on_prev_pressed() -> void:
	page -= 1
	get_child(page + 2).hide()
	get_child(page + 1).show()
	$flip2.play()

func _on_open_pressed() -> void:
	_on_next_pressed()

func _on_back_pressed() -> void:
	hide()
	get_tree().paused = false

func _on_t_2_cac_pressed() -> void:
	if summon_tier == "t1" && point > 0:
		summon_tier = "t2 cac"
		achat_squellette.get_node("squellette gros").show()
		achat_squellette.get_node("squellette ponnay").show()
		$"summoning/barré range".show()
		$"../CanvasLayer/achat bati/explos".show()
		$"summoning/t2 range".disabled = true
		$"summoning/t2 cac".texture_normal = S_VALID__HAUT_DROITE
		point = 0
		add_point(true)


func _on_t_3_cac_pressed() -> void:
	if summon_tier == "t2 cac" && point > 0:
		summon_tier = "t3 cac"
		achat_squellette.get_node("squellette énorme").show()
		$"summoning/t3 cac".texture_normal = S_VALID__BAS_DROITE
		$"../CanvasLayer/achat bati/tour d'aggro".show()
		point = 0
		add_point(true)


func _on_t_2_range_pressed() -> void:
	if summon_tier == "t1" && point > 0:
		summon_tier = "t2 range"
		achat_squellette.get_node("squellette arché").show()
		$"summoning/barré cac".show()
		$"summoning/t2 cac".disabled = true
		$"summoning/t2 range".texture_normal = S_VALID__HAUT_GAUCHE
		$"../CanvasLayer/achat bati/tour d'archer".show()
		point = 0
		add_point(true)


func _on_t_3_range_pressed() -> void:
	if summon_tier == "t2 range" && point > 0:
		summon_tier = "t3 range"
		achat_squellette.get_node("squellette range").show()
		achat_squellette.get_node("squellette mortier").show()
		$"summoning/t3 range".texture_normal = S_VALID__BAS_GAUCHE
		$"../CanvasLayer/achat bati/bumper".show()
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



func _on_t_2_boom_pressed() -> void:
	if attack_tier == "t1" && point > 0:
		attack_tier = "t2 boom"
		$"attack/barré trai".show()
		$"attack/t2 trai".disabled = true
		$"attack/t2 boom".texture_normal = HAUT_GAUCHE_AA
		Globals.player.get_node("offensive_spell").tier = 2
		point = 0
		add_point(true)


func _on_t_3_boom_pressed() -> void:
	if attack_tier == "t2 boom" && point > 0:
		attack_tier = "t3 boom"
		$"attack/t3 boom".texture_normal = BAS_GAUCHE_AA
		Globals.player.get_node("offensive_spell").tier = 3
		point = 0
		add_point(true)


func _on_t_2_trai_pressed() -> void:
	if attack_tier == "t1" && point > 0:
		attack_tier = "t2 trai"
		$"attack/barré boom".show()
		$"attack/t2 boom".disabled = true
		$"attack/t2 trai".texture_normal = HAUT_DROITE_AA
		Globals.player.get_node("offensive_spell").tier = 2
		Globals.player.get_node("offensive_spell").state = "ray"
		point = 0
		add_point(true)


func _on_t_3_trai_pressed() -> void:
	if attack_tier == "t2 trai" && point > 0:
		attack_tier = "t3 trai"
		$"attack/t3 trai".texture_normal = BAS_GAUCHE_AA
		Globals.player.get_node("offensive_spell").tier = 3
		point = 0
		add_point(true)


func _on_t_2_smo_pressed() -> void:
	if trans_tier == "t1" && point > 0:
		trans_tier = "t2 smo"
		$"trans/barré resi".show()
		$"trans/t2 resi".disabled = true
		$"trans/t2 smo".texture_normal = ASSI_TGAA
		Globals.player.speed = 150
		point = 0
		add_point(true)


func _on_t_3_smo_pressed() -> void:
	if attack_tier == "t2 smo" && point > 0:
		attack_tier = "t3 smo"
		$"trans/t3 smo".texture_normal = ASSI_BGAA
		Globals.player.speed = 200
		point = 0
		add_point(true)


func _on_t_2_resi_pressed() -> void:
	if trans_tier == "t1" && point > 0:
		trans_tier = "t2 resi"
		$"trans/barré smo".show()
		$"trans/t2 smo".disabled = true
		$"trans/t2 resi".texture_normal = ASSI_TDAA
		Globals.mana.upgrade(1)
		point = 0
		add_point(true)


func _on_t_3_resi_pressed() -> void:
	if attack_tier == "t2 resi" && point > 0:
		attack_tier = "t3 resi"
		$"trans/t3 resi".texture_normal = ASSI_BDAA
		Globals.mana.upgrade(2)
		point = 0
		add_point(true)


func _on_t_2_gc_pressed() -> void:
	if boom_tier == "t1" && point > 0:
		boom_tier = "t2 gc"
		$"trans/barré dmg".show()
		$"trans/t2 dmg".disabled = true
		$"trans/t2 gc".texture_normal = B_CHO_TGAA
		Globals.squ_dmg_mult = 2.0
		Globals.squ_hp_mult *= 0.5
		for i in get_tree().get_nodes_in_group("Unit"):
			i.update_stat()
		point = 0
		add_point(true)


func _on_t_3_gc_pressed() -> void:
	if boom_tier == "t2 gc" && point > 0:
		boom_tier = "t3 gc"
		$"trans/t3 gc".texture_normal = B_CHO_TDAA
		Globals.squ_dmg_mult = 3.0
		Globals.squ_hp_mult *= 0.5
		for i in get_tree().get_nodes_in_group("Unit"):
			i.update_stat()
		point = 0
		add_point(true)


func _on_t_2_dmg_pressed() -> void:
	if boom_tier == "t1" && point > 0:
		boom_tier = "t2 dmg"
		$"trans/barré gc".show()
		$"trans/t2 gc".disabled = true
		$"trans/t2 dmg".texture_normal = B_CHO_BGAA
		Globals.squ_dmg_mult = 1.5
		for i in get_tree().get_nodes_in_group("Unit"):
			i.update_stat()
		point = 0
		add_point(true)


func _on_t_3_dmg_pressed() -> void:
	if boom_tier == "t2 dmg" && point > 0:
		boom_tier = "t3 dmg"
		$"trans/t3 dmg".texture_normal = B_CHO_BDAA
		Globals.squ_dmg_mult = 2
		for i in get_tree().get_nodes_in_group("Unit"):
			i.update_stat()
		point = 0
		add_point(true)


func _on_t_2_fas_pressed() -> void:
	if res_tier == "t1" && point > 0:
		res_tier = "t2 fas"
		$"trans/barré hp".show()
		$"trans/t2 hp".disabled = true
		$"trans/t2 fas".texture_normal = R_CHO_TGAA
		Globals.squ_sp_mult += 0.5
		point = 0
		add_point(true)


func _on_t_3_fas_pressed() -> void:
	if res_tier == "t2 fas" && point > 0:
		res_tier = "t3 fas"
		$"trans/t3 fas".texture_normal = R_CHO_TDAA
		Globals.squ_hp_mult *= 2
		point = 0
		add_point(true)


func _on_t_2_hp_pressed() -> void:
	if res_tier == "t1" && point > 0:
		res_tier = "t2 hp"
		$"trans/barré fas".show()
		$"trans/t2 fas".disabled = true
		$"trans/t2 hp".texture_normal = R_CHO_BGAA
		Globals.squ_hp_mult *= 2
		for i in get_tree().get_nodes_in_group("Unit"):
			i.update_stat()
		point = 0
		add_point(true)


func _on_t_3_hp_pressed() -> void:
	if res_tier == "t2 hp" && point > 0:
		res_tier = "t3 hp"
		$"trans/t3 hp".texture_normal = R_CHO_BDAA
		Globals.squ_hp_mult *= 2
		for i in get_tree().get_nodes_in_group("Unit"):
			i.update_stat()
		point = 0
		add_point(true)


func _on_t_2_sca_pressed() -> void:
	if sa_tier == "t1" && point > 0:
		sa_tier = "t2 sca"
		$"summon/barré sra".show()
		$"summon/t2 sra".disabled = true
		$"summon/t2 sca".texture_normal = D_HAUT_GAUCHE_AA
		Globals.player.get_node("summon_spell").tier = 2
		point = 0
		add_point(true)


func _on_t_3_sca_pressed() -> void:
	if sa_tier == "t2 sca" && point > 0:
		res_tier = "t3 sca"
		$"summon/t3 sca".texture_normal = D_BAS_GAUCHE_AA
		Globals.player.get_node("summon_spell").tier = 3
		point = 0
		add_point(true)


func _on_t_2_sra_pressed() -> void:
	if sa_tier == "t1" && point > 0:
		sa_tier = "t2 sra"
		$"summon/barré sca".show()
		$"summon/t2 sca".disabled = true
		$"summon/t2 sra".texture_normal = D_HAUT_DROITE_AA
		Globals.player.get_node("summon_spell").tier = 2
		Globals.player.get_node("summon_spell").spé = "range"
		point = 0
		add_point(true)


func _on_t_3_sra_pressed() -> void:
	if sa_tier == "t2 sra" && point > 0:
		res_tier = "t3 sra"
		$"summon/t3 sra".texture_normal = D_BAS_DROITE_AA
		Globals.player.get_node("summon_spell").tier = 3
		point = 0
		add_point(true)


func _on_t_2_bau_pressed() -> void:
	if nzo_tier == "t1" && point > 0:
		nzo_tier = "t2 bau"
		$"summon/barré slau".show()
		$"summon/t2 slau".disabled = true
		$"summon/t2 bau".texture_normal = _2_HAUT_GAUCHE_AA
		$"../night aura/night aura".scale_up(2)
		point = 0
		add_point(true)


func _on_t_3_bau_pressed() -> void:
	if nzo_tier == "t2 bau" && point > 0:
		nzo_tier = "t3 bau"
		$"summon/t3 bau".texture_normal = _2_BAS_GAUCHE_AA
		$"../night aura/night aura".tier = "regen"
		point = 0
		add_point(true)


func _on_t_2_slau_pressed() -> void:
	if nzo_tier == "t1" && point > 0:
		nzo_tier = "t2 slau"
		$"summon/barré bau".show()
		$"summon/t2 bau".disabled = true
		$"summon/t2 slau".texture_normal = _2_HAUT_DROITE_AA
		$"../night aura/night aura".scale_up(1.5)
		$"../night aura/night aura".tier = "slow"
		point = 0
		add_point(true)


func _on_t_3_slau_pressed() -> void:
	if nzo_tier == "t2 slau" && point > 0:
		nzo_tier = "t3 slau"
		$"summon/t3 slau".texture_normal = _2_BAS_DROITE_AA
		$"../night aura/night aura".scale_up(1.5)
		$"../night aura/night aura".tier = "dmg"
		point = 0
		add_point(true)
