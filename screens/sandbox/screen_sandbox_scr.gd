class_name ScreenSandbox
extends Node3D

const REMINDER_TIMER_RESYNC_TIME: float = 60.0

var bot: DiscordBot
var app_data: AlkotoAppData
var _next_reminder_time: TimeHMS
var _secs_til_next_reminder: float
var _secs_til_reminder_timer_resync: float
var _debug_secs_til_next_reminder: Label

var reminder_messages: Dictionary = {
	6: "# :sunrise_over_mountains:   06:00am
Rise and shine!",
	8: "# :milk:   08:00am
Shift hasn't started yet, but your initiative to work early is appreciated!",
	10: "# :cooking:   10:00am
Good morning! I hope you've had your breakfast. Please tell us your agenda for today!",
	12: "# :curry:   12:00pm
It's the middle of noon. Time to get lunch! Please share your progress before heading off to eat!",
	14: "# :watermelon:   14:00pm
There's still 3 hours left til your shift is over. Have a light fruity snack while you prepare to share your progress!",
	16: "# :sandwich:   16:00pm
There's still 1 hour left til your shift is over. Here's a more fulfilling sandwich to fill your stomach. Share your progress still! Hang in there!",
	18: "# :shallow_pan_of_food:   18:00pm
Shift ended an hour ago! Please freshen up and get dinner before indulging in your nightly activities!",
	20: "# :cake:   20:00pm
Working late into the night? Here's a little treat for your hard work. You have 2 hours left before I insist you go to sleep!",
	22: "# :zzz:   22:00pm
quit working. go to sleep."
}

#region Base methods


func on_screen_loaded():
	bot = $DiscordBot
	_debug_secs_til_next_reminder = $Control/DebugSecsTilNextReminder
	
	app_data = AlkotoAppData.new()
	_update_app_data()
	
	bot.bot_ready.connect(_on_bot_ready)
	bot.message_create.connect(_on_message_create)
	bot.TOKEN = _fetch_token()
	bot.login()
	
	_reset_timer()


func _process(p_delta: float) -> void:
	_tick_down_reminder_timer(p_delta)
	
	if !Input.is_action_pressed("debug_activator"):
		return
	if Input.is_action_just_pressed("debug_1"):
		bot.send(app_data.guild_list["alkotoyarule"].channels["general"], "👀")


#endregion

#region Private methods


func _update_app_data():
	var file := FileAccess.open("res://secrets/data.json", FileAccess.READ)
	var dict_data: Dictionary = JSON.parse_string(file.get_as_text())
	app_data.update_from_dict(dict_data)


func _reset_timer():
	var current_time = TimeHMS.from_dict(Time.get_time_dict_from_system())
	var current_hour: int = current_time.hour
	
	var reminder_hours: Array[int] = [6, 8, 10, 12, 14, 16, 18, 20, 22]
	var next_hour: int = 6
	
	if current_hour <= 22:
		for hour in reminder_hours:
			if hour > current_time.hour:
				next_hour = hour
				break
	
	_next_reminder_time = TimeHMS.new(next_hour, 0, 0)
	_secs_til_next_reminder = current_time.get_diff_in_seconds(_next_reminder_time)
	_secs_til_reminder_timer_resync = REMINDER_TIMER_RESYNC_TIME


func _tick_down_reminder_timer(p_delta: float):
	_secs_til_next_reminder -= p_delta
	_secs_til_reminder_timer_resync -= p_delta
	_debug_secs_til_next_reminder.text = "%.2f" % _secs_til_next_reminder
	
	if _secs_til_reminder_timer_resync <= 0 and \
		_secs_til_next_reminder > 2 * REMINDER_TIMER_RESYNC_TIME:
		var current_time = TimeHMS.from_dict(Time.get_time_dict_from_system())
		var prev_secs: float = _secs_til_next_reminder
		_secs_til_next_reminder = current_time.get_diff_in_seconds(_next_reminder_time)
		print("Resync diff: %.2f" % abs(prev_secs - _secs_til_next_reminder))
		_secs_til_reminder_timer_resync = REMINDER_TIMER_RESYNC_TIME
	
	if _secs_til_next_reminder <= 0:
		var current_time := TimeHMS.from_dict(Time.get_datetime_dict_from_system())
		if [6, 8, 10, 12, 14, 16, 18, 20, 22].has(current_time.hour):
			var reminder_message: String = reminder_messages[current_time.hour]
			bot.send(app_data.guild_list["alkotoyarule"].general, reminder_message)
		_reset_timer()


func _fetch_token() -> String:
	var fa := FileAccess.open("res://secrets/bot_token.txt", FileAccess.READ)
	var content: String = fa.get_as_text()
	var content_len: int = content.length() - 1
	content = content.substr(0, content_len)
	fa.close()
	return content


#endregion

#region Signals


func _on_bot_ready(bot: DiscordBot):
	print("Logged in as " + bot.user.username + "#" + bot.user.discriminator)
	print("Listening on " + str(bot.channels.size()) + " channels and " + str(bot.guilds.size()) + " guilds.")


func _on_message_create(bot: DiscordBot, message: Message, channel: Dictionary):
	if message.author.id != app_data.get_user("alex").discord_id:
		return
	var content: String = message.content
	print("Received message: " + content)
	if content != "test":
		return
	bot.send(message, "I got a message here")


#endregion
