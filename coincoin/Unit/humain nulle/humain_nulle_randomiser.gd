extends Sprite2D


@onready var sprite_frame := [preload("res://Unit/humain nulle/couteau/couteau sprite.tres"), preload("res://Unit/humain nulle/faux/faux sprite.tres"), preload("res://Unit/humain nulle/fourchette/fourchette sprite.tres"), preload("res://Unit/humain nulle/pelle/pelle sprite.tres"),preload("res://Unit/humain nulle/torche/torche sprite.tres")]
@onready var attack_frame := [preload("res://Unit/humain nulle/couteau/couteau attaque.tres"), preload("res://Unit/humain nulle/faux/faux attaque.tres"), preload("res://Unit/humain nulle/fourchette/fourchette attaque.tres"), preload("res://Unit/humain nulle/pelle/attack pelle.tres"), preload("res://Unit/humain nulle/torche/attack torche.tres")]

@onready var attack: AnimatedSprite2D = $"../attack"
@onready var anima: AnimatedSprite2D = $"../AnimatedSprite2D"


var y_offset := {"1" = 11, "2" = 2.5, "3" = 6.5, "4" = 8, "5" = 9.5}


func _ready() -> void:
	var sprite = randi()%5
	anima.sprite_frames = sprite_frame[sprite]
	attack.sprite_frames = attack_frame[sprite]
	attack.offset.y = - y_offset[str(sprite + 1)]
	queue_free()
