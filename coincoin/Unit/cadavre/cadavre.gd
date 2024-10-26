extends Sprite2D


@onready var cadavre := [
	preload("res://Unit/cadavre/cadavre2.png"),
	preload("res://Unit/cadavre/cadavre3.png"),
	preload("res://Unit/cadavre/cadavre4.png"),
	preload("res://Unit/cadavre/cadavre5.png"),
	preload("res://Unit/cadavre/cadavre.png"),
]


func _ready() -> void:
	texture = cadavre[randi()%cadavre.size()]
	$AudioStreamPlayer2D.play()
