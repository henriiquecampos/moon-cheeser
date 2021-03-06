extends Area2D

signal dragging()
signal dragged(direction)

const MOUSE_HOLD = preload("res://interface/hand_hold.png")
const MOUSE_POINT = preload("res://interface/hand_point.png")
var direction = Vector2()
var is_dragging = false

func _ready():
	set_process_unhandled_input(false)

func _unhandled_input(event):
	if not event.is_action("click"):
		return
		
	
	if  not event.is_pressed():
		direction = (get_global_mouse_position() - global_position).normalized()
		emit_signal("dragged", direction)
		set_process_unhandled_input(false)
		Globals.dragging = false

func _on_mouse_exited():
	Input.set_custom_mouse_cursor(MOUSE_POINT, Input.CURSOR_ARROW)

func _on_mouse_entered():
	Input.set_custom_mouse_cursor(MOUSE_HOLD, Input.CURSOR_ARROW)

func _on_input_event(viewport, event, shape_idx):
	if Globals.dragging:
		return
	if viewport.is_input_handled():
		return
	
	if not event.is_action("click"):
		return
	
	if event.is_pressed():
		is_dragging = true
		Globals.dragging = true
		set_process_unhandled_input(true)
		emit_signal("dragging")
	else:
		emit_signal("dragged", direction)
