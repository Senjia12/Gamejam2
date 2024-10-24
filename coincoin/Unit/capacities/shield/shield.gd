extends Node2D

var taille = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	taille = get_parent().taille
	shield_tier()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var defensive_spell = "defense spell"

func shield_tier():
	if defensive_spell == "defense spell":
		shield_size()

	if defensive_spell == "defensive spell t2 explosive armor":
		shield_size()
		
	if defensive_spell == "defensive spell t3 regen explosive armor" :
		shield_size()

func shield_size():
	if taille == 1:
		$BouclierPetit.show()
		
	if taille == 2:
		$BouclierMoyen.show()
		
	if taille == 3:
		$BouclierGrand.show()
		
