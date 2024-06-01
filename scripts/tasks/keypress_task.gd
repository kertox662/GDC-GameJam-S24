# KeypressTask is a task requiring the player to press
# keys in a certain order. Pressing an incorrect key
# does not interrupt this task.
class_name KeypressTask extends TaskGoal

var key_order: Array[String]
var next_key_index: int

func _init(keys: Array[String], signals: TaskSignals):
	super(signals)
	key_order = keys
	next_key_index = 0

func is_input_correct(event) -> bool:
	return key_order[next_key_index] == event.as_text_key_label()

func key_input(event: InputEventKey):
	if !is_complete() and is_input_correct(event):
		next_key_index += 1

func reset_goal():
	next_key_index = 0

func is_complete() -> bool:
	return next_key_index >= key_order.size()

