extends Node2D


var put := false
var max_hp := 100
var hp := 100
@onready var nav = preload("res://batiment/nav_tourelle.tscn")



func _physics_process(delta: float) -> void:
	if !put:
		if !Globals.night:
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
		else:
			hide()


func take_damage(dmg):
	hp -= dmg
	if hp <= 0:
		for i in $Area2D.get_overlapping_bodies():
			if i.is_in_group("Humain"):
				i.reset_target()
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Humain"):
		body.move_to(global_position)
