class_name OutingComponent
extends Control

# Nodes
var outing_name_label: LineEdit
var outing_date_time_label: LineEdit
var activity_nlist: VBoxContainer
var transfer_detail_nlist: VBoxContainer
var transfer_summary_nlist: VBoxContainer
var new_activity_button: Button
# Prefabs
var prefab_activity: PackedScene
# Data
var activity_list: Array[OutingActivityComponent]

# Base methods

func set_up():
	outing_date_time_label = $Header/OutingName
	outing_date_time_label = $Header/DateTime
	activity_nlist = $SubItemList/ActivitiesAndTransfers/Activities/ActivityListAndFooter/ActivityList
	transfer_detail_nlist = $SubItemList/ActivitiesAndTransfers/TranferDetails/MarginContainer/TransferDetailList
	transfer_summary_nlist = $SubItemList/ActivitiesAndTransfers/TranferSummary/MarginContainer/TransferSummaryList
	new_activity_button = $SubItemList/ActivitiesAndTransfers/Activities/ActivityListAndFooter/NewActivityButton
	# Prefabs
	prefab_activity = load(ResourcePath.screen.monetary.ui_outing_activity)
	
	new_activity_button.pressed.connect(_on_new_activity_button_pressed)


# Signals

func _on_new_activity_button_pressed():
	var new_activity: OutingActivityComponent = prefab_activity.instantiate()
	activity_nlist.add_child(new_activity)
	activity_list.append(new_activity)
	new_activity.set_up(activity_list.size())
