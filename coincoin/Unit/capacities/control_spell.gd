extends Node2D


var can_control = true
const CAGE_T_12 = preload("res://Unit/capacities/cage/cage_t_12.tscn")
const CAGE_T_3 = preload("res://Unit/capacities/cage/cage_t_3.tscn")


var control_type = "cage"
var tier = 3

var ysort

func _ready() -> void:
	ysort = get_parent().get_parent().get_node("Terrain").get_node("NavigationRegion2D") 


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("control_spell") && can_control:
		if control_type == "cage" && tier <= 2:
			var cage = CAGE_T_12.instantiate()
			cage.t = tier
			cage.global_position = get_global_mouse_position()
			ysort.add_child(cage)
		elif control_type == "cage" && tier == 3:
			var cage = CAGE_T_3.instantiate()
			cage.global_position = get_global_mouse_position()
			ysort.add_child(cage)
			
		can_control = false
		$cd.start()

func _on_cd_timeout() -> void:
	can_control = true
