extends Node2D

func _ready():
	$GameOverText.text += str(GlobalStore.final_score)

func _input(event):
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().change_scene_to_file("res://scenes/main/menu.tscn")
