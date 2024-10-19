extends CharacterBody2D

@export var speed := 5000
@export var range := 1.0
@export var attack_damage := 5
@export var max_hp := 25
var current_hp := 25


@onready var nav = get_node("NavigationAgent2D")
var target_position = null

var is_moving := false
var is_a_moving := false
var is_selected := false

var humain_in_range := false

@onready var cadavre = preload("res://Unit/cadavre/cadavre.tscn")


func _ready() -> void:
	$Attack_range/CollisionShape2D.scale = Vector2(range,range)
	current_hp = max_hp


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


func take_damage(dmg):
	current_hp -= dmg
	if current_hp <= 0:
		var cadavre_instance = cadavre.instantiate()
		cadavre_instance.global_position = global_position
		get_parent().add_child(cadavre_instance)
		queue_free()


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Humain"):
		if !humain_in_range:
			humain_in_range = true
			$"attack cd".start()

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Humain"):
		if $Attack_range.get_overlapping_bodies() == []:
			humain_in_range = false
			$"attack cd".stop()

func _on_attack_cd_timeout() -> void:
	$Attack_range.get_overlapping_bodies()[0].take_damage(attack_damage)
