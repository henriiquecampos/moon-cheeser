extends KinematicBody2D

const MAX_SPEED = 300

var direction = 1
var is_mouse_on = false setget _set_mouse_on
var already_pressed = false

onready var fixed_process = set_fixed_process(true)
onready var velocity = Vector2()

func apply_route():
	if Input.is_mouse_button_pressed(1) and not already_pressed and is_mouse_on:
		var n = clamp((get_global_pos() - get_global_mouse_pos()).y, -1, 1)
		velocity = Vector2(MAX_SPEED * direction, n * MAX_SPEED * 2)
		already_pressed = true
	return(velocity)

func _ready():
	velocity = Vector2(direction,0) * MAX_SPEED

func _fixed_process(delta):
	move(apply_route() * delta)

func _set_mouse_on(is_on):
	is_mouse_on = is_on
	
func _exit_screen():
	queue_free()