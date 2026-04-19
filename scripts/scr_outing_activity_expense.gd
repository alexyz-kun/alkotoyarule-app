class_name OutingActivityExpense
extends Control

# Internal nodes
var recipient_label: Label
var recipient_edit_button: Button
var activity_expense_item_list: VBoxContainer
# Prefabs
var prefab_user_selection_modal: PackedScene
# Data
var recipient_list: Array[DB.DBUser]
var user_selection_modal: UserSelectionModal

# Base methods

func set_up():
	recipient_label = $HBoxContainer/RecipientLabel
	recipient_edit_button = $HBoxContainer/MarginContainer/Button
	activity_expense_item_list = $MarginContainer/ActivityExpenseItemList
	
	prefab_user_selection_modal = load(SceneMain.instance.manager.resource.prefab.user_selection_modal)
	
	# Signals
	recipient_edit_button.pressed.connect(_on_recipient_edit_button_pressed)


# Signals

func _on_recipient_edit_button_pressed():
	if user_selection_modal:
		return
	
	var new_user_selection_modal: UserSelectionModal = prefab_user_selection_modal.instantiate()
	user_selection_modal = new_user_selection_modal
	
	var curr_scene: SceneMonetary = SceneMain.instance.active_scene as SceneMonetary
	curr_scene.root_control.add_child(user_selection_modal)
	user_selection_modal.position = get_viewport().get_mouse_position()
	
	user_selection_modal.set_up(recipient_list)
	user_selection_modal.user_selection_list_changed.connect(_on_recipient_list_changed)


func _on_user_selection_modal_closed():
	user_selection_modal.user_selection_list_changed.disconnect(_on_recipient_list_changed)
	user_selection_modal = null


func _on_recipient_list_changed(p_new_recipient_list: Array[DB.DBUser]):
	recipient_list = p_new_recipient_list
	var recipient_names: String = ""
	var recipient_count: int = recipient_list.size()
	for i in recipient_count:
		var recipient: DB.DBUser = recipient_list[i]
		recipient_names += recipient.user_name.to_lower()
		if i < recipient_count - 2:
			recipient_names += ", "
		elif i == recipient_count - 2:
			recipient_names += ", & "
	recipient_label.text = recipient_names
