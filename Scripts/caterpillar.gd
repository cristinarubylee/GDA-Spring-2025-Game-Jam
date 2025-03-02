extends CharacterBody2D
var speed := 500
var gravity := 40 * 980
var isClimbing := false
var prev_isClimbing := false  # Track previous climbing state
var wall_detect_distance := 5.0  # Distance to check for walls
var wall_offset := 50.0  # Vertical offset from ground when first climbing (avoid clipping)
@onready var sprite = $AnimatedSprite2D
@onready var camera = %stuck_camera
var isFalling := false

func _physics_process(delta: float) -> void:
	
	#camera.get_y_pos(position.y)
	
	# Default to ground movement
	var surface_normal = Vector2.UP
	prev_isClimbing = isClimbing
	isClimbing = false
	
	var left_collision = move_and_collide(Vector2.LEFT * wall_detect_distance, true)
	var right_collision = move_and_collide(Vector2.RIGHT * wall_detect_distance, true)
	
	if left_collision and !isFalling:
		surface_normal = left_collision.get_normal()
		isClimbing = true
		
		if !prev_isClimbing:
			var wall_position = left_collision.get_position()
			var offset_vector = Vector2.UP * wall_offset
			global_position = wall_position + offset_vector
			
	elif right_collision and !isFalling:
		surface_normal = right_collision.get_normal()
		isClimbing = true
		
		if !prev_isClimbing:
			var wall_position = right_collision.get_position()
			var offset_vector = Vector2.UP * wall_offset
			global_position = wall_position + offset_vector
			
	elif is_on_floor():
		isFalling = false
		surface_normal = get_floor_normal()
	
	# Check if trying to get back to ground
	if is_on_floor() and isClimbing:
		if left_collision and Input.is_action_pressed("ui_right"):
			# Left wall and moving right
			isClimbing = false
			surface_normal = get_floor_normal()
		elif right_collision and Input.is_action_pressed("ui_left"):
			# Right wall and moving left
			isClimbing = false
			surface_normal = get_floor_normal()
	
	# Compute movement direction perpendicular to the surface normal
	var move_dir = surface_normal.rotated(PI / 2)
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Rotate the entire node (including collider) to align with surface
	# If on ground, no change!
	var angle = Vector2.UP.angle_to(surface_normal)
	rotation = angle
	
	# Flip sprite based on direction
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false
	
	velocity = move_dir * speed * direction
	
	# Allow for up and down arrow keys when climbing
	if isClimbing:
		if Input.is_action_pressed("ui_up"):
			velocity = Vector2.UP * speed
			sprite.flip_h = false
		elif Input.is_action_pressed("ui_down"):
			velocity = Vector2.DOWN * speed
			sprite.flip_h = true
		if Input.is_action_just_pressed("ui_accept"):
			isFalling = true
			isClimbing = false
			surface_normal = get_floor_normal()
	
	# Apply gravity
	if not is_on_floor() and not isClimbing:
		velocity.y += gravity * delta
	
	move_and_slide()
