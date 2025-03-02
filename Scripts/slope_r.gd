extends Area2D

@onready var player = %player

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("On slope!")
		player.on_right_slope()


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		print("Off slope!")
		player.off_right_slope()
