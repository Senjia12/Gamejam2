extends Node2D

var tier
var taille = 1
var shield

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	taille = get_parent().taille
	shield = get_parent().shield
	
	if tier == "defensive spell t3 regen explosive armor":
		$shield_regen_cd.start

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shield_size():
	if taille == 1:
		$BouclierPetit.show()
		
	if taille == 2:
		$BouclierMoyen.show()
		
	if taille == 3:
		$BouclierGrand.show()
		

func _on_shield_regen_cd_timeout() -> void:
	shield += 0.5
