extends Sprite2D


@onready var sprite_frame := [preload("res://Unit/humain nulle/couteau/couteau sprite.tres"), preload("res://Unit/humain nulle/faux/faux sprite.tres"), preload("res://Unit/humain nulle/fourchette/fourchette sprite.tres"), preload("res://Unit/humain nulle/pelle/pelle sprite.tres"),preload("res://Unit/humain nulle/torche/torche sprite.tres")]

@onready var anima: AnimatedSprite2D = $"../AnimatedSprite2D"



func _ready() -> void:
	anima.sprite_frames = sprite_frame[randi()%sprite_frame.size()]
	queue_free()
