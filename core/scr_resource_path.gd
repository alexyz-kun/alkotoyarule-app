class_name ResourcePath

static var common := CommonResourcePath.new()
static var screen := ScreenResourcePath.new()
static var monetary := MonetaryScreenResourcePath.new()

# Subclasses

class CommonResourcePath:
	var audio
	var font
	var prefab := PrefabResourcePath.new()
	var texture
	
	class AudioResourcePath:
		var music
		var sound
		
		class MusicResourcePath:
			var example
		
		class SoundResourcePath:
			var example
	
	class PrefabResourcePath:
		var ui := UIPrefabResourcePath.new()
	
	class UIPrefabResourcePath:
		var selection_modal: String = "res://common/prefabs/ui/user_selection_modal/ui_selection_modal.tscn"
		var selection_item: String = "res://common/prefabs/ui/user_selection_item/ui_selection_item.tscn"


class ScreenResourcePath:
	var main
	var monetary := MonetaryScreenResourcePath.new()
	var work_manager


class MonetaryScreenResourcePath:
	var scene: String = "res://screens/monetary/screen_monetary.tscn"
	
	var ui_outing: String = "res://screens/monetary/prefabs/ui_outing.tscn"
	var ui_outing_activity: String = "res://screens/monetary/prefabs/ui_outing_activity.tscn"
	var ui_outing_activity_expense: String = "res://screens/monetary/prefabs/ui_outing_activity_expense.tscn"
	var ui_outing_activity_expense_item: String = "res://screens/monetary/prefabs/ui_outing_activity_expense_item.tscn"
