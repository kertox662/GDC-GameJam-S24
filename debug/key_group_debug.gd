extends Node2D

func _on_timer_timeout():

	$DifficultyManager2.adjust_difficulty()
