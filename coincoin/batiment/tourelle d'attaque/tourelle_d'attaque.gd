extends StaticBody2D

var put := false
var max_hp := 75
var hp := 75
@onready var nav = preload("res://batiment/nav_tourelle.tscn")
const ARROW = preload("res://Unit/arrow/arrow.tscn")

var humain_in := false
var direction := "down"

var price := 50


func _ready() -> void:
	$"squellette pipou".play("i down")


func _physics_process(delta: float) -> void:
	if !put:
		if Globals.night:
			global_position = get_global_mouse_position()
			if Input.is_action_just_pressed("click_gauche") && $MeshInstance2D/Area2D.get_overlapping_bodies() == []:
				put = true
				set_modulate("ffffff")
				$MeshInstance2D.queue_free()
				$Area2D/CollisionShape2D.disabled = false
				$CollisionShape2D.disabled = false
				var nav_instance = nav.instantiate()
				nav_instance.global_position = global_position
				add_child(nav_instance)
				Globals.is_pausing_bat = false
			elif Input.is_action_just_pressed("click_droit") or Input.is_action_just_pressed("esc"):
				Globals.bone_counter.add_bones(price)
				Globals.is_pausing_bat = false
				queue_free()
		else:
			hide()


func take_damage(dmg):
	hp -= dmg
	if hp <= 0:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !humain_in:
		humain_in = true
		$CD.start()
		var dir_to_humain = $"squellette pipou".global_position.direction_to($Area2D.get_overlapping_bodies()[0].global_position)
		
		if abs(dir_to_humain.x) > 0.5:
			if dir_to_humain.x > 0:
				direction = "right"
			else:
				direction = "left"
		else:
			if dir_to_humain.y > 0:
				direction = "down"
			else:
				direction = "up"
		
		$"squellette pipou".play(direction)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if $Area2D.get_overlapping_bodies() == []:
		humain_in = false
		$CD.stop()
		$"squellette pipou".play("i " + direction)


func _on_cd_timeout() -> void:
	if $Area2D.get_overlapping_bodies() != []:
		var arrow_instance = ARROW.instantiate()
		arrow_instance.target = $Area2D.get_overlapping_bodies()[0]
		arrow_instance.global_position = $"squellette pipou".global_position
		get_parent().add_child(arrow_instance)
		var dir_to_humain = $"squellette pipou".global_position.direction_to($Area2D.get_overlapping_bodies()[0].global_position)
		if abs(dir_to_humain.x) > 0.5:
			if dir_to_humain.x > 0:
				direction = "right"
			else:
				direction = "left"
		else:
			if dir_to_humain.y > 0:
				direction = "down"
			else:
				direction = "up"
		$"squellette pipou".play(direction)
	else:
		humain_in = false
		$CD.stop()
		$"squellette pipou".play("i " + direction)


func _on_put_body_entered(body: Node2D) -> void:
	set_modulate("ff597162")


func _on_put_body_exited(body: Node2D) -> void:
	if $MeshInstance2D/Area2D.get_overlapping_bodies() == []:
		set_modulate("00add162")
