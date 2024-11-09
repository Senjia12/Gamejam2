extends Node2D

var tier
var taille
var shield
var explosion = false
var explosion_end = true
var cooldown_multiplier
var shield_destroyed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tier != "defensive spell t2 shadow veil" or tier !="defensive spell t3 extended shadow veil" && shield_destroyed == false:
		shield = get_parent().shield
		taille = get_parent().taille
		shield_size()
		$shield_explosion.start
				
		if tier == "defensive spell t3 regen explosive armor" && shield != 0:
			$shield_regen_cd.start
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if explosion == true && shield_destroyed == false:
		for i in $shield_explo.get_overlapping_bodies():
			i.take_damage(10)
			
	if shield == 0 or shield_destroyed == true:
		shield_destroyed = true
		shield = 0

func shield_size():

	if explosion_end == true &&  shield_destroyed == false:
		if taille == 1:
			$BouclierPetit.show()
			
		if taille == 2:
			$BouclierMoyen.show()
			
		if taille == 3:
			$BouclierGrand.show()
	
func shield_explosion(): 
	explosion_end = false
	if taille == 1:
		if tier == "defensive spell t3 regen explosive armor":
			$shield_explo/petite_explosion.play("t3_petite_explosion")
		else:
			$shield_explo/petite_explosion.play("default")
		
	if taille == 2:
		if tier == "defensive spell t3 regen explosive armor":
			$shield_explo/moyenne_explosion.play("t3_moyenne_explosion")
		else:
			$shield_explo/moyenne_explosion.play("default")
		
	if taille == 3:
		if tier == "defensive spell t3 regen explosive armor":
			$shield_explo/grande_explosion.play("t3_grande_explosion")
		else:
			$shield_explo/grande_explosion.play("default")
	$explosion_end.start()
		
func _on_shield_regen_cd_timeout() -> void:
	shield += 0.5

func _on_shield_explosion_timeout() -> void:
	explosion = true
	shield_explosion()

func _on_explosion_end_timeout() -> void: #durée explosion
	explosion_end = true
	explosion = false
	if tier == "defensive spell t3 regen explosive armor" &&  shield_destroyed == false:
		shield_size()
	else:
		shield_destroyed == true
