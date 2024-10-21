extends Node2D


@onready var mana_bar: TextureProgressBar = $"spell cost/mana bar"


func _ready() -> void:
	Globals.mana = self


func _physics_process(delta: float) -> void:
	global_position = Globals.player.global_position


func cost(mana):
	for i in mana:
		if $Area2D.get_overlapping_areas() != []:
			$Area2D.get_overlapping_areas()[0].get_parent().queue_free()
		elif mana_bar.value >= 1.0:
			mana_bar.value -= 1
		else:
			return false
	return true
