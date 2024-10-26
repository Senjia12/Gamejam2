extends AnimationPlayer

const CURSEUR_BASE = preload("res://UI/curseur base.png")
@export var light_mix := 1.0

var current_day := 0

var blabla_jour := ["It's daylight, be careful !","The humans will come, it's daylight !"]
var blabla_nuit := ["It's night ! Let's prepare your defense !"]


func _ready() -> void:
	_on_animation_finished("duck")


func _physics_process(delta: float) -> void:
	for i in get_tree().get_nodes_in_group("fow"):
		i.energy = light_mix


func _on_day_duration_timeout() -> void:
	Globals.infamie += 1
	Globals.night = true
	for unit in get_tree().get_nodes_in_group("Unit"):
		unit.enabled()
	for i in get_tree().get_nodes_in_group("cadavre"):
		Globals.bone_counter.add_bones(1)
		i.queue_free()
	for i in get_tree().get_nodes_in_group("Humain"):
		i.run()
	for i in get_tree().get_nodes_in_group("reset HP"):
		i.hp = i.max_hp
	$"../night aura/night aura".disable()
	
	$"../Musique".transi("night")
	if current_day == 1:
		Globals.poti_squellette.talk(["IIt's night now, the humans won't attack you for a moment. So you have time to prepare your defense.", "As you can see, you can create some skeletons using your corpses. Let's make some, and move them where you want with your mouse."])
	else:
		Globals.poti_squellette.talk(["It's night ! Let's prepare your defense !"])

func _on_animation_finished(anim_name: StringName) -> void:
	current_day += 1
	Globals.unit_select = []
	Input.set_custom_mouse_cursor(CURSEUR_BASE)
	$"../Terrain/NavigationRegion2D".bake_navigation_polygon()
	$"../Musique".transi("day")
	Globals.night = false
	$"day duration".start()
	play("day nighy")
	for unit in get_tree().get_nodes_in_group("Unit"):
		unit.disabled()
	for i in get_tree().get_nodes_in_group("village"):
		i.next_wave()
	
	if current_day == 1:
		Globals.poti_squellette.talk(["It's daylight. The humans will try to raid your base. Be careful, if they take all your corpses, it's over for you ! You'd better use your spells to defend it."])
	elif current_day == 2:
		Globals.poti_squellette.talk(["It's daylight again, as you can see, you can't move your skeletons as you want, it's because the can only move on a dark area. Press shift to control the skeletons on you night aura."])
	else:
		Globals.poti_squellette.talk([blabla_jour[randi()%blabla_jour.size()]])
