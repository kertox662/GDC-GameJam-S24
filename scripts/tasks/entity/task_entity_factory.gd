class_name TaskEntityFactory

static var task_entity_scene = load("res://scenes/tasks/task_entity.tscn")

static var setup_complete = false

static var h_swipe_patterns
static var vup_swipe_patterns
static var vdown_swipe_patterns
static var rotate_patterns
static var words

static func setup_patterns():
	if setup_complete:
		return
	
	h_swipe_patterns = h_swipe_patterns_base
	h_swipe_patterns.shuffle()
	h_swipe_patterns.resize(2)
	
	vup_swipe_patterns = vup_swipe_patterns_base
	vup_swipe_patterns.shuffle()
	vup_swipe_patterns.resize(2)
	for i in len(vup_swipe_patterns):
		vup_swipe_patterns[i] = vup_swipe_patterns[i].reverse()
	
	vdown_swipe_patterns = vdown_swipe_patterns_base
	vdown_swipe_patterns.shuffle()
	vdown_swipe_patterns.resize(2)
	#for i in len(vdown_swipe_patterns):
		#vdown_swipe_patterns[i] = vdown_swipe_patterns[i].reverse()
	
	rotate_patterns = rotate_patterns_base
	rotate_patterns.shuffle()
	rotate_patterns.resize(2)
	
	words = words_base
	words.shuffle()
	words.resize(2)
	
	setup_complete = true

static func create_h_swipe_pattern(reversed: bool = false):
	return _create_swipe(
		h_swipe_patterns,
		KeySpriteGroupFactory.create_horizontal_swipe_pattern,
		reversed
	)

static func create_vup_swipe_pattern(reversed: bool = false):
	return _create_swipe(
		vup_swipe_patterns,
		KeySpriteGroupFactory.create_vertical_up_swipe_pattern,
		!reversed
	)

static func create_vdown_swipe_pattern(reversed: bool = false):
	return _create_swipe(
		vdown_swipe_patterns,
		KeySpriteGroupFactory.create_vertical_down_swipe_pattern,
		reversed
	)

static func create_rotate_pattern(reversed: bool = false):
	return _create_swipe(
		rotate_patterns,
		KeySpriteGroupFactory.create_rotation_pattern,
		reversed
	)

static func _create_swipe(pattern_pool, key_group_maker: Callable, reversed):
	var entity = task_entity_scene.instantiate()
	
	var pattern = pattern_pool.pick_random()
	if reversed:
		pattern = pattern.reverse()
	var key_group = key_group_maker.call(pattern, reversed)
	
	var task_goal = KeypressTask.new(pattern, entity.signals)
	entity.create([key_group], task_goal)
	return entity

static func create_word_pattern(_dummy_ = null):
	var entity = task_entity_scene.instantiate()
	
	var pattern = words.pick_random()
	var key_group = KeySpriteGroupFactory.create_word_pattern(pattern)
	
	var task_goal = PreciseKeypressTask.new(pattern, entity.signals)
	entity.create([key_group], task_goal)
	return entity

static var h_swipe_patterns_base = [
	"yuiop", "ertyu", "qwert",
	"asdfg", "fghjk", "ghjkl",
	"zxcvb", "cvbnm"
]

static var vup_swipe_patterns_base = [
	"zse", "xdr", "cft",
	"vgy", "bhu", "nji", "mko"
]

static var vdown_swipe_patterns_base = [
	"qaz", "wsx", "edc",
	"rfv", "tgb", "yhn", "ujm"
]

static var rotate_patterns_base = [
	"qwsa", "weds", "erfd",
	"yujh", "uikj", "iolk",
	"asxz", "sdcx", "dfvc",
	"hjmn", "ghnb", "fgbv"
]

static var words_base = [
	"come", "bell", "bear", "play",
	"sing", "bird", "bean", "game",
	"rice", "four", "five", "tree",
	"keep", "dark", "moon", "cool"
]

