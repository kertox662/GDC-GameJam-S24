extends Node2D
@onready var num_of_incompleted_tasks : int = 0
@onready var game_timer = 0
@export var limit : float = 300.0
@onready var game_active = true
@onready var progress_bar = $ProgressBar
var time_survived: float = 0

func _ready():
	progress_bar.max_value = limit - 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(game_active):
		if num_of_incompleted_tasks > 0:
			game_timer += delta * (num_of_incompleted_tasks - 1) * 0.5 
		else:
			game_timer -= delta * 3
		
		if game_timer < 0:
			game_timer = 0
		
		progress_bar.value = game_timer
		
		if(game_timer >= limit):
			_go_to_game_over(time_survived)
			game_active = false
	
	time_survived += delta
	
func add_incomplete_task():
	num_of_incompleted_tasks += 1

func complete_task():
	num_of_incompleted_tasks -= 1
	if num_of_incompleted_tasks < 0:
		num_of_incompleted_tasks = 0

func _go_to_game_over(score):
	GlobalStore.final_score = int(time_survived)
	get_tree().change_scene_to_file("res://scenes/main/game_over.tscn")
