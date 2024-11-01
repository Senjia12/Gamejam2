extends CharacterBody2D

@export var speed := 5000
var real_speed := 5000
@export var range := 1.0
@export var attack_damage := 5
@export var max_hp := 25
@export var exp := 5
var current_hp := 25

var is_raided = false

@export var mage := false

var speed_mult := 1.0

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack: AnimatedSprite2D = $attack

@onready var nav = get_node("NavigationAgent2D")
var target_position = null

var humain_in_range := false

var looking := "down"
var timer_start := false
@onready var cadavre = preload("res://Unit/cadavre/cadavre.tscn")

var bump_velocity := Vector2.ZERO
var village
var reavealer := 0

func reset_target():
	move_to(Vector2.ZERO + Vector2.ZERO.direction_to(global_position) * 32)


func _ready() -> void:
	unreavealed()
	$Attack_range/CollisionShape2D.scale = Vector2(range,range)
	$"ennemi near"/CollisionShape2D.scale = Vector2(range,range)
	current_hp = max_hp
	animatedSprite.play("idle down")
	move_to(Vector2.ZERO + Vector2.ZERO.direction_to(global_position) * 32)

func _physics_process(delta: float) -> void:
	if !humain_in_range:
		move_along_path(delta)

func bump(dir):
	if dir == "up":
		bump_velocity = Vector2.UP
	elif dir == "right":
		bump_velocity = Vector2.RIGHT
	elif dir == "down":
		bump_velocity = Vector2.DOWN
	elif dir == "left":
		bump_velocity = Vector2.LEFT
	$"delay rebond".start()

func move_to(pos):
	var navigation = get_node("NavigationAgent2D")
	navigation.set_target_position(pos)

func move_along_path(delta):
	var next_point = nav.get_next_path_position()
	var direction = (next_point - global_position).normalized()
	var movement = direction * real_speed * delta * speed_mult
	var distance = global_position.distance_to(next_point)
	
	if movement.length()/100 > distance:
		global_position = next_point
	else:
		velocity = movement
		$"check front".look_at(global_position + velocity)
		if $"check front".get_overlapping_bodies() == [] or $"check front".get_overlapping_bodies() == [self]:
			velocity += bump_velocity * 1000
			move_and_slide()
	
			if abs(direction.x) <= 0.5:
				if velocity.y < 0:
					animatedSprite.play("move up")
					looking = "up"
				elif velocity.y > 0:
					animatedSprite.play("move down")
					looking = "down"
			else:
				if velocity.x < 0:
					looking = "left"
					animatedSprite.play("move left")
				
				else:
					looking = "right"
					animatedSprite.play("move right")
			
			if velocity == Vector2.ZERO && $Attack_range.get_overlapping_bodies() == []:
				animatedSprite.play("idle " + looking)
		elif $Attack_range.get_overlapping_bodies() == []:
			animatedSprite.play("idle " + looking)

func take_damage(dmg):
	current_hp -= dmg
	if current_hp <= 0:
		var cadavre_instance = cadavre.instantiate()
		cadavre_instance.global_position = global_position
		get_parent().add_child(cadavre_instance)
		Globals.exp.add_exp(exp)
		Globals.score += exp * 20
		village.couik(self)
		queue_free()

func reavealed():
	reavealer += 1
	show()
	real_speed = speed
	if Globals.first:
		Globals.first = false
		Globals.poti_squellette.talk(["Look ! Humans are coming ! Use your offensive spell on them !"])


func unreavealed():
	reavealer -= 1
	if reavealer <= 0:
		#hide()
		reavealer = 0
		#real_speed = speed * 2


func run():
	if !is_raided:
		$"tp haut".play("default")
		$"tp bas".play("default")
		$Timer.start()


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("squellette"):
		if !timer_start:
			timer_start = true
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
	if body.is_in_group("squellette"):
		if $Attack_range.get_overlapping_bodies() == [] or $Attack_range.get_overlapping_bodies() == [body]:
			timer_start = false
			$"attack cd".stop()
			attack.hide()
			animatedSprite.show()


func _on_attack_cd_timeout() -> void:
	if $Attack_range.get_overlapping_bodies() != []:
		$hit.play()
		if $Attack_range.get_overlapping_bodies()[0].is_in_group("fosse a squellette"):
			Globals.bone_counter.take_damage(attack_damage)
			attack.show()
			animatedSprite.hide()
		elif !mage:
			attack.show()
			animatedSprite.hide()
			$Attack_range.get_overlapping_bodies()[0].take_damage(attack_damage)
		else:
			attack.show()
			animatedSprite.hide()
			get_node("projectile").launch()
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
		
		
		attack.play("attack " + looking)


func _on_ennemi_near_body_entered(body: Node2D) -> void:
	if body.is_in_group("squellette"):
		humain_in_range = true


func _on_ennemi_near_body_exited(body: Node2D) -> void:
	if body.is_in_group("squellette"):
		humain_in_range = false


func _on_tp_haut_animation_changed() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	hide()


func _on_delay_rebond_timeout() -> void:
	bump_velocity = Vector2.ZERO
