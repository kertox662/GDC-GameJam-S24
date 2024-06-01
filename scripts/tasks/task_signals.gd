class_name TaskSignals

var finish_sig: Signal
var reset_sig: Signal
var advance_sig: Signal

func _init(finish_sig: Signal, reset_sig: Signal, advance_sig: Signal):
	self.finish_sig = finish_sig
	self.reset_sig = reset_sig
	self.advance_sig = advance_sig
