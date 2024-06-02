extends Node2D

func _ready():
	scale = get_viewport_rect().size / Vector2(2560, 1440)
	
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property($Logo, "position", $LogoAnchor.position, 1)
	tween.tween_property($PlayButton, "position", $PlayAnchor.position, 1.2)
	tween.tween_property($MenuMusic, "volume_db", -12, 3)
	
	var quit_tween = get_tree().create_tween()
	quit_tween.tween_property($QuitButton, "position", $QuitAnchor.position, 1.2)
	quit_tween.tween_callback(make_credit_button_visible)

func _on_play_button_pressed():
	if GlobalStore.seen_tutorial:
		GlobalStore.seen_tutorial = true
		get_tree().change_scene_to_file("res://scenes/main/game_canvas.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/main/tutorial.tscn")
	
func _on_quit_button_pressed():
	get_tree().quit()
	
func _on_credits_button_pressed():
	make_credits_visible()

func make_credit_button_visible():
	$CreditsButton.visible = true

func make_credits_visible():
	$Credits.visible = true

func make_credits_invisible():
	$Credits.visible = false

func _input(event):
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		make_credits_invisible()

func _on_logo_gui_input(event):
	if event is InputEventMouseButton:
		if !$MenuEffect.playing:
			$MenuEffect.play()
