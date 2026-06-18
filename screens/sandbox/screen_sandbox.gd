class_name ScreenSandbox
extends Node3D

const REMINDER_TIMER_RESYNC_TIME: float = 60.0

var bot: DiscordBot
var appdata: AppData
var _next_reminder_time: TimeHMS
var _secs_til_next_reminder: float
var _secs_til_reminder_timer_resync: float
var _debug_secs_til_next_reminder: Label

var reminder_messages: Dictionary = {
	 6: "# :sunrise_over_mountains:   06:00am\nRise and shine!",
	 8: "# :milk:   08:00am\nShift hasn't started yet, but your initiative to work early is appreciated!",
	10: "# :cooking:   10:00am\nGood morning! I hope you've had your breakfast. Please tell us your agenda for today!",
	12: "# :curry:   12:00pm\nIt's the middle of noon. Time to get lunch! Please share your progress before heading off to eat!",
	14: "# :watermelon:   14:00pm\nThere's still 3 hours left til your shift is over. Have a light fruity snack while you prepare to share your progress!",
	16: "# :sandwich:   16:00pm\nThere's still 1 hour left til your shift is over. Here's a more fulfilling sandwich to fill your stomach. Share your progress still! Hang in there!",
	18: "# :shallow_pan_of_food:   18:00pm\nShift ended an hour ago! Please freshen up and get dinner before indulging in your nightly activities!",
	20: "# :cake:   20:00pm\nWorking late into the night? Here's a little treat for your hard work. You have 2 hours left before I insist you go to sleep!",
	22: "# :zzz:   22:00pm\nquit working. go to sleep."
}

#region Base methods

func on_screen_loaded():
	bot = $DiscordBot
	_debug_secs_til_next_reminder = $Control/DebugSecsTilNextReminder
	
	appdata = AppData.new()
	_read_local_appdata()
	
	bot.bot_ready.connect(_on_bot_ready)
	bot.message_create.connect(_on_message_create)
	bot.TOKEN = _fetch_token()
	bot.login()
	
	_reset_timer()


func _process(p_delta: float) -> void:
	_tick_down_reminder_timer(p_delta)
	
	if Input.is_action_pressed("debug_activator"):
		_handle_debug_inputs()

#endregion

#region Private methods

func _write_local_appdata():
	var file := FileAccess.open("res://secrets/data.json", FileAccess.WRITE)
	var string: String = JSON.stringify(appdata.as_dict(), "\t")
	file.store_string(string)
	file.close()


func _read_local_appdata():
	var file := FileAccess.open("res://secrets/data.json", FileAccess.READ)
	var dict_data: Dictionary = JSON.parse_string(file.get_as_text())
	appdata = AppData.from_dict(dict_data)
	file.close()


func _reset_timer():
	var current_time = TimeHMS.from_dict(Time.get_time_dict_from_system())
	var current_hour: int = current_time.hour
	
	var reminder_hours: Array[int] = [6, 8, 10, 12, 14, 16, 18, 20, 22]
	var next_hour: int = 6
	
	if current_hour < 22:
		for hour in reminder_hours:
			if hour > current_time.hour:
				next_hour = hour
				break
	print(next_hour)
	
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
			#bot.send(appdata.guilds[&"alkotoyarule"].channel_ids[&"general"], reminder_message)
		_reset_timer()


func _fetch_token() -> String:
	var fa := FileAccess.open("res://secrets/bot_token.txt", FileAccess.READ)
	var content: String = fa.get_as_text()
	var content_len: int = content.length() - 1
	content = content.substr(0, content_len)
	fa.close()
	return content

#endregion

#region Private method - Send announcement

