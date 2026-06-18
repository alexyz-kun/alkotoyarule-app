class_name Client

var id: String
var name: String
var pronouns: Array[GlobalEnum.Pronoun]
var handles: Array[OnlineHandle]


func as_dict() -> Dictionary:
	var pronoun_strings: Array[String] = []
	for pronoun in pronouns:
		pronoun_strings.push_back(GlobalEnum.get_pronoun_as_string(pronoun))
	
	var handle_list: Array[Dictionary] = []
	for handle in handles:
		handle_list.push_back(handle.as_dict())
	
	return {"id": id, "name": name, "pronouns": pronoun_strings, "handles": handles}
