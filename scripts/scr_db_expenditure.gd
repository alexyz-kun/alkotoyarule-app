class_name DB

var user_list: Array
var outing_list: Array[Outing]

class User:
	var user_name: String
	var bank_account: String
	var bank_account_number: String

class Outing:
	var date: String
	var participants: Array[User]
	var activity_list: Array[OutingActivity]
	var pending_transfer_list: Array[PendingTransfer]

class OutingActivity:
	var activity_name: String
	var activity_expense_list: Array[ActivityExpense]

class ActivityExpense:
	var paying_user: User
	var benefiting_user_list: Array[User]
	var expense_item_list: Array

class ExpenseItem:
	var item_name: String
	var price: int
	var price_per_person: int

class PendingTransfer:
	var user_to_send: User
	var user_to_receive: User
	var amount_owed: int
