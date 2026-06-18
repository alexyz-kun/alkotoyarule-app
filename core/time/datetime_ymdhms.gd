class_name DateTimeLong

var year: int
var month: int
var day: int
var weekday: int
var hour: int
var minute: int
var second: int
var dst: bool

func _init(
	p_year: int = 1970,
	p_month: int = 1,
	p_day: int = 1,
	p_weekday: int = 1,
	p_hour: int = 0,
	p_minute: int = 0,
	p_second: int = 0,
	p_dst: bool = false):
	
	year = p_year
	month = p_month
	day = p_day
	weekday = p_weekday
	hour = p_hour
	minute = p_minute
	second = p_second
	dst = p_dst

#region Public methods

static func from_dict(dict: Dictionary) -> DateTimeLong:
	return DateTimeLong.new(
		dict.year		if dict.has("year") else 1970,
		dict.month		if dict.has("month") else 1,
		dict.day		if dict.has("day") else 1,
		dict.weekday	if dict.has("weekday") else 1,
		dict.hour		if dict.has("hour") else 0,
		dict.minute		if dict.has("minute") else 0,
		dict.second		if dict.has("second") else 0,
		dict.dst		if dict.has("dst") else false
	)


func as_dict() -> Dictionary:
	return {"year": year, "month": month, "day": day, "weekday": weekday, "hour": hour, "minute": minute, "second": second, "dst": dst}


func duplicate() -> DateTimeLong:
	return DateTimeLong.new(year, month, day, weekday, hour, minute, second, dst)


func get_diff_in_seconds(b: DateTimeLong) -> int:
	var unix_a: int = Time.get_unix_time_from_datetime_dict(as_dict())
	var unix_b: int = Time.get_unix_time_from_datetime_dict(b.as_dict())
	return unix_a - unix_b


func get_diff_in_days(b: DateTimeLong) -> int:
	return int(floor(get_diff_in_seconds(b) / 86400.0))


func is_the_same_date(value: DateTimeLong) -> bool:
	return (year == value.year and month == value.month and day == value.day)

#endregion
