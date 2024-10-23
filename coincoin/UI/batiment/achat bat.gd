extends TextureRect


@export var bat_type := "kboom"

@export var price := 10
@onready var spawn: NavigationRegion2D = $"../../../Terrain/NavigationRegion2D"

const KABOOMEUR = preload("res://batiment/kaboomeur/kaboomeur.tscn")
const TOURELLE_D_AGRO = preload("res://batiment/Tourelle agro/tourelle_d'agro.tscn")
const TOURELLE_D_ATTAQUE = preload("res://batiment/tourelle d'attaque/tourelle d'attaque.tscn")


func _on_buy_pressed() -> void:
	if !Globals.is_pausing_bat:
		if Globals.bone_counter.cost(price):
			if bat_type == "kboom":
				spawn.add_child(KABOOMEUR.instantiate())
				Globals.is_pausing_bat = true
			elif bat_type == "agro":
				spawn.add_child(TOURELLE_D_AGRO.instantiate())
				Globals.is_pausing_bat = true
			elif bat_type == "poti archer":
				spawn.add_child(TOURELLE_D_ATTAQUE.instantiate())
				Globals.is_pausing_bat = true
