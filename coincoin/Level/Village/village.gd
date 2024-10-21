extends Node2D


@export var difficulty := 10
var road := Vector2.ZERO
var x_diff := 164
var y_diff := 264
var decalage := 64

const MAISON = [preload("res://Level/Village/maison scène/maison.tscn"),preload("res://Level/Village/maison scène/maison2.tscn"),preload("res://Level/Village/maison scène/maison3.tscn"),preload("res://Level/Village/maison scène/maison4.tscn"),preload("res://Level/Village/maison scène/maison5.tscn")]

var last_maison

func _ready() -> void:
	randomize()
	last_maison = MAISON[0]
	for i in difficulty:
		var y = i
		i += 1
		if i < difficulty / 2 + 2:
			pass
		else:
			i = difficulty - i + 1
		add_sub_road(i, i%2 == 0,y)



func add_sub_road(state: int, side_left : bool, y):
	var y_pos = road.y + y_diff * y / 2 + randi()%(decalage*2 + 1) - decalage
	for i in state:
		var maison = MAISON[randi()%MAISON.size()]
		while maison == last_maison:
			maison = MAISON[randi()%MAISON.size()]
		last_maison = maison
		var maison_i = maison.instantiate()
		var x_pos = road.x
		if !side_left:
			x_pos += x_diff * i + x_diff/2 + (randi()%(decalage*2 + 1) - decalage)/2
		else:
			x_pos -= x_diff * i + x_diff/ 2 + (randi()%(decalage*2 + 1) - decalage) / 2
		maison_i.global_position = Vector2(x_pos,y_pos)
		add_child(maison_i)
