extends Control




func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if get_node_or_null("show button") != null:
			$"show button".play("show")


func _on_quit_pressed() -> void:
	$ui.play()
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/main.tscn")
	
	$ui.play()

func _on_show_button_animation_finished(anim_name: StringName) -> void:
	$"show button".queue_free()
