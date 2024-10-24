extends CanvasLayer

@onready var achat_squellette: VBoxContainer = $"../CanvasLayer/achat squellette"

var point := 0

var page := 0
var summon_tier := "t1"
var shield_tier := "t1"
@onready var summoning: TextureRect = $summoning

func _ready() -> void:
	add_point(false)


func add_point(reset):
	if !reset:
		point = 1
	if summon_tier == "t1":
		$"summoning/t2 cac".disabled = reset
		$"summoning/t2 range".disabled = reset
	elif summon_tier == "t2 cac":$"summoning/t3 cac".disabled = reset
	elif summon_tier == "t2 range":$"summoning/t3 range".disabled = reset


func _on_next_pressed() -> void:
	page += 1
	get_child(page).hide()
	get_child(page + 1).show()

func _on_prev_pressed() -> void:
	page -= 1
	get_child(page + 2).hide()
	get_child(page + 1).show()

func _on_open_pressed() -> void:
	_on_next_pressed()

func _on_t_2_cac_pressed() -> void:
	if summon_tier == "t1" && point > 0:
		summon_tier = "t2 cac"
		achat_squellette.get_node("squellette gros").show()
		achat_squellette.get_node("squellette ponnay").show()
		$"summoning/barré range".show()
		$"summoning/t2 range".disabled = true


func _on_t_3_cac_pressed() -> void:
	if summon_tier == "t2 cac" && point > 0:
		summon_tier = "t3 cac"
		achat_squellette.get_node("squellette énorme").show()


func _on_t_3_range_pressed() -> void:
	if summon_tier == "t2 range" && point > 0:
		summon_tier = "t3 range"
		achat_squellette.get_node("squellette range").show()
		achat_squellette.get_node("squellette mortier").show()


func _on_t_2_range_pressed() -> void:
	if summon_tier == "t1" && point > 0:
		summon_tier = "t2 range"
		achat_squellette.get_node("squellette arché").show()
		$"summoning/barré cac".show()
		$"summoning/t2 cac".disabled = true
