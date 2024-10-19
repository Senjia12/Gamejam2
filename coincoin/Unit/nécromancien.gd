extends CharacterBody2D

#variables stats
var speed = 100
var cooldown_multiplayer = 1.0
var regen = 1.0
var pv_max = 100
var pv = 100
var nb_ames = 10


func _ready() -> void:
	Globals.player = self


func _physics_process(delta):
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized()
	velocity *= speed
	move_and_slide()
