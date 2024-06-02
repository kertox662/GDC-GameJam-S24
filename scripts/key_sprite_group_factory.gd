class_name KeySpriteGroupFactory

static var h_swipe_scene_template = load("res://scenes/tasks/templates/swipe_h_template.tscn")
static var vup_swipe_scene_template = load("res://scenes/tasks/templates/swipe_vup_template.tscn")
static var vdown_swipe_scene_template = load("res://scenes/tasks/templates/swipe_vdown_template.tscn")
static var rotate_scene_template = load("res://scenes/tasks/templates/rotate_template.tscn")
static var word_scene_template = load("res://scenes/tasks/templates/word_template.tscn")

static func create_horizontal_swipe_pattern(pattern: String, reversed: bool = false) -> KeySpriteGroup:
	var inst = h_swipe_scene_template.instantiate()
	return _create_key_group(pattern, inst, reversed)
	
static func create_vertical_up_swipe_pattern(pattern: String, reversed: bool = false) -> KeySpriteGroup:
	var inst = vup_swipe_scene_template.instantiate()
	return _create_key_group(pattern, inst, reversed)

static func create_vertical_down_swipe_pattern(pattern: String, reversed: bool = false) -> KeySpriteGroup:
	var inst = vdown_swipe_scene_template.instantiate()
	return _create_key_group(pattern, inst, reversed)
	
static func create_rotation_pattern(pattern: String, reversed: bool = false) -> KeySpriteGroup:
	var inst = rotate_scene_template.instantiate()
	return _create_key_group(pattern, inst, reversed)
	
static func create_word_pattern(pattern: String) -> KeySpriteGroup:
	var inst = word_scene_template.instantiate()
	return _create_key_group(pattern, inst, false)

static func _create_key_group(pattern: String, inst, reversed: bool):
	assert(len(pattern) == inst.get_node("SpriteGroup").get_child_count())
	
	var ind = 0
	var dir = 1
	if reversed:
		ind = len(pattern) - 1
		dir = -1
		
	var sprites = []
	for child in inst.get_node("SpriteGroup").get_children():
		inst.get_node("SpriteGroup").remove_child(child)
		child.key_label = pattern[ind]
		sprites.push_back(child)
		ind += dir
	
	if reversed:
		sprites.reverse()
	
	var group = KeySpriteGroup.new(pattern, sprites)
	
	var hint_name = "Hint"
	if reversed:
		hint_name = "HintR"
	
	var hint = inst.get_node(hint_name)
	if hint != null:
		inst.remove_child(hint)
		group.add_child(hint)
	
	var icon = inst.get_node("TaskIcon")
	if icon != null:
		inst.remove_child(icon)
		group.add_child(icon)
	
	inst.queue_free()	
	
	return group
