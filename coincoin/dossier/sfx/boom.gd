extends AudioStreamPlayer


func _ready() -> void:
	play()




func _on_finished() -> void:
	queue_free()