extends Label

func _process(delta: float) -> void:
	GameState.timer_time += delta
	self.text = format_time(GameState.timer_time)

func format_time(seconds: float) -> String:
	var minutes = int(seconds) / 60
	var secs = int(seconds) % 60
	var millis = int((seconds - int(seconds)) * 100)
	return "%02d:%02d.%02d" % [minutes, secs, millis]
