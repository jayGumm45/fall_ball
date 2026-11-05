extends CharacterBody2D

@onready var land_sound: AudioStreamPlayer2D = $LandSound

@export var rotation_acceleration: float = 150.0
@export var maximum_rotation_speed: float = 300.0
@export var gravity: float = 1200.0
@export var jumping_velocity: float = -300.0
@export var move_scale: float = 60.0
@export var rotation_friction: float = 50.

var starting_position: Vector2

var rotation_speed: float = 0.0

var was_on_floor := false


func _ready() -> void:
	starting_position = global_position


func _physics_process(delta):
	#Visual spin
	rotation_degrees += rotation_speed * delta
	
	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	#jump
	#var total = 0
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jumping_velocity
	#Rotate left
	if Input.is_action_pressed("Move_left"):
		rotation_speed -= rotation_acceleration * delta
	#Rotate right
	if Input.is_action_pressed("Move_right"):
		rotation_speed += rotation_acceleration * delta
	#Gradually reduces speed to zero when input keys are not pressed
	if not Input.is_action_pressed("Move_left") and not Input.is_action_pressed("Move_right"):
		rotation_speed = move_toward(rotation_speed, 0.0, rotation_friction * delta)
	#Limits rotation speed
	rotation_speed = clampf(rotation_speed, 
	-maximum_rotation_speed, 
	maximum_rotation_speed)
	
	velocity.x = rotation_speed / 100.0 * move_scale
	
	move_and_slide()
	
	if global_position.y > 1000:
		global_position = starting_position
		rotation_speed = 0.0
		velocity = Vector2.ZERO
		rotation = 0.0
		
	if is_on_floor() and not was_on_floor:
		land_sound.play()
	
	was_on_floor = is_on_floor()
	
	_check_locked_tiles()
	
	if is_on_wall():
		rotation_speed = 0.0

func _check_locked_tiles() -> void:
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var tilemap := collision.get_collider() as TileMapLayer
		if tilemap == null:
			continue
		var hit_pos := collision.get_position() - collision.get_normal() * 1.0
		var cell := tilemap.local_to_map(tilemap.to_local(hit_pos))
		var data := tilemap.get_cell_tile_data(cell)
		if data and data.get_custom_data("locked") and GameState.has_key:
			tilemap.erase_cell(cell)
			GameState.use_key()
