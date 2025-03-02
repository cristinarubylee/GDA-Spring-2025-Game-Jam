extends Area2D

@onready var camera = %stuck_camera
@onready var caterpillar = $Caterpillar
@onready var butterfly = $Butterfly

@export var state = 0

func body_entered(body: Node2D) -> void:
	if body.name == "Egg" and state == 0:
		caterpillar.position = body.position
		caterpillar.visible = true
		body.queue_free()
	if body.name == "Caterpillar" and state == 1:
		butterfly.position = body.position
		butterfly.visible = true
		body.queue_free()
