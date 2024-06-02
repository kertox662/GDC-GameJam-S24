extends Node2D

var label_center: Vector2
@export var font_colour: Color = Color(0.9,0.9,0.9)
@export var font_outline: Color = Color(0.1,0.1,0.1)

var key_label: String = "A":
	set(value):
		assert(len(value) == 1)
		key_label = value.to_upper()
		$KeyLabel.text = key_label
		label_center = $KeyLabel.size/2
		match $Key.animation:
			"default": set_normal()
			"selected": set_selected()
			"pressed": set_pressed()

func _ready():
	label_center = $KeyLabel.size/2
	$KeyLabel.label_settings.font_color = font_colour
	$KeyLabel.label_settings.outline_color = font_outline
	set_normal()

func set_normal():
	_set_animation("default")
	_set_label($TextAnchorUp)

func set_selected():
	_set_animation("selected")
	_set_label($TextAnchorUp)
	
func set_pressed():
	_set_animation("pressed")
	_set_label($TextAnchorPressed)
	$KeyClick.play(0)

func is_pressed() -> bool:
	return $Key.animation == "pressed"

func _set_animation(anim_name: String):
	$Key.animation = anim_name

func _set_label(anchor: Marker2D):
	$KeyLabel.position = anchor.position - label_center
	
@onready var shader_material: ShaderMaterial = material

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_pos.x /= get_viewport_rect().size.x
	mouse_pos.y /= get_viewport_rect().size.y
	material.set_shader_parameter("mouse_pos", mouse_pos)
