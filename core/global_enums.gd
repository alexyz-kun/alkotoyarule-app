class_name GlobalEnum

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

#region Generic


class Tag:
	var title: String


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


#endregion

#region Outing


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


#endregion
