extends Node2D

#var group
#var entities = []

var difficulty_manager = DifficultyManager.new()

#func _ready():
	#TaskEntityFactory.setup_patterns()


#func _input(event):
	#if event is InputEventKey:
		#for entity in entities:
			#if entity != null:
				#entity.key_input(event)
		#entities.erase(null)
		#
		#if event.keycode == KEY_SPACE and event.pressed:
			#add_entity()



#func add_entity():
	#var entity = random_entity()
	#entity.scale = Vector2(0.5,0.5)
	#var offset_x = randi_range(-400, 400)
	#var offset_y = randi_range(-200, 200)
	#entity.position += Vector2(offset_x, offset_y)
	#
	#add_child(entity)
	#entities.append(entity)
	#
#func random_entity():
	#var reverse = randf() > 0.5
	#var creator = [
		#TaskEntityFactory.create_h_swipe_pattern,
		#TaskEntityFactory.create_vup_swipe_pattern,
		#TaskEntityFactory.create_vdown_swipe_pattern,
		#TaskEntityFactory.create_rotate_pattern,
		#TaskEntityFactory.create_word_pattern,
	#].pick_random()
	#return creator.call(reverse)


func _on_timer_timeout():
	#add_entity()
	difficulty_manager.adjust_difficulty()
