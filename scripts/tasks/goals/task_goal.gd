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

static func _str_to_arr(str: String) -> Array[String]:
	var arr: Array[String] = []
	for c in str:
		arr.push_back(c)
	return arr

static func normalize_pattern(pattern: String) -> Array[String]:
	return _str_to_arr(pattern.to_lower())

static func normalize_key_event(event: InputEventKey) -> String:
	return event.as_text_key_label().to_lower()
