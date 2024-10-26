extends TextureRect



func _physics_process(delta: float) -> void:
	if !is_visible_in_tree():
		$Label.text = str(Globals.score)


func _on_restart_pressed() -> void:
	Globals.squ_dmg_mult = 1.0
	Globals.squ_hp_mult = 1.0
	Globals.squ_sp_mult = 1.0
	Globals.zone_gel = null
	Globals.nécro_mort = false
	Globals.village = 0
	get_tree().reload_current_scene()
	$"../../ui".play()

func _on_main_menu_pressed() -> void:
	Globals.squ_dmg_mult = 1.0
	Globals.squ_hp_mult = 1.0
	Globals.squ_sp_mult = 1.0
	Globals.zone_gel = null
	Globals.nécro_mort = false
	Globals.village = 0
	get_tree().change_scene_to_file("res://UI/main menu/main_menu.tscn")
	$"../../ui".play()
