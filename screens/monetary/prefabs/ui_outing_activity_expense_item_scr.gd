class_name OutingActivityExpenseComponent
extends Control

# Internal nodes
var recipient_label: Label
var recipient_edit_button: Button
var activity_expense_item_nlist: VBoxContainer
var new_activity_expense_item_button: Button
# Prefabs
var prefab_user_selection_modal: PackedScene
var prefab_activity_expense_item: PackedScene
# Data
var recipient_list: Array[AlkotoUser]
var user_selection_modal: UserSelectionModal

# Base methods

func set_up():
	recipient_label = $HBoxContainer/RecipientLabel
	recipient_edit_button = $HBoxContainer/MarginContainer/Button
	activity_expense_item_nlist = $MarginContainer/ActivityExpenseItemListAndFooter/ActivityExpenseItemList
	new_activity_expense_item_button = $MarginContainer/ActivityExpenseItemListAndFooter/NewActivityExpenseItemButton
	
	# Prefabs
	prefab_user_selection_modal = load(ResourcePath.common.prefab.ui.selection_modal)
	prefab_activity_expense_item = load(ResourcePath.screen.monetary.ui_outing_activity_expense_item)
	
	# Signals
	recipient_edit_button.pressed.connect(_on_recipient_edit_button_pressed)
	new_activity_expense_item_button.pressed.connect(_on_new_activity_expense_item_button_pressed)


# Signals

func _on_recipient_edit_button_pressed():
	if user_selection_modal:
		return
	
	var new_user_selection_modal: UserSelectionModal = prefab_user_selection_modal.instantiate()
	user_selection_modal = new_user_selection_modal
	
	var curr_scene: ScreenMonetary = ScreenMain.instance.active_scene as ScreenMonetary
	curr_scene.root_control.add_child(user_selection_modal)
	user_selection_modal.position = get_viewport().get_mouse_position()
	
	user_selection_modal.set_up(recipient_list)
	user_selection_modal.user_selection_list_changed.connect(_on_recipient_list_changed)


func _on_user_selection_modal_closed():
	user_selection_modal.user_selection_list_changed.disconnect(_on_recipient_list_changed)
	user_selection_modal = null


func _on_recipient_list_changed(p_new_recipient_list: Array[AlkotoUser]):
	recipient_list = p_new_recipient_list
	var recipient_names: String = ""
	var recipient_count: int = recipient_list.size()
	for i in recipient_count:
		var recipient: AlkotoUser = recipient_list[i]
		recipient_names += recipient.user_name.to_lower()
		if i < recipient_count - 2:
			recipient_names += ", "
		elif i == recipient_count - 2:
			recipient_names += ", & "
	recipient_label.text = recipient_names


func _on_new_activity_expense_item_button_pressed():
	var new_activity_expense_item: Control = prefab_activity_expense_item.instantiate()
	activity_expense_item_nlist.add_child(new_activity_expense_item)
	pass
