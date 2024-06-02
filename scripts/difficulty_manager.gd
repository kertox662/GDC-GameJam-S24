extends Node2D
class_name DifficultyManager

var possible_tasks = [0,1,2,3,4]
var creator = [
		[TaskEntityFactory.create_h_swipe_pattern, {"x": 300, "y": 450}],
		[TaskEntityFactory.create_vup_swipe_pattern, {"x": 350, "y": 200}],
		[TaskEntityFactory.create_vdown_swipe_pattern, {"x": 400, "y": 450}],
		[TaskEntityFactory.create_rotate_pattern, {"x": 450, "y": 200}],
		[TaskEntityFactory.create_word_pattern, {"x": 500, "y": 450}],
	]
var group
var entities = []

const variation_of_difficulty = 1.5
const speed_of_difficulty = 0.02
const sin_modifier = 5

var array_of_task_statuses := [false, false, false, false, false]

var array_of_task_weighting := [1, 1, 1, 1, 1]

func _ready():
	TaskEntityFactory.setup_patterns()
	add_entity()
	

func _input(event):
	if event is InputEventKey:
		for entity in entities:
			if entity[0] != null:
				entity[0].key_input(event)
		entities.erase(null)
		
		#if event.keycode == KEY_SPACE and event.pressed:
			#add_entity()
			
func add_entity():
	var entity_packet = random_entity()
	if not entity_packet:
		return
	var task_number = entity_packet[1]
	var actual_entity = entity_packet[0]
	array_of_task_statuses[task_number] = true
	possible_tasks.erase(task_number)
	actual_entity.scale = Vector2(0.5,0.5)
	var offset_y = randi_range(-200, 200)
	actual_entity.global_position += Vector2(entity_packet[2]["x"], entity_packet[2]["y"])
	
	add_child(actual_entity)
	entities.append([actual_entity, task_number])
	$"../../../GameTimer".add_incomplete_task()
	
func random_entity():
	var reverse = randf() > 0.5
	if possible_tasks.size() == 0:
		return null
	var random_task = possible_tasks.pick_random()
	if random_task == null:
		return null
	return [creator[random_task][0].call(reverse), random_task, creator[random_task][1]]

func current_task_buildup():
	var current_buildup := 0
	for i in len(array_of_task_statuses):
		var ith_task_active := 1 if array_of_task_statuses[i] else 0
		current_buildup += ith_task_active * array_of_task_weighting[i]
	return current_buildup
	
func current_time_buildup():
	return (variation_of_difficulty * sin(Time.get_ticks_msec() / 1000)) + (speed_of_difficulty * (Time.get_ticks_msec() / 1000)) + sin_modifier
	

func adjust_difficulty():
	# detect completed tasks
	for entity in entities:
			if not is_instance_valid(entity[0]):
				var index = entity[1]
				entities.erase(entity)
				possible_tasks.append(index)
				array_of_task_statuses[index] = false
				$"../../../GameTimer".complete_task()
	while float(current_task_buildup()) < current_time_buildup():
		if current_task_buildup() < len(possible_tasks):
			add_entity()
		else:
			break

	
	
