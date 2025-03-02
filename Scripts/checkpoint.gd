extends Area2D

@onready var camera = %stuck_camera
@onready var caterpillar = $Caterpillar

func body_entered(body: Node2D) -> void:
	if body.name == "Egg":
		caterpillar.position = body.position
		caterpillar.visible = true
		body.queue_free()
	#if body.name == "Caterpillar" and not processed:
		#butterfly.position = body.position
		#body.queue_free()
		#processed = true
