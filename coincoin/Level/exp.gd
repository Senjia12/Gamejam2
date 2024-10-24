extends Control


var level := 0
var exp_next := 100.0
@onready var exp_value: TextureProgressBar = $"exp value"
const UIIIEXPACTIVATEDL = preload("res://UI/exp/uiiiexpactivatedl.png")
const BOUTTON = preload("res://UI/exp/boutton.png")

func _ready() -> void:
	Globals.exp = self


func _physics_process(delta: float) -> void:
	add_exp(1)


func add_exp(exp):
	exp_value.value += exp
	if exp_value.value >= exp_next:
		level += 1
		exp_value.value = 0
		exp_next = 100 + (level * 10)
		exp_value.max_value = exp_next
		$access.texture_normal = UIIIEXPACTIVATEDL


func _on_access_pressed() -> void:
	pass # Replace with function body.
