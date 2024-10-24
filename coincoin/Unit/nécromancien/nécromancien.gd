extends CharacterBody2D

#variables stats
var speed = 100
var cooldown_multiplier = 1.0
var regen = 1.0
var pv_max = 100
var pv = 100
var nb_ames = 10
var player_direction = "idle_forward"

var insensible := false

var respawn_time := 00

@onready var n_cro_spawn: Node2D = $"../nécro spawn"


func _ready() -> void:
	Globals.player = self
	$necro.play("idle_forward")


func _physics_process(delta):
	if Globals.night or Globals.nécro_mort:
		$necro.play("idle_forward")
		global_position = n_cro_spawn.global_position
		return
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized()
	velocity *= speed
	move_and_slide()
	
	if velocity != Vector2.ZERO :
	
		if velocity.x > 0:
			$necro.flip_h = false
			$necro.play("walk_to_the_right")
			player_direction = "right"
	
		elif velocity.x < 0:
			$necro.flip_h = true
			$necro.play("walk_to_the_right")
			player_direction = "left"
	
		elif velocity.y > 0:
			$necro.play("walk_forward")
			player_direction = "front"
	
		elif velocity.y < 0:
			$necro.play("walk_backward")
			player_direction = "back"
	
	else:
		if player_direction == "front":
			$necro.play("idle_forward")

		elif player_direction == "left":
			$necro.flip_h = true
			$necro.play("idle_right")

		elif player_direction == "right":
			$necro.flip_h = false
			$necro.play("idle_right")

		elif player_direction == "back":
			$necro.play("idle_backward")

func take_damage(dmg):
	if insensible:return
	if !Globals.mana.cost(dmg):
		global_position = n_cro_spawn.global_position
		Globals.nécro_mort = true
		$"mort cd".start()
		$"respawn/0_1".start()
		respawn_time = 100
		$respawn/Label.show()
		set_modulate("ffffff00")


func _on_mort_cd_timeout() -> void:
	Globals.nécro_mort = false
	$"respawn/0_1".stop()
	$respawn/Label.hide()
	set_modulate("ffffff")


func _on__1_timeout() -> void:
	respawn_time -= 1
	$respawn/Label.text = "Respawn in : " + str(int(respawn_time/10)) + "." + str(respawn_time%10)
