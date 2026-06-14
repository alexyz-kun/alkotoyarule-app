class_name TimeHMS

var hour: int
var minute: int
var second: int


func _init(p_hour: int = 0, p_minute: int = 0, p_second: int = 0):
	hour = p_hour
	minute = p_minute
	second = p_second


static func from_dict(p_dict: Dictionary) -> TimeHMS:
	var i := TimeHMS.new()
	i.hour = p_dict.hour
	i.minute = p_dict.minute
	i.second = p_dict.second
	return i


func get_diff_in_seconds(p_b: TimeHMS) -> int:
	var secs_in_a: int = 3600 * hour + 60 * minute + second
	var secs_in_b: int = 3600 * p_b.hour + 60 * p_b.minute + p_b.second
	return abs(secs_in_a - secs_in_b)


func _to_string() -> String:
	return "%02d:%02d:%02d" % [hour, minute, second]
