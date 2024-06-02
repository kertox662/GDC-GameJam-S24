extends Node2D

var current_num_tasks = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$NotifCircle/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$NotifCircle/Label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_num_tasks = $"../ColorRect/KeyGroupDebug/DifficultyManager2".current_task_buildup()
	if current_num_tasks < new_num_tasks:
		$NotifCircle/Label.text = str(new_num_tasks)
		$AnimationPlayer.play("notif_animation")
		current_num_tasks = new_num_tasks
