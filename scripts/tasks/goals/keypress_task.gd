# KeypressTask is a task requiring the player to press
# keys in a certain order. Pressing an incorrect key
# does not interrupt this task.
class_name KeypressTask extends TaskGoal

var key_order: Array[String]
var next_key_index: int

func _init(keys: String, signals: TaskSignals):
	super(signals)
	key_order = _str_to_arr(keys)
	next_key_index = 0
	print(keys)

func is_input_correct(event) -> bool:
	return key_order[next_key_index] == TaskGoal.normalize_key_event(event)

func key_input(event: InputEventKey):
	if !is_complete() and event.pressed and is_input_correct(event):
		print("NEXT")
		signals.unselect_sig.emit([0,next_key_index])
		next_key_index += 1
		if !is_complete():
			signals.select_sig.emit([0,next_key_index])
	if next_key_index >= len(key_order):
		print("FINISHING")
		signals.finish_sig.emit()

func reset_goal():
	signals.unselect_sig.emit([0,next_key_index])
	next_key_index = 0
	signals.select_sig.emit([0,0])

func is_complete() -> bool:
	return next_key_index >= key_order.size()

