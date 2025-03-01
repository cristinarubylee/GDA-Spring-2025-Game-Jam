extends CharacterBody2D

enum States {EGG, CATERPILLAR, BUTTERFLY}

var state: States = States.CATERPILLAR


const EGG_SPEED = 200.0
const EGG_JUMP_VELOCITY = -100.0

const CATERPILLAR_SPEED = 300.0
const CATERPILLAR_JUMP_VELOCITY = -600.0

const BUTTERFLY_SPEED = 300.0
const BUTTERFLY_JUMP_VELOCITY = -1200.0


func _physics_process(delta: float) -> void:
	
	var current_speed = 150.0
	var current_jump = -50.0
	if (state == States.EGG):
		current_speed = EGG_SPEED
		current_jump = EGG_JUMP_VELOCITY
	elif (state == States.CATERPILLAR):
		current_speed = CATERPILLAR_SPEED
		current_jump = CATERPILLAR_JUMP_VELOCITY
	elif (state == States.BUTTERFLY):
		current_speed = BUTTERFLY_SPEED
		current_jump = BUTTERFLY_JUMP_VELOCITY
	
	# Add the gravity.
	if not is_on_floor():
		if (state == States.BUTTERFLY):
			velocity += get_gravity() * delta / 2
		else:
			velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and state != States.BUTTERFLY:
		velocity.y = current_jump
		
	# Handle flying.
	if Input.is_action_just_pressed("ui_accept") and state == States.BUTTERFLY:
		velocity.y = current_jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * current_speed * delta
		if (velocity.x > 600):
			velocity.x = 600
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()
