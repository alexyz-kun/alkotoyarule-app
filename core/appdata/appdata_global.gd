class_name AppDataGlobal

var last_announcement_datetime: DateTimeLong

func _init(p_last_announcement_datetime: DateTimeLong):
	last_announcement_datetime = p_last_announcement_datetime

#region Public methods

static func from_dict(dict: Dictionary) -> AppDataGlobal:
	return AppDataGlobal.new(
		DateTimeLong.from_dict(dict.last_announcement_datetime)
	)


func as_dict() -> Dictionary:
	return {"last_announcement_datetime": last_announcement_datetime.as_dict()}

#endregion
