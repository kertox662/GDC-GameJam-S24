class_name KeySpriteGroup extends Node2D

var sprites
var sprite_key_map: Dictionary
var sprites_to_select: Array

func _init(pattern: String, sprites):
	assert(len(pattern) == len(sprites))
	
	self.sprites = sprites
	var pattern_arr = TaskGoal.normalize_pattern(pattern)
	for ind in range(len(pattern_arr)):
		sprite_key_map[pattern_arr[ind]] = sprites[ind]

func _ready():
	for sprite in sprites:
		add_child(sprite)

func set_selected(index: int):
	assert ((index >= 0) and (index < len(sprites)))
	var sprite = sprites[index]
	
	# Check that we need to wait to release and we haven't already
	# waited to select it.
	if !sprite.is_pressed():
		if sprite not in sprites_to_select:
			sprites_to_select.append(sprite)
	else:
		sprite.set_selected()
	

func key_event(event: InputEventKey):
	if event.pressed:
		_key_pressed(event)
	else:
		_key_released(event)
	
func _key_pressed(event: InputEventKey):
	var key = TaskGoal.normalize_key_event(event)
	if sprite_key_map.has(key):
		sprite_key_map[key].set_pressed()
	
func _key_released(event: InputEventKey):
	var key = TaskGoal.normalize_key_event(event)
	if !sprite_key_map.has(key):
		return
	var sprite = sprite_key_map[key]
	if sprite in sprites_to_select:
		sprite.set_selected()
		sprites_to_select.erase(sprite)
	else:
		sprite.set_normal()
