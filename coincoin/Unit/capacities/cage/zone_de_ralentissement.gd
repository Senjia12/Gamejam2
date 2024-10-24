extends AnimatedSprite2D


var tier := 3
var next_is_couik := false

func _ready() -> void:
	play("default")
	for i in $Area2D.get_overlapping_bodies():
		i.speed_mult = 0.5
	if tier == 3:
		$delay.queue_free()
		if Globals.zone_gel != null:
			Globals.zone_gel.destroy()
		Globals.zone_gel = self


func destroy():
	next_is_couik = true
	play_backwards("default")


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.speed_mult = 0.5

func _on_area_2d_body_exited(body: Node2D) -> void:
	body.speed_mult = 1

func _on_delay_timeout() -> void:
	for i in $Area2D.get_overlapping_bodies():
		i.speed_mult = 1
	destroy()


func _on_animation_finished() -> void:
	if next_is_couik:
		queue_free()
