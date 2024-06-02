extends CanvasLayer

@onready var shader_material: ShaderMaterial = $TextureRect.material

func _ready():
	var music_tween = get_tree().create_tween()
	music_tween.tween_property($GameMusic, "volume_db", -10, 2)
	scale = Vector2(get_viewport().size) / Vector2(1152,648)

func _on_game_music_finished():
	$GameMusic.play()

func _process(delta):
	var mouse_pos = Vector2(get_viewport().get_mouse_position())
	mouse_pos /= Vector2(get_viewport().size)
	shader_material.set_shader_parameter("mouse_pos", mouse_pos)
