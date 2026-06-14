class_name DiscordGuild
# Reference:
# https://docs.discord.com/developers/resources/guild

#region Fields
var id: String
var name: String
var icon: String
var icon_hash: String
var splash: String
var discovery_splash: String
var owner: bool ## Whether or not user is the owner of the guild.
var owner_id: String
var permissions: String
var region: String ## (Deprecated.)
var afk_channel_id: String
var afk_timeout: int
var widget_enabled: bool
var widget_channel_id: String
var verification_level: int
var default_message_notifications: int
var explicit_content_filter: int
var roles: Array
var emojis: Array
var features: Array
var mfa_level: int
var application_id: String
var system_channel_id: String
var system_channel_flags: int
var rules_channel_id: String
var max_presences: int
var max_members: int
var vanity_url_code: String
var description: String
var banner: String
var premium_tier: int
var premium_subscription_count: int
var preferred_locale: String
var public_updates_channel_id: String
var max_video_channel_users: int
var max_stage_video_channel_users: int
var approximate_member_count: int
var approximate_presence_count: int
var welcome_screen
var nsfw_level: int
var stickers: Array
var premium_progress_bar_enabled: bool
var safety_alerts_channel_id: String
var incidents_data
#endregion


static func from_dict(p_data: Dictionary) -> DiscordGuild:
	var guild := DiscordGuild.new()
	guild.id = p_data.id
	guild.name = p_data.name
	return guild
