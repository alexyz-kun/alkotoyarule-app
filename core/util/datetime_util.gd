class_name DateTimeUtil

const SECS_IN_MINUTE: int = 60
const SECS_IN_HOUR: int = 60 * SECS_IN_MINUTE
const SECS_IN_DAY: int = 24 * SECS_IN_HOUR

static var _month_name_dict: Dictionary[int, Dictionary] = {
	1: {
		GlobalEnum.Language.EN: {
			"long": "January",
			"short": "Jan"
		},
		GlobalEnum.Language.ID: {
			"long": "Januari",
			"short": "Jan"
		}
	},
	2: {
		GlobalEnum.Language.EN: {
			"long": "February",
			"short": "Feb"
		},
		GlobalEnum.Language.ID: {
			"long": "Februari",
			"short": "Feb"
		}
	},
	3: {
		GlobalEnum.Language.EN: {
			"long": "March",
			"short": "Mar"
		},
		GlobalEnum.Language.ID: {
			"long": "Maret",
			"short": "Mar"
		}
	},
	4: {
		GlobalEnum.Language.EN: {
			"long": "April",
			"short": "Apr"
		},
		GlobalEnum.Language.ID: {
			"long": "April",
			"short": "Apr"
		}
	},
	5: {
		GlobalEnum.Language.EN: {
			"long": "May",
			"short": "May"
		},
		GlobalEnum.Language.ID: {
			"long": "Mei",
			"short": "Mei"
		}
	},
	6: {
		GlobalEnum.Language.EN: {
			"long": "June",
			"short": "Jun"
		},
		GlobalEnum.Language.ID: {
			"long": "Juni",
			"short": "Jun"
		}
	},
	7: {
		GlobalEnum.Language.EN: {
			"long": "July",
			"short": "Jul"
		},
		GlobalEnum.Language.ID: {
			"long": "Juli",
			"short": "Jul"
		}
	},
	8: {
		GlobalEnum.Language.EN: {
			"long": "August",
			"short": "Aug"
		},
		GlobalEnum.Language.ID: {
			"long": "Agustus",
			"short": "Agu"
		}
	},
	9: {
		GlobalEnum.Language.EN: {
			"long": "September",
			"short": "Sep"
		},
		GlobalEnum.Language.ID: {
			"long": "September",
			"short": "Sep"
		}
	},
	10: {
		GlobalEnum.Language.EN: {
			"long": "October",
			"short": "Oct"
		},
		GlobalEnum.Language.ID: {
			"long": "Oktober",
			"short": "Okt"
		}
	},
	11: {
		GlobalEnum.Language.EN: {
			"long": "November",
			"short": "Nov"
		},
		GlobalEnum.Language.ID: {
			"long": "November",
			"short": "Nov"
		}
	},
	12: {
		GlobalEnum.Language.EN: {
			"long": "December",
			"short": "Dec"
		},
		GlobalEnum.Language.ID: {
			"long": "Desember",
			"short": "Des"
		}
	},
}

static var _weekday_name_dict: Dictionary[int, Dictionary] = {
	1: {
		GlobalEnum.Language.EN: {
			"long": "Monday",
			"short": "Mon",
		},
		GlobalEnum.Language.ID: {
			"long": "Senin",
			"short": "Sen",
		}
	},
	2: {
		GlobalEnum.Language.EN: {
			"long": "Tuesday",
			"short": "Tue",
		},
		GlobalEnum.Language.ID: {
			"long": "Selasa",
			"short": "Sel",
		}
	},
	3: {
		GlobalEnum.Language.EN: {
			"long": "Wednesday",
			"short": "Wed",
		},
		GlobalEnum.Language.ID: {
			"long": "Rabu",
			"short": "Rab",
		}
	},
	4: {
		GlobalEnum.Language.EN: {
			"long": "Thursday",
			"short": "Thu",
		},
		GlobalEnum.Language.ID: {
			"long": "Kamis",
			"short": "Kam",
		}
	},
	5: {
		GlobalEnum.Language.EN: {
			"long": "Friday",
			"short": "Fri",
		},
		GlobalEnum.Language.ID: {
			"long": "Jumat",
			"short": "Jum",
		}
	},
	6: {
		GlobalEnum.Language.EN: {
			"long": "Saturday",
			"short": "Sat",
		},
		GlobalEnum.Language.ID: {
			"long": "Sabtu",
			"short": "Sab",
		}
	},
	7: {
		GlobalEnum.Language.EN: {
			"long": "Sunday",
			"short": "Sun",
		},
		GlobalEnum.Language.ID: {
			"long": "Minggu",
			"short": "Min",
		}
	}
}

static func get_month_name(
	index: int,
	lang: GlobalEnum.Language = GlobalEnum.Language.EN,
	is_long: bool = true) -> String:
	return _month_name_dict[index][lang]["long" if is_long else "short"]

static func get_weekday_name(
	index: int,
	lang: GlobalEnum.Language = GlobalEnum.Language.EN,
	is_long: bool = true) -> String:
	return _weekday_name_dict[index][lang]["long" if is_long else "short"]

static func get_day_count_in_month(index: int):
	var counts: Array[int] = [
		31, 28, 31, 30, 31, 30, 31,
		31, 30, 31, 30, 31, 30, 31
	]
	return counts[index]
