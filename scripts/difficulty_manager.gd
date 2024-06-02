extends Node2D
class_name DifficultyManager

var group
var entities = []

const variation_of_difficulty = 2
const speed_of_difficulty = 0.00005
const sin_modifier = (PI/2) + (2*PI)

var array_of_task_statuses := [false, false, false, false, false, false]

var array_of_task_weighting := [1, 1, 1, 2, 2, 2]

func _ready():
	TaskEntityFactory.setup_patterns()
	add_entity()
	

func _input(event):
	if event is InputEventKey:
		for entity in entities:
			if entity != null:
				entity.key_input(event)
		entities.erase(null)
		
		if event.keycode == KEY_SPACE and event.pressed:
			add_entity()
			
func add_entity():
	print(self.get_children())
	var entity = random_entity()
	entity.scale = Vector2(0.5,0.5)
	var offset_x = randi_range(-400, 400)
	var offset_y = randi_range(-200, 200)
	entity.position += Vector2(offset_x, offset_y)
	
	add_child(entity)
	entities.append(entity)
	print(self.get_children())
	
func random_entity():
	var reverse = randf() > 0.5
	var creator = [
		TaskEntityFactory.create_h_swipe_pattern,
		TaskEntityFactory.create_vup_swipe_pattern,
		TaskEntityFactory.create_vdown_swipe_pattern,
		TaskEntityFactory.create_rotate_pattern,
		TaskEntityFactory.create_word_pattern,
	].pick_random()
	return creator.call(reverse)

func current_task_buildup():
	var current_buildup := 0
	for i in len(array_of_task_statuses):
		var ith_task_active := 1 if array_of_task_statuses[i] else 0
		current_buildup += ith_task_active * array_of_task_weighting[i]
	return current_buildup
	
func current_time_buildup():
	return (variation_of_difficulty * sin(sin_modifier * Time.get_ticks_msec())) + (speed_of_difficulty * Time.get_ticks_msec())
	

func adjust_difficulty():
	print("current task: " + str(current_task_buildup()) + "current time: " + str(current_time_buildup()))
	if float(current_task_buildup()) < current_time_buildup():
		add_entity()
		pass
	
	
