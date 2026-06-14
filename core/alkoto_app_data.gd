class_name AlkotoAppData

var user_list: Dictionary
var guild_list: Dictionary

func update_from_dict(p_dict: Dictionary):
	user_list = p_dict.users
	guild_list = p_dict.guilds


func get_user(p_name: String) -> AlkotoUser:
	return user_list[p_name]
