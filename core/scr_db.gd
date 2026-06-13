class_name DB

enum Pronoun {
	HE,
	SHE,
	THEY,
}

enum Platform {
	BLUESKY,
	FURAFFINITY,
	TWITTER,
}

static var user_list: Array[AlkotoUser]
static var client_list: Array[Client]
static var outing_list: Array[Outing]

# Base methods

func _init():
	user_list = [
		AlkotoUser.new("Alex", "5271 6252 95",	"BCA"),
		AlkotoUser.new("Dale", "", "BCA"),
		AlkotoUser.new("Kopi", "9016 0052 443",	"Jenius / BTPN / SMBC"),
		AlkotoUser.new("Toby", "7645 0177 90", 	"BCA"),
		AlkotoUser.new("Toru", "6043 3466 23", 	"BCA"),
		AlkotoUser.new("Yaki", "7965 3058 82", 	"BCA")
	]


# Subclasses

class Tag:
	var title: String


class AlkotoUser:
	var user_name: String
	var pronoun_list: Array[Pronoun]
	var bank_account: String
	var bank_account_number: String
	
	func _init(
		p_user_name: String,
		p_bank_account_number: String,
		p_bank_account: String) -> void:
		
		user_name = p_user_name
		bank_account = p_bank_account
		bank_account_number = p_bank_account_number


class Client:
	var client_name: String
	var pronoun_list: Array[Pronoun]
	var handle_list: Array[Handle]


class Handle:
	var platform: Platform
	var title: String
	var desc: String
	var url: String


class Work:
	var author: User
	var client: Client
	var index: int
	var tag_list: Array[Tag]
	var discord_channel_id: String
	var trello_ticket_url: String


# Outing data

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
