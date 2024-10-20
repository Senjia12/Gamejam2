extends TextureRect


var current_bones := 50
@onready var display: Label = $Label


func _ready() -> void:
	Globals.bone_counter = self


func add_bones(bones):
	current_bones += bones
	display.text = str(current_bones)
	Globals.bone_pill.update_state(current_bones)


func cost(bones):
	if bones <= current_bones:
		current_bones -= bones
		display.text = str(current_bones)
		Globals.bone_pill.update_state(current_bones)
		return true
	return false
