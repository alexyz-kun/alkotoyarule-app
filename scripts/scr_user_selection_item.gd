class_name UserSelectionItem
extends Control

const CHECK_UNSELECTED_ALPHA: float = 0.2

# Internal nodes
var name_label: Label
var bg: Panel
var check_icon: TextureRect
# External nodes
var parent_modal: UserSelectionModal
# Data
var index: int
var is_selected: bool
var is_hovered: bool

# Base methods

func set_up(p_index: int, p_name: String, p_is_selected: bool, p_parent_modal: UserSelectionModal):
	# Internal nodes
	name_label = $HBoxContainer/MarginContainer2/Name
	bg = $BG
	check_icon = $HBoxContainer/MarginContainer/Check
	
	# External nodes
	parent_modal = p_parent_modal
	
	# Signals
	SceneMain.instance.manager.input.lmb_released.connect(_on_lmb_released)
	mouse_entered.connect(_on_cursor_entered)
	mouse_exited.connect(_on_cursor_exited)
	
	# Misc
	index = p_index
	name_label.text = p_name
	is_selected = p_is_selected
	
	bg.self_modulate.a = 0.0
	check_icon.self_modulate.a = 1.0 if p_is_selected else CHECK_UNSELECTED_ALPHA


# Signals

func _on_lmb_released():
	if !is_hovered:
		return
	is_selected = !is_selected
	check_icon.self_modulate.a = 1.0 if is_selected else CHECK_UNSELECTED_ALPHA
	parent_modal.toggle_item_selection(index)


func _on_cursor_entered():
	is_hovered = true
	bg.self_modulate.a = 1.0


func _on_cursor_exited():
	is_hovered = false
	bg.self_modulate.a = 0.0