func _send_announcement(p_bot: DiscordBot):
	var current_time := DateTimeLong.from_dict(Time.get_datetime_dict_from_system())
	var day: int = current_time.day
	var month_index: int = current_time.month
	var month_name: String = DateTimeUtil.get_month_name(month_index)
	var weekday_name: String = DateTimeUtil.get_weekday_name(current_time.weekday)
	
	var should_make_announcement: bool = \
		!appdata.global.last_announcement_datetime.is_the_same_date(current_time)
	
	if !should_make_announcement:
		return
	var announcement: String
	
	#region Ping everyone
	var string_pings: String
	for key in appdata.users:
		var user: AlkotoUser = appdata.users[key]
		string_pings += " %s" % DiscordUtil.get_user_mention(user.discord_id)
		pass
	string_pings += "\n"
	announcement += string_pings
	#endregion
	
	#region Greet everyone
	announcement += "Good morning! It is now **%s, %d %s %d.**\n" % \
		[weekday_name, current_time.day, month_name, current_time.year]
	#endregion
	
	#region Render month progress bar
	const FILLED_BAR_UNICODE: String = "█"
	var pb_primary: String = ""
	var pb_secondary: String = ""
	
	var days_in_this_month: int = DateTimeUtil.get_day_count_in_month(month_index - 1)
	var saturday_count: int = 1
	for month_day in range(1, days_in_this_month + 1):
		var month_day_date_dict_raw = {
			"year": current_time.year,
			"month": current_time.month,
			"day": month_day
		}
		var month_day_unix: int = Time.get_unix_time_from_datetime_dict(month_day_date_dict_raw)
		var month_day_date_dict = Time.get_datetime_dict_from_unix_time(month_day_unix)
		var primary_is_on_tick: bool = \
			month_day_date_dict.weekday == 6 or \
			month_day == 1 or \
			month_day == days_in_this_month
		var secondary_is_on_tick: bool = month_day_date_dict.weekday == 6
		
		var primary_unicode: String = "|" if primary_is_on_tick else " "
		if day >= month_day:
			primary_unicode = FILLED_BAR_UNICODE
		var secondary_unicode: String = " " if !secondary_is_on_tick else str(saturday_count)
		
		pb_primary += primary_unicode
		pb_secondary += secondary_unicode
		
		if secondary_is_on_tick:
			saturday_count += 1
	
	announcement += "`%s`\n`%s`\n\n" % [pb_primary, pb_secondary]
	#endregion
	
	#region List out upcoming birthdays
	announcement += &":birthday:  **Upcoming birthdays!**\n-# Don't forget to celebrate them!\n\n"
	
	var ct: DateTimeLong = current_time.duplicate()
	ct.year = 0
	
	var temp_users: Array[TempUserBirthdateData]
	for key in appdata.users:
		var user: AlkotoUser = appdata.users[key]
		
		var tu_a := TempUserBirthdateData.new(user.name, user.birthdate, false)
		var da: int = tu_a.birthdate.get_diff_in_days(ct)
		if da > 0:
			temp_users.push_back(tu_a)
		
		var tu_b := TempUserBirthdateData.new(user.name, user.birthdate, true)
		var db: int = tu_b.birthdate.get_diff_in_days(ct)
		if db > 0:
			temp_users.push_back(tu_b)
	
	temp_users.sort_custom(
		func (a: TempUserBirthdateData, b: TempUserBirthdateData):
			var da: int = a.birthdate.get_diff_in_days(ct)
			var db: int = b.birthdate.get_diff_in_days(ct)
			return da < db
	)
	
	for temp_user in [temp_users[0], temp_users[1], temp_users[2]]:
		var days_left: int = temp_user.birthdate.get_diff_in_days(ct)
		announcement += "`%3d days`  %s!\n" % [days_left, temp_user.name]
	#endregion
	
	p_bot.send(appdata.guilds[&"alkotoyarule"].channel_ids[&"debug"], announcement)
	
	appdata.global.last_announcement_datetime = current_time
	_write_local_appdata()

#endregion

#region Private method - Debug

func _handle_debug_inputs():
	if Input.is_action_just_pressed("debug_1"):
		var image_texture_data: CompressedTexture2D = load("res://common/textures/icons/tex_icon_godot.svg")
		var image_data: Image = image_texture_data.get_image()
		var pba_image_data: PackedByteArray = image_data.save_png_to_buffer()
		
		var options: Dictionary = {
			"files": [
				{
					"name": "test.png",
					"media_type": "png",
					"data": pba_image_data
				}
			]
		}
		bot.send(appdata.guilds[&"alkotoyarule"].channel_ids[&"debug"], "👀", options)
	elif Input.is_action_just_pressed("debug_2"):
		#var res: Dictionary = await bot.get_public_threads(appdata.guilds[&"alkotoyarule"].channel_ids[&"wip_hub"])
		#print(res)
		pass

#endregion

#region Signals

func _on_bot_ready(p_bot: DiscordBot):
	print("Logged in as " + p_bot.user.username + "#" + p_bot.user.discriminator)
	print("Listening on " + str(p_bot.channels.size()) + " channels and " + str(p_bot.guilds.size()) + " guilds.")
	
	_send_announcement(p_bot)


func _on_message_create(p_bot: DiscordBot, p_message: Message, _p_channel: Dictionary):
	if p_message.author.id != appdata.users[&"alex"].discord_id:
		return
	var content: String = p_message.content
	print("Received message: " + content)
	if content != "test":
		return
	p_bot.send(p_message, "I got a message here")

#endregion

#region Subclasses

class TempUserBirthdateData:
	var name: String
	var birthdate: DateTimeLong
	
	func _init(
		p_name: String,
		p_birthdate: DateTimeLong,
		is_duplicate: bool
	):
		name = p_name
		birthdate = p_birthdate.duplicate()
		birthdate.year = 0 if !is_duplicate else 1 

#endregion
