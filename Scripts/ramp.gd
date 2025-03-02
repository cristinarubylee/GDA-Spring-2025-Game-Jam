extends Area2D

@onready var player = %player

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("On ramp!")
		player.ramp()
