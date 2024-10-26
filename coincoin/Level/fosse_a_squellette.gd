extends AnimatedSprite2D


@onready var state := [preload("res://Level/Décor/fosse/fosse 0.png"), preload("res://Level/Décor/fosse/fosse 1.png"), preload("res://Level/Décor/fosse/fosse 2.png"), preload("res://Level/Décor/fosse/fosse 3.png"), preload("res://Level/Décor/fosse/fosse 4.png"), preload("res://Level/Décor/fosse/fosse 5.png"), preload("res://Level/Décor/fosse/fosse 6.png"), preload("res://Level/Décor/fosse/fosse 7.png")]

const POTI_SQUELLETTE = preload("res://Unit/poti squellette/poti squellette.tscn")
const SQUELLETTE_ARCHER = preload("res://Unit/squellette archer/squellette_archer.tscn")
const SQUELLETTE_DISTANCE = preload("res://Unit/squellette distance/squellette distance.tscn")
const SQUELLETTE_PONEY = preload("res://Unit/squellette poney/squellette_poney.tscn")
const SQUELLETTE_MORTIER = preload("res://Unit/squellette mortier/squellette_mortier.tscn")
const SQUELLETTE_GROS = preload("res://Unit/gros quellette/squellette_gros.tscn")
const SQUELLETTE_ENORME = preload("res://Unit/squellette énorme/squellette_enorme.tscn")

@onready var spawn_parent: NavigationRegion2D = $"../Terrain/NavigationRegion2D"

@onready var pos: Node2D = $"spawn pos/pos"

var next_spawn

func _ready() -> void:
	Globals.bone_pill = self
	update_state(50)


func _physics_process(delta: float) -> void:
	if reav:$"FOW revealer".texture_scale += Vector2(1,1)


func spawn(what):
	$"spawn pos".global_rotation = randi()%360
	next_spawn = what
	$delay.start()
	$"../ui".play()
	$spawn.play()

var reav = false
func reveale():
	reav = true


func update_state(squellette):
	if squellette == 0:
		frame = 0
	elif squellette <= 20:
		frame = 1
	elif squellette <= 60:
		frame = 2
	elif squellette <= 100:
		frame = 3
	elif squellette <= 150:
		frame = 4
	elif squellette <= 250:
		frame = 5
	elif squellette <= 500:
		frame = 6
	else:
		frame = 7


func _on_delay_timeout() -> void:
	if $"spawn pos/pos/Area2D".get_overlapping_bodies() == []:
		var poti_squellette
		if next_spawn == "poti squellette":
			poti_squellette = POTI_SQUELLETTE.instantiate()
		elif next_spawn == "squellette arché":
			poti_squellette = SQUELLETTE_ARCHER.instantiate()
		elif next_spawn == "squellette range":
			poti_squellette = SQUELLETTE_DISTANCE.instantiate()
		elif next_spawn == "ponney":
			poti_squellette = SQUELLETTE_PONEY.instantiate()
		elif next_spawn == "motier":
			poti_squellette = SQUELLETTE_MORTIER.instantiate()
		elif next_spawn == "squellette gros":
			poti_squellette = SQUELLETTE_GROS.instantiate()
		elif next_spawn == "squellette enomre":
			poti_squellette = SQUELLETTE_ENORME.instantiate()
		poti_squellette.global_position = pos.global_position
		spawn_parent.add_child(poti_squellette)
	else:
		$"spawn pos".global_rotation = randi()%360
		$delay.start()
