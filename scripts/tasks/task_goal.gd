# TaskGoal is the base class for all tasks
class_name TaskGoal

var completion_signal: Signal

func _init(completion_signal: Signal):
	self.completion_signal = completion_signal

func key_input(event: InputEventKey):
	pass

func reset_goal():
	pass

func is_complete() -> bool:
	return false
