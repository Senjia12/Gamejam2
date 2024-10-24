extends AnimatedSprite2D


var tier := 2

func _ready() -> void:
	play("default")
	for i in $Area2D.get_overlapping_bodies():
		i.speed_mult = 0.5
	if tier == 3:
		$delay.queue_free()
		if Globals.zone_gel != null:
			Globals.zone_gel.queue_free()
		Globals.zone_gel = self


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.speed_mult = 0.5

func _on_area_2d_body_exited(body: Node2D) -> void:
	body.speed_mult = 1

func _on_delay_timeout() -> void:
	for i in $Area2D.get_overlapping_bodies():
		i.speed_mult = 1
