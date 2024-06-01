extends Node2D

var prev_dir = "L"
var cur_dir = "U"
var rng = RandomNumberGenerator.new()

func get_sprite(dir) -> AnimatedSprite2D:
	match dir:
		"L": return $SpriteL
		"R": return $SpriteR
		"U": return $SpriteU
		"D": return $SpriteD
	return null

func _ready():
	get_sprite(cur_dir).animation = "selected"

func _on_timer_timeout():
	get_sprite(prev_dir).animation = "default"

func _on_timer_a_timeout():
	$SpriteA.animation = "default"

func _input(event):
	if event is InputEventKey:
		var key = ""
		match event.keycode:
			KEY_LEFT: key = "L"
			KEY_RIGHT: key = "R"
			KEY_UP: key = "U"
			KEY_DOWN: key = "D"
		if key != "" and key == cur_dir:
			get_sprite(cur_dir).animation = "pressed"
			$Timer.start(0.12)
			
			var next_ind = rng.randi_range(0,3)
			var next = ["U","D","L","R"][next_ind]
			while next == cur_dir:
				next_ind = rng.randi_range(0,3)
				next = ["U","D","L","R"][next_ind]
			prev_dir = cur_dir
			cur_dir = next
			get_sprite(cur_dir).animation = "selected"
		
		if event.keycode == KEY_A:
			$SpriteA.animation = "pressed"
			$TimerA.start(0.12)
