extends Node2D

var selection_start = Vector2()
var selection_end = Vector2()
var selecting = false

const sel_box_col = Color(96.0/255.0, 56.0/255.0, 106.0/255.0)
const sel_box_line_width = 3

const CURSEUR_BASE = preload("res://UI/curseur base.png")
const EPEE = preload("res://UI/épée.png")
const BOTTE = preload("res://UI/botte.png")
const MARQUEUR = preload("res://UI/Marqueur/marqueur.tscn")

var a_pressed := false
var last_pressed

func _physics_process(delta: float) -> void:
	if !Globals.night: return
	if Input.is_action_just_pressed("click_droit") && Globals.unit_select != []:
		for i in Globals.unit_select:
			i.is_a_moving = false
			i.is_moving = true
			i.move_to(get_global_mouse_position())
		var marqueur_instance = MARQUEUR.instantiate()
		marqueur_instance.position = get_global_mouse_position()
		add_child(marqueur_instance)
	if Input.is_action_just_pressed("attack") && !selecting && Globals.unit_select != []:
		a_pressed = true
		Input.set_custom_mouse_cursor(EPEE)
	if Input.is_action_just_released("click_gauche") && a_pressed && Globals.unit_select != []:
		Input.set_custom_mouse_cursor(BOTTE,0,Vector2(16,16))
		a_pressed = false
		var marqueur_instance = MARQUEUR.instantiate()
		marqueur_instance.position = get_global_mouse_position()
		marqueur_instance.type = "attack"
		add_child(marqueur_instance)
		for i in Globals.unit_select:
			i.is_a_moving = true
			i.is_moving = false
			i.move_to(get_global_mouse_position())


func _input(event):
	if !Globals.night: return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && !a_pressed:
			if event.pressed:
				selection_start = get_local_mouse_position()
				selecting = true
			else:
				selection_end = get_local_mouse_position()
				selecting = false
				if selection_end.distance_to(selection_start) < 16:
					selection_end += Vector2(1,1)*8
					selection_start += Vector2(-1,-1)*8
				select_units()
				queue_redraw()
		elif event.button_index != MOUSE_BUTTON_LEFT:
			Input.set_custom_mouse_cursor(CURSEUR_BASE)
			if Globals.unit_select != []:
				Input.set_custom_mouse_cursor(BOTTE,0,Vector2(16,16))
			a_pressed = false
	elif event is InputEventMouseMotion:
		if selecting:
			selection_end = get_local_mouse_position()
			queue_redraw()


func _draw():
	if selecting:
		draw_line(selection_start, Vector2(selection_end.x, selection_start.y), sel_box_col, sel_box_line_width)
		draw_line(selection_start, Vector2(selection_start.x, selection_end.y), sel_box_col, sel_box_line_width)
		draw_line(selection_end, Vector2(selection_end.x, selection_start.y), sel_box_col, sel_box_line_width)
		draw_line(selection_end, Vector2(selection_start.x, selection_end.y), sel_box_col, sel_box_line_width)
		draw_rect(Rect2(selection_start,selection_end - selection_start),Color(sel_box_col,0.25))


func select_units():
	var rect = Rect2(selection_start, selection_end - selection_start).abs()
	for unit in get_tree().get_nodes_in_group("Unit"):
		if rect.has_point(unit.global_position):
			unit.is_selected = true
			Globals.unit_select.append(unit)
		else:
			unit.is_selected = false
			Globals.unit_select.erase(unit)
	if Globals.unit_select != []:
		Input.set_custom_mouse_cursor(BOTTE,0,Vector2(16,16))
	else:
		Input.set_custom_mouse_cursor(CURSEUR_BASE)
