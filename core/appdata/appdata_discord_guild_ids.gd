class_name AppDataDiscordGuildIDs

var discord_id: String
var name: String
var channel_ids: Dictionary[String, String]

func _init(
	p_discord_id: String,
	p_name: String,
	p_channel_ids: Dictionary[String, String]):
	
	discord_id = p_discord_id
	name = p_name
	channel_ids = p_channel_ids


static func from_dict(dict: Dictionary) -> AppDataDiscordGuildIDs:
	var temp_channel_ids: Dictionary[String, String] = {}
	for key in dict.channel_ids:
		temp_channel_ids[key] = dict.channel_ids[key]
	return AppDataDiscordGuildIDs.new(dict.discord_id, dict.name, temp_channel_ids)


func as_dict() -> Dictionary:
	return {"discord_id": discord_id, "name": name, "channel_ids": channel_ids}
