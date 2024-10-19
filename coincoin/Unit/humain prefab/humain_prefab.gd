extends CharacterBody2D

@export var speed := 5000
@export var range := 1.0
@export var attack_damage := 5
@export var max_hp := 25
var current_hp := 25

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var nav = get_node("NavigationAgent2D")
var target_position = null

var is_moving := false
var is_a_moving := false
var is_selected := false
var squellette_in_range := false

var direction := "down"

@onready var cadavre = preload("res://Unit/cadavre/cadavre.tscn")

func _ready() -> void:
	$Attack_range/CollisionShape2D.scale = Vector2(range,range)
	current_hp = max_hp
	animatedSprite.play("idle down")
	is_a_moving = true
	move_to(Vector2.ZERO)


func _physics_process(delta: float) -> void:
	if is_moving == true or is_a_moving && !squellette_in_range:
		move_along_path(delta)
	else:
		animatedSprite.play("idle " + direction)

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
		$"check front".look_at(global_position + velocity)
		if $"check front".get_overlapping_bodies() == [] or $"check front".get_overlapping_bodies() == [self]:
			move_and_slide()
	
	if abs(velocity.x) <= 0.2:
		if velocity.y < 0:
			animatedSprite.play("move up")
			direction = "up"
		else:
			animatedSprite.play("move down")
			direction = "down"
	else:
		animatedSprite.play("move right")
		if velocity.x < 0:
			animatedSprite.flip_h = true
			direction = "left"
		else:
			animatedSprite.flip_h = false
			direction = "right"


func take_damage(dmg):
	current_hp -= dmg
	if current_hp <= 0:
		var cadavre_instance = cadavre.instantiate()
		cadavre_instance.global_position = global_position
		get_parent().add_child(cadavre_instance)
		queue_free()


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("squellette") && !is_moving:
		if !squellette_in_range:
			squellette_in_range = true
			$"attack cd".start()

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("squellette"):
		if $Attack_range.get_overlapping_bodies() == [] or $Attack_range.get_overlapping_bodies() == [body]:
			squellette_in_range = false
			$"attack cd".stop()

func _on_attack_cd_timeout() -> void:
	if $Attack_range.get_overlapping_bodies() != []:
		$Attack_range.get_overlapping_bodies()[0].take_damage(attack_damage)
