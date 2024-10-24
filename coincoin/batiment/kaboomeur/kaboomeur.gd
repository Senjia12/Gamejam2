extends Node2D

var put := false

var price := 15
const éteint = preload("res://batiment/kaboomeur/image.png")
const allumé = preload("res://batiment/kaboomeur/image (1).png")
@onready var sprite: Sprite2D = $Sprite2D
const EXPLOSION = preload("res://UI/shader/explosion.tscn")

var light = true

func _physics_process(delta: float) -> void:
	if !put:
		if Globals.night:
			global_position = get_global_mouse_position()
			if Input.is_action_just_pressed("click_gauche") && $MeshInstance2D/Area2D.get_overlapping_bodies() == []:
				put = true
				set_modulate("ffffff")
				$MeshInstance2D.queue_free()
				$Area2D/CollisionShape2D.disabled = false
				Globals.is_pausing_bat = false
			elif Input.is_action_just_pressed("click_droit") or Input.is_action_just_pressed("esc"):
				Globals.bone_counter.add_bones(price)
				Globals.is_pausing_bat = false
				queue_free()
		else:
			hide()


func _on_put_body_entered(body: Node2D) -> void:
	set_modulate("ff597162")


func _on_put_body_exited(body: Node2D) -> void:
	if $MeshInstance2D/Area2D.get_overlapping_bodies() == []:
		set_modulate("00add162")


func _on_area_2d_body_entered(body: Node2D) -> void:
	$"explosion delay".start()
	$tick.start()
	sprite.texture = allumé

func _on_tick_timeout() -> void:
	if light:
		light = false
		sprite.texture = éteint
	else:
		light = true
		sprite.texture = allumé
	
	if $tick.wait_time > 0.05:
		$tick.wait_time /= 1.2
		


func _on_explosion_delay_timeout() -> void:
	for i in $Area2D.get_overlapping_bodies():
		i.take_damage(25)
	var explosion = EXPLOSION.instantiate()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()
