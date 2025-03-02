extends Camera2D

var x_pos = 0.0
var y_pos = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	x_pos = position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = x_pos
	position.y = y_pos

func get_y_pos(get_y: float):
	y_pos = get_y
	
