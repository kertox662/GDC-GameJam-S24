extends Node2D

var group

func _ready():
	#group = KeySpriteGroupFactory.create_horizontal_swipe_pattern("YUIOP")
	#group = KeySpriteGroupFactory.create_vertical_up_swipe_pattern("vgy")
	group = KeySpriteGroupFactory.create_vertical_down_swipe_pattern("tgb")
	#group = KeySpriteGroupFactory.create_rotation_pattern("WEDS")
	add_child(group)

func _input(event):
	if event is InputEventKey:
		group.key_event(event)
