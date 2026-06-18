class_name DiscordChannel

# Reference:
# https://docs.discord.com/developers/resources/channel#channel-object
#region Fields
var id: String
var type: int
var guild_id: String
var position: int
var permission_overwrites
var name: String
var topic: String
var nsfw: bool
var last_message_id: String
var bitrate: int
var user_limit: int
var rate_limit_per_user: int
var recipients
var icon
var owner_id: String
var application_id: String
var managed: bool
var parent_id: String
var last_pin_timestamp: String
var rtc_region: String
var video_quality_mode: int
var message_count: int
var member_count: int
var thread_metadata
var member
var default_auto_archive_duration: int
var permissions: String
var flags: int
var total_message_sent: int
var available_tags
var applied_tags
var default_reaction_emoji
var default_thread_rate_limit_per_user: int
var default_sort_order: int
var default_forum_layout: int
#endregion

static func from_dict(data: Dictionary) -> DiscordChannel:
	var channel := DiscordChannel.new()
	channel.id = data.id
	channel.name = data.name
	return channel
