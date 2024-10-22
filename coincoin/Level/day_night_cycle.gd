extends AnimationPlayer

const CURSEUR_BASE = preload("res://UI/curseur base.png")
@export var light_mix := 1.0



func _ready() -> void:
	_on_animation_finished("duck")


func _physics_process(delta: float) -> void:
	for i in get_tree().get_nodes_in_group("fow"):
		i.energy = light_mix



func _on_day_duration_timeout() -> void:
	Globals.night = true
	for unit in get_tree().get_nodes_in_group("Unit"):
		unit.enabled()
	for i in get_tree().get_nodes_in_group("cadavre"):
		Globals.bone_counter.add_bones(1)
		i.queue_free()



func _on_animation_finished(anim_name: StringName) -> void:
	Globals.unit_select = []
	Input.set_custom_mouse_cursor(CURSEUR_BASE)
	
	Globals.night = false
	$"day duration".start()
	play("day nighy")
	for unit in get_tree().get_nodes_in_group("Unit"):
		unit.disabled()
	for i in get_tree().get_nodes_in_group("village"):
		i.next_wave()
