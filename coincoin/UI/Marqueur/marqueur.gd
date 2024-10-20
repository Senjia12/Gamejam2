extends Node2D


const MARQUEUR_ATTAQUE = preload("res://UI/Marqueur/marqueur attaque.png")

var type := "move"


func _ready() -> void:
	$AnimationPlayer.play("spawn")
	if type != "move":
		$Sprite2D.texture = MARQUEUR_ATTAQUE

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
