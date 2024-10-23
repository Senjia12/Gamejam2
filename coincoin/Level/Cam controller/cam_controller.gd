extends Camera2D


var screen_size := Vector2.ZERO
@export var speed := 450

func _ready():
	Input.set_mouse_mode(3)
	screen_size = DisplayServer.window_get_size(0)


func _physics_process(delta: float) -> void:
	if Globals.night:
		var move_dir := Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
		if move_dir == Vector2.ZERO:
			if get_local_mouse_position().x >= screen_size.x / zoom.x / 2 -20 / zoom.x:
				move_dir.x = 1
			elif get_local_mouse_position().x <= -screen_size.x / zoom.x / 2 +20 / zoom.x:
				move_dir.x = -1
			if get_local_mouse_position().y >= screen_size.y / zoom.x / 2 -20 / zoom.x:
				move_dir.y += 1
			elif get_local_mouse_position().y <= -screen_size.y / zoom.x / 2 +20 / zoom.x:
				move_dir.y += -1
		global_position += move_dir * speed * delta / zoom.x
	else:
		global_position = Globals.player.global_position


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && Globals.can_zoom:
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if get_zoom() >= Vector2(0.5,0.5):
					set_zoom(zoom / 1.2)
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if get_zoom() <= Vector2(6,6):
					set_zoom(zoom * 1.2)
