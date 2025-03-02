extends Area2D

#func _ready():
	#connect("body_entered", self, "_on_body_entered")

#func _on_body_entered(_body):
	#print("okay!")

func body_entered(body: Node2D) -> void:
	if body.name == "Egg":
		var caterpillar_scene = load("res://Scenes/caterpillar.tscn")
		var caterpillar = caterpillar_scene.instantiate()
		caterpillar.position = body.position + Vector2(0, -60)
		body.queue_free()
		add_child(caterpillar)
	
