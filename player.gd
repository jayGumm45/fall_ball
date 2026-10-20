extends CharacterBody2D

@export var rotation_acceleration: float = 30.0
var rotation_speed: float = 0.0
var maximum_rotation_speed: float = 500.0
var screen_size
var gravity_constant = 0.2
var gravity_speed = 0.0
var jumping_initial_velocity = 2.0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			rotation_speed -= rotation_acceleration
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			rotation_speed += rotation_acceleration
			
		rotation_speed = clampf(rotation_speed, 
		-maximum_rotation_speed, 
		maximum_rotation_speed)
			
func _process(delta):
	rotation_degrees += (rotation_speed * delta)
	position.x += (rotation_speed / 100)
	
	screen_size = get_viewport_rect().size
	
	position.x = clamp(position.x, 64, screen_size.x - 64)
	position.y = clamp(position.y, 64, screen_size.y - 64)
	
	if position.x == 64 or position.x == screen_size.x - 64:
		rotation_speed = 0
	
func _physics_process(delta):
	screen_size = get_viewport_rect().size
	
	if Input.is_action_just_pressed("Jump") and position.y == screen_size.y - 64:
		gravity_speed = -9
	
	gravity_speed += gravity_constant
	position.y += gravity_speed
	
	if position.y == screen_size.y - 64:
		gravity_speed = 0
