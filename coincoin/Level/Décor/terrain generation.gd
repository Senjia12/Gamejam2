extends TileMapLayer

@onready var montagne = [preload("res://Level/Décor/montagne/montagne 1.tscn"),preload("res://Level/Décor/montagne/montagne 2.tscn"),preload("res://Level/Décor/montagne/montagne 3.tscn"),preload("res://Level/Décor/montagne/montagne 4.tscn"),preload("res://Level/Décor/montagne/montagne 5.tscn"),preload("res://Level/Décor/montagne/montagne 6.tscn")]


func _ready() -> void:
	for i in 100:
		var new_spawn_pos := Vector2.ZERO
		while new_spawn_pos.distance_to(Vector2.ZERO) < 800:
			new_spawn_pos = Vector2(randi()%9000-4500,randi()%9000-4500)
		var montagne_instance = montagne[randi()%montagne.size()].instantiate()
		montagne_instance.global_position = new_spawn_pos
		$NavigationRegion2D.add_child(montagne_instance)
	
	$NavigationRegion2D.bake_navigation_polygon()
	$NavigationRegion2D.show()
