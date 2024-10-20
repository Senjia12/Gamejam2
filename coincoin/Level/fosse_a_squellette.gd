extends Sprite2D


@onready var state := [preload("res://Level/Décor/fosse/fosse 0.png"), preload("res://Level/Décor/fosse/fosse 1.png"), preload("res://Level/Décor/fosse/fosse 2.png"), preload("res://Level/Décor/fosse/fosse 3.png"), preload("res://Level/Décor/fosse/fosse 4.png"), preload("res://Level/Décor/fosse/fosse 5.png"), preload("res://Level/Décor/fosse/fosse 6.png"), preload("res://Level/Décor/fosse/fosse 7.png")]

const POTI_SQUELLETTE = preload("res://Unit/poti squellette/poti squellette.tscn")
const SQUELLETTE_ARCHER = preload("res://Unit/squellette archer/squellette_archer.tscn")
const SQUELLETTE_DISTANCE = preload("res://Unit/squellette distance/squellette distance.tscn")
const SQUELLETTE_PONEY = preload("res://Unit/squellette poney/squellette_poney.tscn")

@onready var spawn_parent: NavigationRegion2D = $"../Terrain/NavigationRegion2D"

@onready var pos: Node2D = $"spawn pos/pos"

var next_spawn

func _ready() -> void:
	Globals.bone_pill = self


func spawn(what):
	$"spawn pos".global_rotation = randi()%360
	next_spawn = what
	$delay.start()


func update_state(squellette):
	if squellette == 0:
		texture = state[0]
	elif squellette <= 20:
		texture = state[1]
	elif squellette <= 80:
		texture = state[2]
	elif squellette <= 200:
		texture = state[3]
	elif squellette <= 600:
		texture = state[4]
	elif squellette <= 1200:
		texture = state[5]
	elif squellette <= 2000:
		texture = state[6]
	else:
		texture = state[7]


func _on_delay_timeout() -> void:
	if $"spawn pos/pos/Area2D".get_overlapping_bodies() == []:
		if next_spawn == "poti squellette":
			var poti_squellette = POTI_SQUELLETTE.instantiate()
			poti_squellette.global_position = pos.global_position
			spawn_parent.add_child(poti_squellette)
		elif next_spawn == "squellette arché":
			var poti_squellette = SQUELLETTE_ARCHER.instantiate()
			poti_squellette.global_position = pos.global_position
			spawn_parent.add_child(poti_squellette)
		elif next_spawn == "squellette range":
			var poti_squellette = SQUELLETTE_DISTANCE.instantiate()
			poti_squellette.global_position = pos.global_position
			spawn_parent.add_child(poti_squellette)
		elif next_spawn == "ponney":
			var poti_squellette = SQUELLETTE_PONEY.instantiate()
			poti_squellette.global_position = pos.global_position
			spawn_parent.add_child(poti_squellette)
	else:
		$"spawn pos".global_rotation = randi()%360
		$delay.start()
