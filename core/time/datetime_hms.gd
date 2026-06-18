class_name TimeHMS

var hour: int
var minute: int
var second: int


func _init(p_hour: int = 0, p_minute: int = 0, p_second: int = 0):
	hour = p_hour
	minute = p_minute
	second = p_second


static func from_dict(dict: Dictionary) -> TimeHMS:
	return TimeHMS.new(
		dict.hour,
		dict.minute,
		dict.second
	)


func as_dict() -> Dictionary:
	return {"hour": hour, "minute": minute, "second": second}


## The time passed in as the parameter will /always/ be interpreted to be in the future.
func get_diff_in_seconds(b: TimeHMS) -> int:
	var a := TimeHMS.new(hour, minute, second)
	if hour > b.hour:
		# Do some shifting if the hours cross the day line
		a.hour = 0
		b.hour += 24 - hour
	return 3600 * (b.hour - a.hour) + 60 * (b.minute - a.minute) + (b.second - a.second)


func _to_string() -> String:
	return "%02d:%02d:%02d" % [hour, minute, second]
