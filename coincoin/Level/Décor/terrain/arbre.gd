extends Sprite2D


func _on_delay_timeout() -> void:
	
	if $Area2D.get_overlapping_bodies() != [$StaticBody2D]:
		queue_free()
	else:
		$Area2D.queue_free()
