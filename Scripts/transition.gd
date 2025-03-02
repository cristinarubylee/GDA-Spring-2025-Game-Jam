extends Node2D

onready var player = $Egg

func _ready():
	$Checkpoint.connect("player_collided", self, "_on_player_collided")

func _on_player_collided():
	print ("D")
