class_name DB

static var user_list: Array[DBUser]
static var outing_list: Array[DBOuting]

# Base methods

func _init() -> void:
	_populate_db()


# Private methods

func _populate_db():
	user_list = [
		DBUser.new("Alex", "5271 6252 95",	"BCA"),
		DBUser.new("Dale", "", "BCA"),
		DBUser.new("Kopi", "9016 0052 443",	"Jenius / BTPN / SMBC"),
		DBUser.new("Toby", "7645 0177 90", 	"BCA"),
		DBUser.new("Toru", "6043 3466 23", 	"BCA"),
		DBUser.new("Yaki", "7965 3058 82", 	"BCA")
	]


# Subclasses

class DBUser:
	var user_name: String
	var bank_account: String
	var bank_account_number: String
	
	func _init(
		p_user_name: String,
		p_bank_account_number: String,
		p_bank_account: String) -> void:
		
		user_name = p_user_name
		bank_account = p_bank_account
		bank_account_number = p_bank_account_number

class DBOuting:
	var date: String
	var participants: Array[DBUser]
	var activity_list: Array[OutingActivity]
	var pending_transfer_list: Array[DBPendingTransfer]

class DBOutingActivity:
	var activity_name: String
	var activity_expense_list: Array[DBActivityExpense]

class DBActivityExpense:
	var paying_user: DBUser
	var benefiting_user_list: Array[DBUser]
	var expense_item_list: Array

class DBExpenseItem:
	var item_name: String
	var price: int
	var price_per_person: int

class DBPendingTransfer:
	var user_to_send: DBUser
	var user_to_receive: DBUser
	var amount_owed: int
