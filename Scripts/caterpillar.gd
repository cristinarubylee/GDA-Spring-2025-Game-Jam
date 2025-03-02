extends CharacterBody2D

var speed := 500
var jump := -1000
var isClimbing := false
@onready var ground_ray = $GroundRay
@onready var l_wall_ray = $LeftWallRay
@onready var r_wall_ray = $RightWallRay

func _physics_process(delta: float) -> void:
	var surface_normal = Vector2.UP # Default to ground movement
	
	# Detect walls and ground
	isClimbing = false
	if l_wall_ray.is_colliding():
		surface_normal = l_wall_ray.get_collision_normal()
		isClimbing = true
	elif r_wall_ray.is_colliding():
		surface_normal = r_wall_ray.get_collision_normal()
		isClimbing = true
	elif ground_ray.is_colliding():
		surface_normal = ground_ray.get_collision_normal()
	
	# Check to see if trying to get back to ground
	if is_on_floor() and isClimbing:
		if l_wall_ray.is_colliding() and Input.is_action_just_pressed("ui_right"):
			isClimbing = false
			surface_normal = ground_ray.get_collision_normal()
		elif r_wall_ray.is_colliding() and Input.is_action_just_pressed("ui_left"):
			isClimbing = false
			surface_normal = ground_ray.get_collision_normal()
	
	# Compute movement direction perpendicular to the surface normal
	var move_dir = surface_normal.rotated(PI / 2)
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity = move_dir * speed * direction
	
	# Allow for up and down arrow keys when climbing
	if isClimbing:
		if Input.is_action_pressed("ui_up"):
			velocity = Vector2.UP * speed
		elif Input.is_action_pressed("ui_down"):
			velocity = Vector2.DOWN * speed
	
	if not is_on_floor() and not isClimbing:
		velocity += 40 * get_gravity() * delta
	
	
	move_and_slide()
