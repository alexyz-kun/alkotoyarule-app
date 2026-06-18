class_name OnlineHandle

var platform: OnlinePlatform
var title: String
var desc: String
var url: String


func as_dict() -> Dictionary:
	return {"platform": platform.as_dict(), "title": title, "desc": desc, "url": url}
