extends Sprite2D

@export var radius: float = 20.0
@onready var shader_material: ShaderMaterial = material

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_pos.x /= get_viewport_rect().size.x
	mouse_pos.y /= get_viewport_rect().size.y
	shader_material.set_shader_parameter("mouse_pos", mouse_pos)
