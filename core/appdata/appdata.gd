class_name AppData

var global: AppDataGlobal
var users: Dictionary[String, AlkotoUser]
var guilds: Dictionary[String, AppDataDiscordGuildIDs]
var clients: Dictionary
var works: Dictionary
var outings: Dictionary
var tags: Dictionary

#region Public methods

static func from_dict(dict: Dictionary) -> AppData:
	var new_object := AppData.new()
	new_object.global = AppDataGlobal.from_dict(dict.global)
	
	for key in dict.users:
		var curr_user := AlkotoUser.from_dict(dict.users[key])
		new_object.users[curr_user.name] = curr_user
	
	for key in dict.guilds:
		var curr_guild := AppDataDiscordGuildIDs.from_dict(dict.guilds[key])
		new_object.guilds[curr_guild.name] = curr_guild
	
	return new_object


func as_dict() -> Dictionary:
	var users_dict: Dictionary = {}
	for key in users:
		var user: AlkotoUser = users[key]
		users_dict[user.name] = user.as_dict()
	
	var guilds_dict: Dictionary = {}
	for key in guilds:
		var guild: AppDataDiscordGuildIDs = guilds[key]
		guilds_dict[guild.name] = guild.as_dict()
	
	return {"global": global.as_dict(), "users": users_dict, "guilds": guilds_dict, "clients": {}, "works": {}, "outings": {}, "tags": {}}

#endregion
