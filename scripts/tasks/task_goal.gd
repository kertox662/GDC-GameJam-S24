# TaskGoal is the base class for all tasks
class_name TaskGoal

var signals: TaskSignals

func _init(signals: TaskSignals):
	self.signals = signals

func key_input(event: InputEventKey):
	pass

func reset_goal():
	pass

func is_complete() -> bool:
	return false

static func normalize_pattern(pattern: String) -> Array[String]:
	return pattern.to_lower().to_ascii_buffer()
