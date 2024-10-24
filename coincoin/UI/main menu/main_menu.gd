extends Control




func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		$"show button".play("show")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/main.tscn")
