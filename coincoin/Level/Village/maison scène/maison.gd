extends Sprite2D


@export var maison_number := 0


const B_MAISON_0 = preload("res://Level/Village/maison scène/b maison 0.png")
const B_MAISON_2 = preload("res://Level/Village/maison scène/b maison 2.png")
const B_MAISON_3 = preload("res://Level/Village/maison scène/b maison 3.png")
const B_MAISON_4 = preload("res://Level/Village/maison scène/b maison 4.png")
const B_MAISON_5 = preload("res://Level/Village/maison scène/b maison 5.png")



func burn():
	if maison_number == 0:
		texture = B_MAISON_0
	elif maison_number == 2:
		texture = B_MAISON_2
	elif maison_number == 3:
		texture = B_MAISON_3
	elif maison_number == 4:
		texture = B_MAISON_4
	elif maison_number == 5:
		texture = B_MAISON_5
