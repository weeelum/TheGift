extends Node

# Time settings
const MINUTES_PER_TICK := 10.0
const SECONDS_PER_TICK := 1.0

# Current in-game time
var hour := 6
var minute := 0
var month := 1
var day := 1
var year := 1

# Internal timer
var _tick_timer := 0.0

signal time_updated(new_time: String)
signal date_updated(new_date: String)

func _process(delta: float) -> void:
	_tick_timer += delta
	if _tick_timer >= SECONDS_PER_TICK:
		_tick_timer = 0.0
		_advance_time()

func _advance_time() -> void:
	minute += MINUTES_PER_TICK
	if minute >= 60:
		minute = 0
		hour += 1
	if hour >= 24:
		hour = 0
		day += 1
		emit_signal("date_updated", get_date_string())
		# Optional: month/year rollover logic
	
	emit_signal("time_updated", get_time_string())
	
func get_time_string() -> String:
	return "%02d:%02d" % [hour, minute]

func get_date_string() -> String:
	return "%02d/%02d/%02d" % [month, day, year]
