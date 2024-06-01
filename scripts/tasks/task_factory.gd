class_name TaskFactory

static func new_swipe_task(finish_sig: Signal) -> KeypressTask:
	return KeypressTask.new("yuiop".to_ascii_buffer(), finish_sig)

static func new_spin_task(finish_sig: Signal) -> KeypressTask:
	return KeypressTask.new("weds".to_ascii_buffer(), finish_sig)

static func new_word_task(finish_sig: Signal) -> PreciseKeypressTask:
	return PreciseKeypressTask.new("bird".to_ascii_buffer(), finish_sig)
