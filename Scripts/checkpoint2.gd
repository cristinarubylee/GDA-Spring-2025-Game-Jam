extends Area2D

@onready var camera = %stuck_camera
@onready var butterfly = $Butterfly

@export var state = 0

func body_entered(body: Node2D) -> void:
	if body.name == "Caterpillar" and state == 1:
		butterfly.position = body.position
		butterfly.visible = true
		body.queue_free()
