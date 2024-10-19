extends CharacterBody2D


func _ready() -> void:
	Globals.player = self
	
#variables stats
@onready var shadow_area: Area2D = $Nécromancien
var speed = 100
var cooldown_multiplayer = 1.0
var regen = 1.0
var pv_max = 100
var pv = 100
var nb_ames = 10

func _physics_process(delta):
	var idle_player = $"idle player"
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("bottom") - Input.get_action_strength("top")
	velocity = velocity.normalized()
	velocity *= speed
