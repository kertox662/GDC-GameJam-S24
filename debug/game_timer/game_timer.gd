extends Node2D
@onready var num_of_incompleted_tasks : int = 0
@onready var game_timer = 0
@export var limit : float = 300.0
@onready var game_active = true
@onready var progress_bar = $ProgressBar

func _ready():
	progress_bar.max_value = limit - 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(game_active):
		if num_of_incompleted_tasks > 0:
			game_timer += delta * num_of_incompleted_tasks
		else:
			game_timer -= delta
		
		if game_timer < 0:
			game_timer = 0
		
		progress_bar.value = game_timer
		
		if(game_timer >= limit):
			print("JOEVER")
			game_active = false
	
func add_incomplete_task():
	num_of_incompleted_tasks += 1

func complete_task():
	num_of_incompleted_tasks -= 1
	if num_of_incompleted_tasks < 0:
		num_of_incompleted_tasks = 0

