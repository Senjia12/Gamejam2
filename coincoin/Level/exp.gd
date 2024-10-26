extends Control


var level := 0
var exp_next := 80.0
@onready var exp_value: TextureProgressBar = $"exp value"
const UIIIEXPACTIVATEDL = preload("res://UI/exp/uiiiexpactivatedl.png")
const BOUTTON = preload("res://UI/exp/boutton.png")
@onready var spell_book: CanvasLayer = $"../../spell book"

var blabla_point := ["Look at your book, it's waiting for you !","You can learn a skill right now !"]


func _ready() -> void:
	Globals.exp = self


func add_exp(exp):
	exp_value.value += exp
	if exp_value.value >= exp_next:
		if level == 0:
			Globals.poti_squellette.talk(["Well, you killed a lot of humans since the beginning... Look at your book, you can learn a skill, like upgrading a spell, or a new skeleton if you want."])
		else:
			Globals.poti_squellette.talk([blabla_point[randi()%blabla_point.size()]])
		level += 1
		exp_value.value = 0
		exp_next = 80 + (level * 30)
		exp_value.max_value = exp_next
		$access.texture_normal = UIIIEXPACTIVATEDL
		spell_book.add_point(false)


func _on_access_pressed() -> void:
	spell_book.show()
	$access.texture_normal = BOUTTON
	get_tree().paused = true
