class_name ScreenMain
extends Node3D

static var instance: ScreenMain

var db: DB
var manager: Manager
# Internal nodes
var active_scene: Node3D
var active_scene_parent: Node

# Base methods

func _ready() -> void:
	if !instance:
		instance = self
	
	db = DB.new()
	manager = Manager.new()
	
	active_scene_parent = $ActiveSceneParent
	
	var new_scene_prefab: PackedScene = load(ResourcePath.screen.sandbox.scene)
	var new_scene: Node = new_scene_prefab.instantiate()
	active_scene_parent.add_child(new_scene)
	active_scene = new_scene
	
	var scene_example = new_scene
	scene_example.on_screen_loaded()


func _input(event: InputEvent) -> void:
	var mi: InputManager = manager.input
	if event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					mi.lmb_pressed.emit()
					mi.lmb_is_held = true
				MOUSE_BUTTON_RIGHT:
					mi.rmb_pressed.emit()
					mi.rmb_is_held = true
		if event.is_released():
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					mi.lmb_released.emit()
					mi.lmb_is_held = false
				MOUSE_BUTTON_RIGHT:
					mi.rmb_released.emit()
					mi.rmb_is_held = false


# Subclasses

class Manager:
	var input := InputManager.new()
	var audio := AudioManager.new()


class InputManager:
	signal lmb_pressed
	signal lmb_released
	signal rmb_pressed
	signal rmb_released
	
	var lmb_is_held: bool
	var rmb_is_held: bool


class AudioManager:
	const MAX_MUSIC_PLAYER_COUNT: int = 3
	const MAX_SOUND_PLAYER_COUNT: int = 3
	
	var music_player_list: Array[AudioStreamPlayer]
	var sound_player_list: Array[AudioStreamPlayer]
	# Managed nodes
	var music_player_parent: Node
	var sound_player_parent: Node
	
	# Base methods
	
	func _init():
		music_player_parent = ScreenMain.instance.get_node("AudioManager/MusicPlayerParent")
		sound_player_parent = ScreenMain.instance.get_node("AudioManager/SoundPlayerParent")
		
		for i in MAX_MUSIC_PLAYER_COUNT:
			var new_player := AudioStreamPlayer.new()
			music_player_parent.add_child(new_player)
			music_player_list.append(new_player)
		
		for i in MAX_SOUND_PLAYER_COUNT:
			var new_player := AudioStreamPlayer.new()
			sound_player_parent.add_child(new_player)
			sound_player_list.append(new_player)
	
	
	# Public methods
	
	func play_sound(p_stream: AudioStream):
		var sound_player: AudioStreamPlayer
		for player in sound_player_list:
			if player.playing:
				continue
			sound_player = player
			break
		if !sound_player:
			print_rich("[color=orange]Warning:[/color] Sound player list exhausted.")
			return
		sound_player.stream = p_stream
		sound_player.play()
