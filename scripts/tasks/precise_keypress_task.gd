class_name PreciseKeypressTask extends KeypressTask

func key_input(event: InputEventKey):
	if !is_complete():
		if is_input_correct(event):
			next_key_index += 1
		else:
			reset_goal()
