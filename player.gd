extends CharacterBody2D

@export var rotation_acceleration: float = 30.0
@export var maximum_rotation_speed: float = 500.0
@export var gravity: float = 1200.0
@export var jumping_velocity: float = -300.0
@export var move_scale: float = 60.0

var rotation_speed: float = 0.0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			rotation_speed -= rotation_acceleration
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			rotation_speed += rotation_acceleration
			
		rotation_speed = clampf(rotation_speed, 
		-maximum_rotation_speed, 
		maximum_rotation_speed)
			

	
func _physics_process(delta):
	#Visual spin
	rotation_degrees += rotation_speed * delta
	
	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		
	#jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jumping_velocity
	
	velocity.x = rotation_speed / 100.0 * move_scale
	
	move_and_slide()
	
	if is_on_wall():
		rotation_speed = 0.0
