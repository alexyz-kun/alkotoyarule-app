class_name ScreenSandbox
extends Node3D

var bot: DiscordBot

# Base methods

func on_screen_loaded():
	bot = $DiscordBot
	
	bot.bot_ready.connect(_on_bot_ready)
	bot.message_create.connect(_on_message_create)
	bot.TOKEN = ""
	bot.login()


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
