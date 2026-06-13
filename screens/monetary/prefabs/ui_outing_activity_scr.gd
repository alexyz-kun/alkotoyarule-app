class_name OutingActivityComponent
extends Control

# Internal nodes
var index_label: Label
var name_field: LineEdit
var new_expense_button: Button
var expense_nlist: VBoxContainer
# Prefabs
var prefab_expense: PackedScene
# Data
var index: int
var expense_list: Array[OutingActivityExpenseComponent]

# Base methods

func set_up(p_index: int):
	index_label = $ActivityInfo/CircledNumber/Number
	name_field = $ActivityInfo/MarginContainer/Activity
	new_expense_button = $MarginContainer/ExpenseListAndFooter/NewExpenseButton
	expense_nlist = $MarginContainer/ExpenseListAndFooter/ExpenseList
	
	# Prefabs
	prefab_expense = load(ResourcePath.screen.monetary.ui_outing_activity_expense)
	
	# Signals
	new_expense_button.pressed.connect(_on_new_expense_button_pressed)
	
	# Misc
	index_label.text = "%d" % p_index


# Signals

func _on_new_expense_button_pressed():
	var new_expense: OutingActivityExpenseComponent = prefab_expense.instantiate()
	expense_nlist.add_child(new_expense)
	expense_list.append(new_expense)
	new_expense.set_up()
