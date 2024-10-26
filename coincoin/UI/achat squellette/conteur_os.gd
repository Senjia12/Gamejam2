extends TextureRect


var current_bones := 50.0
@onready var display: Label = $Label
const COMPTEUR_DOSROUGE_2 = preload("res://UI/compteur_dosrouge2.png")
const COMPTEUR_OS = preload("res://UI/achat squellette/compteur_os.png")

func _ready() -> void:
	Globals.bone_counter = self


func take_damage(dmg):
	current_bones -= dmg / 10.0
	display.text = str(int(current_bones))
	Globals.bone_pill.update_state(current_bones)
	texture = COMPTEUR_DOSROUGE_2
	$Timer.start()
	if current_bones <= 0:
		$"../end_screen".show()



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


func _on_timer_timeout() -> void:
	texture = COMPTEUR_OS
