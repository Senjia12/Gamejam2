extends StaticBody2D


### 0 : up, 1 : right, 2 : down, 3 : left
var current_rotation := 0
var rot = "up"
@onready var rota: Node2D = $rota

@onready var obstacle = {
	"up" : preload("res://batiment/bumper/obstacle up.tscn"),
	"left" : preload("res://batiment/bumper/obstacle left.tscn"),
	"down" : preload("res://batiment/bumper/obstacle down.tscn"),
	"right" : preload("res://batiment/bumper/obstacle right.tscn")
}

var disabled := false

var put := false
var price := 50

func _ready() -> void:
	Globals.can_zoom = false

func _physics_process(delta: float) -> void:
	if !put:
		if !Globals.night:
			global_position = get_global_mouse_position()
			if Input.is_action_just_pressed("click_gauche") && rota.get_node(rot).get_child(0).get_overlapping_bodies() == []:
				put = true
				set_modulate("ffffff")
				rota.queue_free()
				Globals.is_pausing_bat = false
				Globals.can_zoom = true
				var navigation = obstacle[rot].instantiate()
				navigation.global_position = self.global_position
				add_child(navigation)
				$Bump/CollisionShape2D.disabled = false
				get_node(rot).disabled = false
				
			elif Input.is_action_just_pressed("click_droit") or Input.is_action_just_pressed("esc"):
				Globals.bone_counter.add_bones(price)
				Globals.is_pausing_bat = false
				Globals.can_zoom = true
				queue_free()
		else:
			hide()


func _input(event):
	if event is InputEventMouseButton && !put:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				current_rotation += 1
				if current_rotation >= 4:
					current_rotation = 0
				update_rotation()
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
				current_rotation -= 1
				if current_rotation < 0:
					current_rotation = 3
				update_rotation()

func update_rotation():
	if current_rotation == 0:
		rot = "up"
	elif current_rotation == 1:
		rot = "right"
	elif current_rotation == 2:
		rot = "down"
	elif current_rotation == 3:
		rot = "left"
	
	for i in rota.get_children():
		i.hide()
		i.get_child(0).get_child(0).disabled = true
	rota.get_node(rot).show()
	rota.get_node(rot).get_child(0).get_child(0).disabled = false
	$AnimatedSprite2D.play(rot)
	$Bump.rotation_degrees = 90 * current_rotation


func _on_bump_body_entered(body: Node2D) -> void:
	if !disabled:
		disabled = true
		for i in $Bump.get_overlapping_bodies():
			if i.is_in_group("Humain"):
				i.bump(rot)
		$AnimatedSprite2D.play("u " + rot)
		$rebond.start()

func _on_rebond_timeout() -> void:
	$AnimatedSprite2D.play(rot)


func _on_put_body_entered(body: Node2D) -> void:
	set_modulate("ff597162")


func _on_put_body_exited(body: Node2D) -> void:
	if rota.get_node(rot).get_child(0).get_overlapping_bodies() == []:
		set_modulate("00add162")
