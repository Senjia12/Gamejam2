extends Node2D

var selection_start = Vector2()
var selection_end = Vector2()
var selecting = false

const sel_box_col = Color(96.0/255.0, 56.0/255.0, 106.0/255.0)
const sel_box_line_width = 3

var unit_select := []

func _input(event):
	if !Globals.night: return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				selection_start = get_local_mouse_position()
				selecting = true
			else:
				selection_end = get_local_mouse_position()
				selecting = false
				if selection_end.distance_to(selection_start):
					selection_end += selection_end.normalized() * 12
					selection_start += selection_start.normalized() * 12
				select_units()
				queue_redraw()
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
		draw_rect(Rect2(selection_start,selection_end - selection_start),Color(sel_box_col,0.1))


func select_units():
	var rect = Rect2(selection_start, selection_end - selection_start).abs()
	for unit in get_tree().get_nodes_in_group("Unit"):
		if rect.has_point(unit.global_position):
			unit.select()
			unit_select.append(unit)
		else:
			unit.deselect()
			unit_select.erase(unit)
