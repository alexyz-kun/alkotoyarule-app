class_name GlobalEnum

enum Language {
	ID,
	EN,
}


enum Pronoun {
	HE,
	SHE,
	THEY,
}


static func get_pronoun_as_string(p_pronoun: Pronoun) -> String:
	match p_pronoun:
		Pronoun.HE:
			return "he"
		Pronoun.SHE:
			return "she"
		Pronoun.THEY:
			return "they"
		_:
			return "they"
