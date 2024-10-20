extends Sprite2D


@onready var state := [preload("res://Level/Décor/fosse/fosse 0.png"), preload("res://Level/Décor/fosse/fosse 1.png"), preload("res://Level/Décor/fosse/fosse 2.png"), preload("res://Level/Décor/fosse/fosse 3.png"), preload("res://Level/Décor/fosse/fosse 4.png"), preload("res://Level/Décor/fosse/fosse 5.png"), preload("res://Level/Décor/fosse/fosse 6.png"), preload("res://Level/Décor/fosse/fosse 7.png")]


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
