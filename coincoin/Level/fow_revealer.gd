extends PointLight2D


var enable := true


func light_on():
	for i in $Area2D.get_overlapping_bodies():
		i.reavealed()
	enable = true

func light_off():
	for i in $Area2D.get_overlapping_bodies():
		i.unreavealed()
	enable = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if enable:
		body.reavealed()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if enable:
		body.unreavealed()


func _on_timer_timeout() -> void:
	$Timer.queue_free()
	show()
