extends TileMapLayer

@onready var montagne = [preload("res://Level/Décor/montagne/montagne 1.tscn"),preload("res://Level/Décor/montagne/montagne 2.tscn"),preload("res://Level/Décor/montagne/montagne 3.tscn"),preload("res://Level/Décor/montagne/montagne 4.tscn"),preload("res://Level/Décor/montagne/montagne 5.tscn"),preload("res://Level/Décor/montagne/montagne 6.tscn")]
@onready var arbre = preload("res://Level/Décor/terrain/arbre.tscn")
@onready var décor = [
	preload("res://Level/Décor/décor herbeux/décor_1.tscn"),
	preload("res://Level/Décor/décor herbeux/décor_2.tscn"),
	preload("res://Level/Décor/décor herbeux/décor_4.tscn"),
	preload("res://Level/Décor/décor herbeux/décor_5.tscn"),
	preload("res://Level/Décor/décor herbeux/décor_6.tscn"),
	preload("res://Level/Décor/décor herbeux/décor_7.tscn"),
	preload("res://Level/Décor/décor herbeux/décor_8.tscn"),
	preload("res://Level/Décor/décor herbeux/décor_9.tscn"),
	preload("res://Level/Décor/décor herbeux/décor_10.tscn")
]


@onready var ysort: Node2D = $"../ysort"

func _ready() -> void:
	for i in 100:
		var new_spawn_pos := Vector2.ZERO
		while new_spawn_pos.distance_to(Vector2.ZERO) < 800:
			new_spawn_pos = Vector2(randi()%9000-4500,randi()%9000-4500)
		var montagne_instance = montagne[randi()%montagne.size()].instantiate()
		montagne_instance.global_position = new_spawn_pos
		$NavigationRegion2D.add_child(montagne_instance)
	
	for i in 500:
		var arbre_instance = arbre.instantiate()
		var new_spawn_pos := Vector2.ZERO
		while new_spawn_pos.distance_to(Vector2.ZERO) < 800:
			new_spawn_pos = Vector2(randi()%9000-4500,randi()%9000-4500)
		arbre_instance.global_position = new_spawn_pos
		$NavigationRegion2D.add_child(arbre_instance)
	
	for i in 2500:
		var new_spawn_pos := Vector2.ZERO
		while new_spawn_pos.distance_to(Vector2.ZERO) < 300:
			new_spawn_pos = Vector2(randi()%9000-4500,randi()%9000-4500)
		var buisosn_instance = décor[randi()%décor.size()].instantiate()
		buisosn_instance.global_position = new_spawn_pos
		$NavigationRegion2D.add_child(buisosn_instance)
	
	
	$NavigationRegion2D.show()


func _on_delay_timeout() -> void:
	$NavigationRegion2D.bake_navigation_polygon()
