extends Camera2D

var target_position = Vector2(0, -3500)  # Adjust the target position as needed
var pan_speed = 1000  # Adjust the pan speed as needed

func _ready():
	position = Vector2(0, 0)  # Set the initial position of the camera
	zoom = Vector2(0.5, 0.5)  # Adjust the zoom factor as needed (2x zoom-out)

func _process(delta):
	if position.y > target_position.y:
		position.y -= pan_speed * delta
		if position.y < target_position.y:
			position.y = target_position.y
	else:
		%stuck_camera.make_current()
