extends CharacterBody2D

@export var speed := 10000
@export var range := 1.0

@onready var nav = get_node("NavigationAgent2D")
var target_position = null

var is_moving := false
var is_a_moving := false
var is_selected := false

var humain_in_range := false

func _physics_process(delta: float) -> void:
	if is_moving == true or is_a_moving && !humain_in_range:
		move_along_path(delta)

func move_to(pos):
	var navigation = get_node("NavigationAgent2D")
	navigation.set_target_position(pos)

func move_along_path(delta):
	var next_point = nav.get_next_path_position()
	var direction = (next_point - global_position).normalized()
	var movement = direction * speed * delta
	var distance = global_position.distance_to(next_point)
	
	if movement.length()/100 > distance:
		global_position = next_point
	else:
		velocity = movement
		move_and_slide()


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Humain"):
		humain_in_range = true
