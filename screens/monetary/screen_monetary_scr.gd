class_name ScreenMonetary
extends Node3D

# Internal nodes
var root_control: Control
var outing_list: VBoxContainer
var new_outing_item_button: Button
var empty_outing_placeholder_label: Label
# Prefabs
var prefab_outing_item: PackedScene

# Base methods

func on_screen_loaded():
	root_control = $Control
	outing_list = $Control/ScreenPadding/VBoxContainer/ScrollContainer/OutingListAndFooter/OutingList
	new_outing_item_button = $Control/ScreenPadding/VBoxContainer/ScrollContainer/OutingListAndFooter/NewOutingButton
	empty_outing_placeholder_label = $Control/ScreenPadding/VBoxContainer/ScrollContainer/OutingListAndFooter/OutingList/EmptyPlaceholder
	# Prefabs
	prefab_outing_item = load(ResourcePath.screen.monetary.ui_outing)
	
	# Signals
	new_outing_item_button.pressed.connect(_on_new_outing_item_button_pressed)


# Signals

func _on_new_outing_item_button_pressed():
	var new_outing: OutingComponent = prefab_outing_item.instantiate()
	outing_list.add_child(new_outing)
	new_outing.set_up()
	empty_outing_placeholder_label.visible = false
