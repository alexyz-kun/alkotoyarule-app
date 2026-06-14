class_name AlkotoUser

var name: String
var pronoun_list: Array[GlobalEnum.Pronoun]
var discord_id: String
var bank_account: String
var bank_account_number: String


func _init(
	p_name: String,
	p_discord_id: String,
	p_bank_account: String,
	p_bank_account_number: String) -> void:
	
	name = p_name
	discord_id = p_discord_id
	bank_account = p_bank_account
	bank_account_number = p_bank_account_number


static func from_dict(p_dict: Dictionary) -> AlkotoUser:
	var o := AlkotoUser.new(
		p_dict.name,
		p_dict.discord_id,
		p_dict.bank_account,
		p_dict.bank_account_number
	)
	return o
