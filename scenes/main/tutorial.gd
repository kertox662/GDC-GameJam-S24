extends Node2D

func _ready():
	scale = get_viewport().size / Vector2(1152, 648)

func _on_done_pressed():
	get_tree().change_scene_to_file("res://scenes/main/game_canvas.tscn")
