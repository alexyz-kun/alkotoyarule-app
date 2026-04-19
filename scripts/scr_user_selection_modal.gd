class_name UserSelectionModal
extends Control

signal user_selection_list_changed(p_data: Array[UserSelectionItemWrapper])
signal modal_closed()

# Managed nodes
var user_selection_item_nlist: VBoxContainer
var confirm_button: Button
# Prefabs
var prefab_user_selection_item: PackedScene
# Data
var user_selection_item_wrapper_list: Array[UserSelectionItemWrapper]

# Base methods

func set_up(p_initial_selected_user_list: Array[DB.DBUser]):
	# Internal nodes
	user_selection_item_nlist = $MarginContainer/UserListAndHeader/MarginContainer/ScrollContainer/UserSelectionList
	confirm_button = $MarginContainer/UserListAndHeader/ConfirmButton
	
	# Prefabs
	prefab_user_selection_item = load(SceneMain.instance.manager.resource.prefab.user_selection_item)
	
	# Signals
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	
	# Misc	
	for i in DB.user_list.size():
		var user: DB.DBUser = DB.user_list[i]
		var user_is_selected: bool = false
		
		for selected_user in p_initial_selected_user_list:
			if selected_user.user_name == user.user_name:
				user_is_selected = true
				break
		
		var new_item: UserSelectionItem = prefab_user_selection_item.instantiate()
		user_selection_item_nlist.add_child(new_item)
		new_item.set_up(i, user.user_name, user_is_selected, self)
		
		var new_user_selection_item_wrapper := UserSelectionItemWrapper.new(
			new_item,
			user,
			user_is_selected
		)
		user_selection_item_wrapper_list.append(new_user_selection_item_wrapper)
		user_selection_list_changed.emit(user_selection_item_wrapper_list)


# Public methods

func toggle_item_selection(p_index: int):
	var new_selected_state: bool = !user_selection_item_wrapper_list[p_index].is_selected
	user_selection_item_wrapper_list[p_index].is_selected = new_selected_state
	
	var selected_user_list: Array[DB.DBUser] = []
	for item in user_selection_item_wrapper_list:
		if !item.is_selected:
			continue
		selected_user_list.append(item.user)
	user_selection_list_changed.emit(selected_user_list)


# Signals

func _on_confirm_button_pressed():
	modal_closed.emit()
	queue_free()


# Subclasses

class UserSelectionItemWrapper:
	var user: DB.DBUser
	var is_selected: bool
	var user_selection_item: UserSelectionItem
	
	func _init(
		p_user_selection_item: UserSelectionItem,
		p_user: DB.DBUser,
		p_is_selected: bool) -> void:
		
		user_selection_item = p_user_selection_item
		user = p_user
		is_selected = p_is_selected
