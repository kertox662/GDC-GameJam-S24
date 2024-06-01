extends Node2D

var label_center: Vector2
@export var font_colour: Color = Color(0.9,0.9,0.9)
@export var font_outline: Color = Color(0.1,0.1,0.1)

func _init(key_label: String):
	$KeyLabel.text = key_label

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

func _set_animation(name: String):
	$Key.animation = name

func _set_label(anchor: Marker2D):
	$KeyLabel.position = anchor.position - label_center
