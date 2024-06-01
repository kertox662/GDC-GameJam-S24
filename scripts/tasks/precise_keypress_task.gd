# PreciseKeypressTask is a KeypressTask but it reset if an
# incorrect key is pressed.
class_name PreciseKeypressTask extends KeypressTask

func key_input(event: InputEventKey):
	if !is_complete():
		if is_input_correct(event):
			next_key_index += 1
			signals.advance_sig.emit()
		else:
			reset_goal()
			signals.reset_sig.emit()
