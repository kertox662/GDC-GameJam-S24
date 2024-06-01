# PreciseKeypressTask is a KeypressTask but it reset if an
# incorrect key is pressed.
class_name PreciseKeypressTask extends KeypressTask

func key_input(event: InputEventKey):
	if !is_complete() and event.pressed:
		if is_input_correct(event):
			signals.unselect_sig.emit([0,next_key_index])
			next_key_index += 1
			if !is_complete():
				signals.select_sig.emit([0,next_key_index])
		else:
			signals.unselect_sig.emit([0,next_key_index])
			signals.select_sig.emit([0,0])
			reset_goal()
	
	if is_complete():
		signals.finish_sig.emit()
