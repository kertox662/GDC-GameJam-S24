extends Node2D

func _input(event):
	if event is InputEventMouseMotion:
		$Sprite2D.position = event.position
