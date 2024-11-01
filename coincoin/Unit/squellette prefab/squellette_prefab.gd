extends CharacterBody2D

@export var speed := 5000
var base_speed := 0
@export var range := 1.0
@export var attack_damage := 5
@export var max_hp := 25
var shield := 0
var current_hp := 25
var init_dmg := 0
var insensible := false

@export var taille := 1

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack: AnimatedSprite2D = $attack

@onready var nav = get_node("NavigationAgent2D")
var target_position = null
@onready var fow_revealer: PointLight2D = $"FOW revealer"

var is_moving := false
var is_a_moving := false
var is_selected := false
var humain_in_range := false
var in_night_arura := false

var disable := false

var looking := "down"

@onready var cadavre = preload("res://Unit/cadavre/cadavre.tscn")


@export var is_range := false


func _ready() -> void:
	$Attack_range/CollisionShape2D.scale = Vector2(range,range)
	$"decal attack"/CollisionShape2D.scale = Vector2(range,range)
	current_hp = max_hp
	animatedSprite.play("idle down")
	fow_revealer.enable = false
	base_speed = speed
	update_stat()


func disabled():
	disable = true
	animatedSprite.play("disable " + looking)
	fow_revealer.light_off()
	hide_marqueur()


func enabled():
	disable = false
	animatedSprite.play("idle " + looking)
	fow_revealer.light_on()

func show_marqueur():
	$marqueur.show()

func hide_marqueur():
	$marqueur.hide()

func _physics_process(delta: float) -> void:
	if is_moving == true or is_a_moving && !humain_in_range:
		if Globals.night or in_night_arura:
			move_along_path(delta)

func update_stat():
	if init_dmg == 0:
		init_dmg = attack_damage
	max_hp *= Globals.squ_hp_mult
	current_hp *= Globals.squ_hp_mult
	attack_damage = init_dmg * Globals.squ_dmg_mult
	speed = base_speed * Globals.squ_sp_mult

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
	elif !disable:
		velocity = movement
		$"check front".look_at(global_position + velocity)
		if $"check front".get_overlapping_bodies() == [] or $"check front".get_overlapping_bodies() == [self]:
			move_and_slide()
	
			if abs(direction.x) <= 0.5:
				if velocity.y < 0:
					animatedSprite.play("move up")
					looking = "up"
				elif velocity.y > 0:
					animatedSprite.play("move down")
					looking = "down"
			else:
				animatedSprite.play("move right")
				if velocity.x < 0:
					animatedSprite.flip_h = true
					attack.flip_h = true
					looking = "right"
				else:
					animatedSprite.flip_h = false
					attack.flip_h = false
					looking = "right"
			
			if velocity == Vector2.ZERO:
				animatedSprite.play("idle " + looking)
		else:
			animatedSprite.play("idle " + looking)


func take_damage(dmg):
	if insensible:return
	if shield > 0:
		shield -= dmg
	else:
		current_hp -= dmg
	if current_hp <= 0:
		var cadavre_instance = cadavre.instantiate()
		cadavre_instance.global_position = global_position
		get_parent().add_child(cadavre_instance)
		Globals.unit_select.erase(self)
		queue_free()


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Humain"):
		if !humain_in_range:
			$"attack cd".start()
			var dir_to_humain = global_position.direction_to($Attack_range.get_overlapping_bodies()[0].global_position)
		
			if abs(dir_to_humain.x) > 0.5:
				if dir_to_humain.x > 0:
					looking = "right"
				else:
					looking = "left"
			else:
				if dir_to_humain.y > 0:
					looking = "down"
				else:
					looking = "up"
		

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Humain"):
		if $Attack_range.get_overlapping_bodies() == [] or $Attack_range.get_overlapping_bodies() == [body]:
			$"attack cd".stop()
			attack.hide()
			animatedSprite.show()

func _on_attack_cd_timeout() -> void:
	if $Attack_range.get_overlapping_bodies() != []:
		attack.show()
		animatedSprite.hide()
		if is_range:
			get_node("projectile").launch($Attack_range.get_overlapping_bodies()[0])
		else:
			$Attack_range.get_overlapping_bodies()[0].take_damage(attack_damage)
		
		var dir_to_humain = global_position.direction_to($Attack_range.get_overlapping_bodies()[0].global_position)
		
		if abs(dir_to_humain.x) > 0.5:
			if dir_to_humain.x > 0:
				looking = "right"
			else:
				looking = "left"
		else:
			if dir_to_humain.y > 0:
				looking = "down"
			else:
				looking = "up"
		
		if disable:
			attack.play("attack d " + looking)
		else:
			attack.play("attack " + looking)


func _on_decal_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("squellette"):
		humain_in_range = true


func _on_decal_attack_body_exited(body: Node2D) -> void:
	if body.is_in_group("squellette"):
		humain_in_range = false
