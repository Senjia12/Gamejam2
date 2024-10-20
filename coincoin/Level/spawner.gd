extends TextureRect

@export var cost := 2
@export var type := "poti squellette"


func _ready() -> void:
	$spawn.connect("pressed",Callable(self,"spawn"))


func spawn():
	if Globals.bone_counter.cost(cost):
		Globals.bone_pill.spawn(type)
