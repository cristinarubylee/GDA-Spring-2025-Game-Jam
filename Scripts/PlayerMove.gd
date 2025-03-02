extends CharacterBody2D

enum States {EGG, CATERPILLAR, BUTTERFLY}

var state: States = States.CATERPILLAR

var rotation_speed = 0

var jump_buffer = 0.0

var is_left_slope = 0.0
var is_right_slope = 0.0


const EGG_SPEED = 300.0
const EGG_JUMP_VELOCITY = -100.0

const CATERPILLAR_SPEED = 300.0
const CATERPILLAR_JUMP_VELOCITY = -600.0

const BUTTERFLY_SPEED = 300.0
const BUTTERFLY_JUMP_VELOCITY = -1200.0


func _physics_process(delta: float) -> void:
	
	var current_speed = 150.0
	var current_jump = -50.0
	
	#Sets speed and jump depending on state
	if (state == States.EGG):
		current_speed = EGG_SPEED
		current_jump = EGG_JUMP_VELOCITY
	elif (state == States.CATERPILLAR):
		current_speed = CATERPILLAR_SPEED
		current_jump = CATERPILLAR_JUMP_VELOCITY
	elif (state == States.BUTTERFLY):
		current_speed = BUTTERFLY_SPEED
		current_jump = BUTTERFLY_JUMP_VELOCITY
	
	# Gravity
	if not is_on_floor():
		if (state == States.BUTTERFLY):
			velocity += get_gravity() * delta / 2
		else:
			velocity += get_gravity() * delta
			
		rotation_speed += sin(rotation) * delta

	#JUMP BUFFER
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor():
		jump_buffer = 0.1
		
	jump_buffer -= delta
	if (jump_buffer > 0) and is_on_floor():
		velocity.y = current_jump
		

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = current_jump

	# Input direction
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * current_speed * delta
		if (velocity.x > 3000):
			velocity.x = 3000
		if (velocity.x < -3000):
			velocity.x = -3000
			
		rotation_speed += velocity.x * delta * 0.01
	else:
		rotation_speed += velocity.x * delta * 0.01
		#velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.x *= 0.98
		
	rotation = rotation_speed
	
	if is_left_slope > 0:
		velocity.x += current_speed * 2 * delta
		#velocity.y = 900
		
	if is_right_slope > 0:
		velocity.x -= current_speed * 2 * delta
		#velocity.y = 900
	
	apply_floor_snap()

	move_and_slide()

func on_left_slope():
	is_left_slope = 0.1
	print("ls call")

func off_left_slope():
	is_left_slope = 0.0
	print("ls call")
	
func on_right_slope():
	is_right_slope = 0.1
	print("rs call")

func off_right_slope():
	is_right_slope = 0.0
	print("rs call")
	
func ramp():
	velocity.y = abs(velocity.x) * -0.5
	print("ramp call")
