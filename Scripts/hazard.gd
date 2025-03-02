extends Area2D


@onready var player = %player

@onready var timer = $Timer

func _on_body_entered(body: Node2D):
	if body.name == "player":
		timer.start()
		print("dead")
	
func _on_timer_timeout():
	get_tree().reload_current_scene()
