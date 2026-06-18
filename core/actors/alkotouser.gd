class_name AlkotoUser

var name: String
var pronouns: Array[GlobalEnum.Pronoun]
var birthdate: DateTimeLong
var discord_id: String
var bank_account: String
var bank_account_number: String

func _init(
	p_name: String,
	p_birthdate: DateTimeLong,
	p_discord_id: String,
	p_bank_account: String,
	p_bank_account_number: String) -> void:
	
	name = p_name
	birthdate = p_birthdate
	discord_id = p_discord_id
	bank_account = p_bank_account
	bank_account_number = p_bank_account_number

#region Public methods

static func from_dict(dict: Dictionary) -> AlkotoUser:
	return AlkotoUser.new(
		dict.name,
		DateTimeLong.from_dict(dict.birthdate),
		dict.discord_id,
		dict.bank_account,
		dict.bank_account_number
	)


func as_dict() -> Dictionary:
	var pronoun_strings: Array[String] = []
	for pronoun in pronouns:
		pronoun_strings.push_back(GlobalEnum.get_pronoun_as_string(pronoun))
	
	return {"name": name, "pronouns": pronoun_strings, "birthdate": birthdate.as_dict(), "discord_id": discord_id, "bank_account": bank_account, "bank_account_number": bank_account_number}

#endregion
