extends Area2D

<<<<<<< Updated upstream
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
=======
@export var state = 0.0

#func _ready():
	#connect("body_entered", self, "_on_body_entered")

#func _on_body_entered(_body):
	#print("okay!")

func body_entered(body: Node2D) -> void:
	if body.name == "Egg" and state == 0.0:
		var caterpillar_scene = load("res://Scenes/caterpillar.tscn")
		var caterpillar = caterpillar_scene.instantiate()
		caterpillar.position = body.position + Vector2(0, -60)
		caterpillar.visible = true
		body.queue_free()
		add_child(caterpillar)
		
	if body.name == "Caterpillar" and state == 1.0:
		var butterfly_scene = load("res://Scenes/butterfly.tscn")
		var butterfly = butterfly_scene.instantiate()
		butterfly.position = body.position + Vector2(0, -60)
		body.queue_free()
		add_child(butterfly)
	
>>>>>>> Stashed changes
