class_name SceneMain
extends Node3D

static var instance: SceneMain

var manager: Manager
var db: DB
# Internal nodes
var active_scene: Node3D
var active_scene_parent: Node

# Base methods

func _ready() -> void:
	if !instance:
		instance = self
	
	manager = Manager.new()
	db = DB.new()
	
	active_scene_parent = $ActiveSceneParent
	
	var new_scene_prefab: PackedScene = load(manager.resource.scene.monetary)
	var new_scene: Node = new_scene_prefab.instantiate()
	active_scene_parent.add_child(new_scene)
	active_scene = new_scene
	
	var scene_example: SceneMonetary = new_scene
	scene_example.on_scene_active()


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
	var resource := ResourceManager.new()
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
		music_player_parent = SceneMain.instance.get_node("AudioManager/MusicPlayerParent")
		sound_player_parent = SceneMain.instance.get_node("AudioManager/SoundPlayerParent")
		
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


class ResourceManager:
	var scene := SceneResourceManager.new()
	var prefab := PrefabResourceManager.new()
	var music := MusicResourceManager.new()
	var sound := SoundResourceManager.new()


class SceneResourceManager:
	var monetary: String = "res://scenes/scene_monetary.tscn"


class PrefabResourceManager:
	var outing: String = "res://prefabs/prefab_outing.tscn"
	var outing_activity: String = "res://prefabs/prefab_outing_activity.tscn"
	var outing_activity_expense: String = "res://prefabs/prefab_outing_activity_expense.tscn"
	var outing_activity_expense_item: String = "res://prefabs/prefab_outing_activity_expense_item.tscn"
	var user_selection_modal: String = "res://prefabs/prefab_user_selection_modal.tscn"
	var user_selection_item: String = "res://prefabs/prefab_user_selection_item.tscn"


class MusicResourceManager:
	var example: String = "res://audio/music/mus_example.ogg"


class SoundResourceManager:
	var example: String = "res://audio/sound/snd_example.wav"
