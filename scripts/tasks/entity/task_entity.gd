extends Node2D

var key_groups
var task_goal
var signals: TaskSignals

func _init():
	signals = TaskSignals.new()
	_connect_signals()

func create(key_groups, task_goal):
	self.key_groups = key_groups
	self.task_goal = task_goal
	for keys in key_groups:
		add_child(keys)

func _ready():
	task_goal.reset_goal()

func _connect_signals():
	signals.select_sig.connect(_on_key_select)
	signals.unselect_sig.connect(_on_key_unselect)
	signals.reset_sig.connect(_on_task_reset)
	signals.finish_sig.connect(_on_task_complete)

func key_input(event: InputEventKey):
	task_goal.key_input(event)
	for keys in key_groups:
		keys.key_event(event)

func _on_key_select(index):
	key_groups[index[0]].set_selected(index[1])

func _on_key_unselect(index):
	key_groups[index[0]].unset_selected(index[1])

func _on_task_reset():
	task_goal.reset_goal()

func _on_task_complete():
	queue_free()
