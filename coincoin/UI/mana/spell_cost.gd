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
		elif mana_bar.value >= summon_cost:
			mana_bar.value -= summon_cost
		else:
			return false
	return true
	
func summon_tier():
	if summon_spell == "summon spell":
		summon_cost = 4
	
	if summon_spell == "summon spell t2_skeleton":

#différents summons
var summon_spell = "summon spell"
var summon_cost = 4
var summon_spell_t2_skeleton = false
var summon_spell_t3_explosive_skeleton = false
var summon_spell_t2_golem = false
var summon_spell_t3_ice_storm_golem = false


func _on_timer_timeout() -> void:
	mana_bar.value += 0.1
