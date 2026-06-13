class_name ScreenSandbox
extends Node3D

var bot: DiscordBot

# Base methods

func on_screen_loaded():
	bot = $DiscordBot
	
	bot.bot_ready.connect(_on_bot_ready)
	bot.message_create.connect(_on_message_create)
	bot.TOKEN = _fetch_token()
	bot.login()


# Private methods

func _fetch_token() -> String:
	var fa := FileAccess.open("res://secrets/bot_token.txt", FileAccess.READ)
	var content: String = fa.get_as_text()
	var content_len: int = content.length() - 1
	content = content.substr(0, content_len)
	fa.close()
	return content


# Signals

func _on_bot_ready(bot: DiscordBot):
	print("Logged in as " + bot.user.username + "#" + bot.user.discriminator)
	print("Listening on " + str(bot.channels.size()) + " channels and " + str(bot.guilds.size()) + " guilds.")
	print(bot.guilds)
	# print(bot.guilds.cache.get("1414551740040347680").name)


func _on_message_create(bot: DiscordBot, message: Message, channel: Dictionary):
	if message.author.id == bot.user.id:
		return
	var content = message.content
	print("Received message: " + content)
	bot.send(message, "I got a message here")
