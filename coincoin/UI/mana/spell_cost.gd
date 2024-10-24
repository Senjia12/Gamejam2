extends Node2D


@onready var mana_bar: TextureProgressBar = $"spell cost/mana bar"
var is_freeze := false
var regen_passive := 1

func _ready() -> void:
	Globals.mana = self

func _physics_process(delta: float) -> void:
	global_position = Globals.player.global_position


func freeze():
	is_freeze = true
	$"Spell cost/freeze duartion".start()


func upgrade(level):
	if level == 1:
		mana_bar.max_value = 200
		mana_bar.value *= 2
		regen_passive = 2
	elif level == 2:
		mana_bar.max_value = 500
		mana_bar.value *= 2.5
		regen_passive = 10


func cost(mana):
	if $Area2D.get_overlapping_areas().size() + mana_bar.value > mana && !is_freeze && !Globals.nécro_mort:
		for i in mana:
			if $Area2D.get_overlapping_areas() != []:
				$Area2D.get_overlapping_areas()[0].get_parent().queue_free()
			elif mana_bar.value >= 1.0:
				mana_bar.value -= 1.0
		return true
	else:
		return false

func _on_timer_timeout() -> void:
	mana_bar.value += regen_passive

func _on_freeze_duartion_timeout() -> void:
	is_freeze = false
