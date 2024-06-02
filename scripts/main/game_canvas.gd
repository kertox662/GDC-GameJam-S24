extends CanvasLayer

func _ready():
	var music_tween = get_tree().create_tween()
	music_tween.tween_property($GameMusic, "volume_db", -10, 2)
	scale = Vector2(get_viewport().size) / Vector2(1152,648)

func _on_game_music_finished():
	$GameMusic.play()
